#include <node_api.h>
#include <stdint.h>
#include <string.h>

#include <cstddef>
#include <limits>
#include <string>
#include <unordered_map>
#include <vector>

namespace {

enum OpCode : uint8_t {
  OP_HALT = 0x00,
  OP_PUSH_IMM8 = 0x01,
  OP_PUSH_IMM16 = 0x02,
  OP_PUSH_IMM32 = 0x03,
  OP_PUSH_IMM64 = 0x04,
  OP_PUSH_REG = 0x05,
  OP_POP_REG = 0x06,
  OP_ADD = 0x07,
  OP_SUB = 0x08,
  OP_MUL = 0x09,
  OP_DIV = 0x0A,
  OP_XOR = 0x0B,
  OP_AND = 0x0C,
  OP_OR = 0x0D,
  OP_CMP_EQ = 0x0E,
  OP_CMP_LT = 0x0F,
  OP_JMP = 0x10,
  OP_JZ = 0x11,
  OP_JNZ = 0x12,
  OP_LOAD8 = 0x13,
  OP_STORE8 = 0x14,
  OP_LOAD16 = 0x15,
  OP_STORE16 = 0x16,
  OP_LOAD32 = 0x17,
  OP_STORE32 = 0x18,
  OP_LOAD64 = 0x19,
  OP_STORE64 = 0x1A,
  OP_SHL = 0x1B,
  OP_SHR = 0x1C,
  OP_DUP = 0x1D,
  OP_SWAP = 0x1E,
  OP_DROP = 0x1F
};

struct DecodedInst {
  OpCode op;
  uint64_t imm;
  uint8_t reg;
  int32_t rel;
  size_t byte_offset;
  size_t next_byte_offset;
  size_t target_index;
};

struct MemRegion {
  uint8_t* begin;
  size_t size;
};

struct VMContext {
  uint64_t regs[16];
  bool zf;
  std::vector<uint64_t> stack;
  std::vector<MemRegion> mem_regions;
};

static uint8_t rol8(uint8_t value, uint8_t shift) {
  shift = shift & 7;
  return static_cast<uint8_t>((value << shift) | (value >> (8 - shift)));
}

static napi_value ThrowError(napi_env env) {
  napi_throw_error(env, nullptr, "E");
  napi_value result;
  napi_get_undefined(env, &result);
  return result;
}

static std::vector<uint8_t> PlaceholderVmEncrypt(const uint8_t* source, size_t source_len) {
  std::vector<uint8_t> payload(source_len);
  uint8_t state = 0x6d;
  for (size_t i = 0; i < source_len; i++) {
    state = static_cast<uint8_t>((state ^ 33 + 17 + (i & 0x0F)) & 0xFF);
    payload[i] = rol8(static_cast<uint8_t>(source[i] ^ state), static_cast<uint8_t>((i % 5) + 1));
  }

  std::vector<uint8_t> out(4 + payload.size());
  out[0] = 'S';
  out[1] = 'V';
  out[2] = 'E';
  out[3] = '4';
  if (!payload.empty()) {
    memcpy(out.data() + 4, payload.data(), payload.size());
  }
  return out;
}

// Scratch/state block used by the single VM program that implements SVE4 encryption.
struct Sve4VmState {
  // Final padded length written by VM, used by host to trim output.
  uint64_t padded_len;
  // Chained 256-bit key (8 x 32-bit words, big-endian logical layout).
  uint32_t key[8];
  // Feistel left/right halves and expanded key schedule workspace.
  uint32_t l[8];
  uint32_t r[8];
  uint32_t a[8];
  uint32_t rk[12];
  uint32_t f[8];
  // Running sums and temporary slots used by round operations.
  uint32_t ksum;
  uint32_t sum;
  uint32_t tmp0;
  uint32_t tmp1;
};

static bool GetSve4VmEncryptProgram(const std::vector<DecodedInst>** out_program);
static bool ExecuteProgram(const std::vector<DecodedInst>& program, VMContext* ctx, size_t max_steps);

static bool VmEncryptSve4(
    const uint8_t* input,
    size_t input_len,
    std::vector<uint8_t>* out) {
  if (out == nullptr) {
    return false;
  }

  if (input == nullptr && input_len != 0) {
    return false;
  }
  if (input_len > std::numeric_limits<size_t>::max() - 64) {
    return false;
  }

  const size_t work_capacity = input_len + 64;
  std::vector<uint8_t> padded(work_capacity, 0);
  std::vector<uint8_t> cipher(work_capacity, 0);

  const std::vector<DecodedInst>* vm_program = nullptr;
  if (!GetSve4VmEncryptProgram(&vm_program)) {
    return false;
  }

  Sve4VmState state;
  memset(&state, 0, sizeof(state));

  VMContext vm_ctx;
  memset(vm_ctx.regs, 0, sizeof(vm_ctx.regs));
  vm_ctx.zf = false;
  // Register contract for this VM program:
  // r15=state, r14=input, r13=input_len, r12=padded_buf, r11=cipher_buf.
  vm_ctx.regs[15] = reinterpret_cast<uint64_t>(&state);
  vm_ctx.regs[14] = reinterpret_cast<uint64_t>(input);
  vm_ctx.regs[13] = static_cast<uint64_t>(input_len);
  vm_ctx.regs[12] = reinterpret_cast<uint64_t>(padded.data());
  vm_ctx.regs[11] = reinterpret_cast<uint64_t>(cipher.data());
  vm_ctx.stack.reserve(2048);
  vm_ctx.mem_regions.push_back(MemRegion{
      reinterpret_cast<uint8_t*>(&state),
      sizeof(state)});
  if (input_len != 0) {
    vm_ctx.mem_regions.push_back(MemRegion{
        const_cast<uint8_t*>(input),
        input_len});
  }
  vm_ctx.mem_regions.push_back(MemRegion{
      padded.data(),
      padded.size()});
  vm_ctx.mem_regions.push_back(MemRegion{
      cipher.data(),
      cipher.size()});

  // Bound VM steps to avoid infinite loops while allowing large files.
  size_t max_steps = 10000000;
  if (input_len <= (std::numeric_limits<size_t>::max() / 256)) {
    max_steps += input_len * 256;
  } else {
    return false;
  }

  // Execute complete encrypt pipeline in one VM run.
  if (!ExecuteProgram(*vm_program, &vm_ctx, max_steps)) {
    return false;
  }
  // VM must output a non-zero 64-byte-aligned padded length within buffer bounds.
  if (state.padded_len == 0 || state.padded_len > cipher.size() || (state.padded_len % 64) != 0) {
    return false;
  }

  // Prefix SVE4 header and copy VM-generated ciphertext payload.
  out->assign(4 + static_cast<size_t>(state.padded_len), 0);
  (*out)[0] = 'S';
  (*out)[1] = 'V';
  (*out)[2] = 'E';
  (*out)[3] = '4';
  if (state.padded_len != 0) {
    memcpy(out->data() + 4, cipher.data(), static_cast<size_t>(state.padded_len));
  }
  return true;
}

template <typename T>
static void WriteLE(std::vector<uint8_t>* dst, T value) {
  for (size_t i = 0; i < sizeof(T); i++) {
    dst->push_back(static_cast<uint8_t>((static_cast<uint64_t>(value) >> (8 * i)) & 0xFF));
  }
}

template <typename T>
static bool ReadLE(const std::vector<uint8_t>& src, size_t* pc, T* out) {
  if (*pc + sizeof(T) > src.size()) {
    return false;
  }
  uint64_t value = 0;
  for (size_t i = 0; i < sizeof(T); i++) {
    value |= (static_cast<uint64_t>(src[*pc + i]) << (8 * i));
  }
  *out = static_cast<T>(value);
  *pc += sizeof(T);
  return true;
}

class BytecodeBuilder {
 public:
  size_t Mark() const { return code_.size(); }

  size_t EmitPushImm8(uint8_t v) {
    EmitOp(OP_PUSH_IMM8);
    size_t pos = code_.size();
    code_.push_back(v);
    return pos;
  }

  size_t EmitPushImm32(uint32_t v) {
    EmitOp(OP_PUSH_IMM32);
    size_t pos = code_.size();
    WriteLE<uint32_t>(&code_, v);
    return pos;
  }

  void EmitPushReg(uint8_t reg) {
    EmitOp(OP_PUSH_REG);
    code_.push_back(reg);
  }

  void EmitPopReg(uint8_t reg) {
    EmitOp(OP_POP_REG);
    code_.push_back(reg);
  }

  void EmitOpOnly(OpCode op) { EmitOp(op); }

  size_t EmitJumpPlaceholder(OpCode op) {
    EmitOp(op);
    size_t rel_pos = code_.size();
    WriteLE<int32_t>(&code_, 0);
    return rel_pos;
  }

  bool PatchJump(size_t rel_pos, size_t target_offset) {
    if (rel_pos + sizeof(int32_t) > code_.size()) {
      return false;
    }
    int64_t rel64 = static_cast<int64_t>(target_offset) - static_cast<int64_t>(rel_pos + sizeof(int32_t));
    if (rel64 < std::numeric_limits<int32_t>::min() || rel64 > std::numeric_limits<int32_t>::max()) {
      return false;
    }
    int32_t rel = static_cast<int32_t>(rel64);
    for (size_t i = 0; i < sizeof(int32_t); i++) {
      code_[rel_pos + i] = static_cast<uint8_t>((static_cast<uint32_t>(rel) >> (8 * i)) & 0xFF);
    }
    return true;
  }

  std::vector<uint8_t> TakeCode() { return std::move(code_); }

 private:
  void EmitOp(OpCode op) { code_.push_back(static_cast<uint8_t>(op)); }

  std::vector<uint8_t> code_;
};

static bool CompileProgram(const std::vector<uint8_t>& bytecode, std::vector<DecodedInst>* out) {
  out->clear();

  std::unordered_map<size_t, size_t> byte_to_inst;
  size_t pc = 0;

  while (pc < bytecode.size()) {
    DecodedInst inst;
    memset(&inst, 0, sizeof(inst));
    inst.byte_offset = pc;

    uint8_t op_raw = 0;
    if (!ReadLE<uint8_t>(bytecode, &pc, &op_raw)) {
      return false;
    }
    inst.op = static_cast<OpCode>(op_raw);

    switch (inst.op) {
      case OP_PUSH_IMM8: {
        uint8_t v = 0;
        if (!ReadLE<uint8_t>(bytecode, &pc, &v)) {
          return false;
        }
        inst.imm = v;
        break;
      }
      case OP_PUSH_IMM16: {
        uint16_t v = 0;
        if (!ReadLE<uint16_t>(bytecode, &pc, &v)) {
          return false;
        }
        inst.imm = v;
        break;
      }
      case OP_PUSH_IMM32: {
        uint32_t v = 0;
        if (!ReadLE<uint32_t>(bytecode, &pc, &v)) {
          return false;
        }
        inst.imm = v;
        break;
      }
      case OP_PUSH_IMM64: {
        uint64_t v = 0;
        if (!ReadLE<uint64_t>(bytecode, &pc, &v)) {
          return false;
        }
        inst.imm = v;
        break;
      }
      case OP_PUSH_REG:
      case OP_POP_REG: {
        uint8_t reg = 0;
        if (!ReadLE<uint8_t>(bytecode, &pc, &reg)) {
          return false;
        }
        inst.reg = reg;
        break;
      }
      case OP_JMP:
      case OP_JZ:
      case OP_JNZ: {
        int32_t rel = 0;
        if (!ReadLE<int32_t>(bytecode, &pc, &rel)) {
          return false;
        }
        inst.rel = rel;
        break;
      }
      case OP_HALT:
      case OP_ADD:
      case OP_SUB:
      case OP_MUL:
      case OP_DIV:
      case OP_XOR:
      case OP_AND:
      case OP_OR:
      case OP_CMP_EQ:
      case OP_CMP_LT:
      case OP_LOAD8:
      case OP_STORE8:
      case OP_LOAD16:
      case OP_STORE16:
      case OP_LOAD32:
      case OP_STORE32:
      case OP_LOAD64:
      case OP_STORE64:
      case OP_SHL:
      case OP_SHR:
      case OP_DUP:
      case OP_SWAP:
      case OP_DROP:
        break;
      default:
        return false;
    }

    inst.next_byte_offset = pc;
    byte_to_inst[inst.byte_offset] = out->size();
    out->push_back(inst);
  }

  byte_to_inst[bytecode.size()] = out->size();

  for (size_t i = 0; i < out->size(); i++) {
    DecodedInst& inst = (*out)[i];
    if (inst.op != OP_JMP && inst.op != OP_JZ && inst.op != OP_JNZ) {
      continue;
    }

    int64_t target_byte =
        static_cast<int64_t>(inst.next_byte_offset) + static_cast<int64_t>(inst.rel);
    if (target_byte < 0) {
      return false;
    }

    auto it = byte_to_inst.find(static_cast<size_t>(target_byte));
    if (it == byte_to_inst.end()) {
      return false;
    }
    inst.target_index = it->second;
  }

  return true;
}

static bool VmPush(VMContext* ctx, uint64_t value) {
  if (ctx->stack.size() > (1u << 20)) {
    return false;
  }
  ctx->stack.push_back(value);
  return true;
}

static bool VmPop(VMContext* ctx, uint64_t* value) {
  if (ctx->stack.empty()) {
    return false;
  }
  *value = ctx->stack.back();
  ctx->stack.pop_back();
  return true;
}

static bool ResolveMemPtr(VMContext* ctx, uint64_t addr, size_t width, uint8_t** out_ptr) {
  if (width == 0) {
    return false;
  }
  if (addr > std::numeric_limits<uint64_t>::max() - width) {
    return false;
  }

  for (size_t i = 0; i < ctx->mem_regions.size(); i++) {
    MemRegion& region = ctx->mem_regions[i];
    uint64_t begin = reinterpret_cast<uint64_t>(region.begin);
    uint64_t end = begin + region.size;
    if (addr >= begin && (addr + width) <= end) {
      *out_ptr = region.begin + (addr - begin);
      return true;
    }
  }

  return false;
}

template <typename T>
static bool VmLoad(VMContext* ctx) {
  uint64_t addr = 0;
  if (!VmPop(ctx, &addr)) {
    return false;
  }

  uint8_t* ptr = nullptr;
  if (!ResolveMemPtr(ctx, addr, sizeof(T), &ptr)) {
    return false;
  }

  T value = 0;
  memcpy(&value, ptr, sizeof(T));
  return VmPush(ctx, static_cast<uint64_t>(value));
}

template <typename T>
static bool VmStore(VMContext* ctx) {
  uint64_t addr = 0;
  uint64_t value = 0;
  if (!VmPop(ctx, &addr)) {
    return false;
  }
  if (!VmPop(ctx, &value)) {
    return false;
  }

  uint8_t* ptr = nullptr;
  if (!ResolveMemPtr(ctx, addr, sizeof(T), &ptr)) {
    return false;
  }

  T out = static_cast<T>(value);
  memcpy(ptr, &out, sizeof(T));
  return true;
}

static bool ExecuteProgram(const std::vector<DecodedInst>& program, VMContext* ctx, size_t max_steps) {
  size_t pc = 0;
  size_t steps = 0;

  while (pc < program.size()) {
    if (steps++ > max_steps) {
      return false;
    }

    const DecodedInst& ins = program[pc];

    switch (ins.op) {
      case OP_HALT:
        return true;
      case OP_PUSH_IMM8:
      case OP_PUSH_IMM16:
      case OP_PUSH_IMM32:
      case OP_PUSH_IMM64:
        if (!VmPush(ctx, ins.imm)) {
          return false;
        }
        break;
      case OP_PUSH_REG:
        if (ins.reg >= 16) {
          return false;
        }
        if (!VmPush(ctx, ctx->regs[ins.reg])) {
          return false;
        }
        break;
      case OP_POP_REG: {
        if (ins.reg >= 16) {
          return false;
        }
        uint64_t v = 0;
        if (!VmPop(ctx, &v)) {
          return false;
        }
        ctx->regs[ins.reg] = v;
        break;
      }
      case OP_ADD:
      case OP_SUB:
      case OP_MUL:
      case OP_DIV:
      case OP_XOR:
      case OP_AND:
      case OP_OR:
      case OP_SHL:
      case OP_SHR: {
        uint64_t rhs = 0;
        uint64_t lhs = 0;
        if (!VmPop(ctx, &rhs) || !VmPop(ctx, &lhs)) {
          return false;
        }
        uint64_t out = 0;
        switch (ins.op) {
          case OP_ADD:
            out = lhs + rhs;
            break;
          case OP_SUB:
            out = lhs - rhs;
            break;
          case OP_MUL:
            out = lhs * rhs;
            break;
          case OP_DIV:
            out = (rhs == 0) ? 0 : (lhs / rhs);
            break;
          case OP_XOR:
            out = lhs ^ rhs;
            break;
          case OP_AND:
            out = lhs & rhs;
            break;
          case OP_OR:
            out = lhs | rhs;
            break;
          case OP_SHL:
            out = lhs << (rhs & 63);
            break;
          case OP_SHR:
            out = lhs >> (rhs & 63);
            break;
          default:
            break;
        }
        if (!VmPush(ctx, out)) {
          return false;
        }
        break;
      }
      case OP_CMP_EQ:
      case OP_CMP_LT: {
        uint64_t rhs = 0;
        uint64_t lhs = 0;
        if (!VmPop(ctx, &rhs) || !VmPop(ctx, &lhs)) {
          return false;
        }
        ctx->zf = (ins.op == OP_CMP_EQ) ? (lhs == rhs) : (lhs < rhs);
        break;
      }
      case OP_JMP:
        pc = ins.target_index;
        continue;
      case OP_JZ:
        if (ctx->zf) {
          pc = ins.target_index;
          continue;
        }
        break;
      case OP_JNZ:
        if (!ctx->zf) {
          pc = ins.target_index;
          continue;
        }
        break;
      case OP_LOAD8:
        if (!VmLoad<uint8_t>(ctx)) {
          return false;
        }
        break;
      case OP_STORE8:
        if (!VmStore<uint8_t>(ctx)) {
          return false;
        }
        break;
      case OP_LOAD16:
        if (!VmLoad<uint16_t>(ctx)) {
          return false;
        }
        break;
      case OP_STORE16:
        if (!VmStore<uint16_t>(ctx)) {
          return false;
        }
        break;
      case OP_LOAD32:
        if (!VmLoad<uint32_t>(ctx)) {
          return false;
        }
        break;
      case OP_STORE32:
        if (!VmStore<uint32_t>(ctx)) {
          return false;
        }
        break;
      case OP_LOAD64:
        if (!VmLoad<uint64_t>(ctx)) {
          return false;
        }
        break;
      case OP_STORE64:
        if (!VmStore<uint64_t>(ctx)) {
          return false;
        }
        break;
      case OP_DUP: {
        if (ctx->stack.empty()) {
          return false;
        }
        if (!VmPush(ctx, ctx->stack.back())) {
          return false;
        }
        break;
      }
      case OP_SWAP: {
        if (ctx->stack.size() < 2) {
          return false;
        }
        uint64_t a = ctx->stack.back();
        ctx->stack.pop_back();
        uint64_t b = ctx->stack.back();
        ctx->stack.pop_back();
        ctx->stack.push_back(a);
        ctx->stack.push_back(b);
        break;
      }
      case OP_DROP: {
        uint64_t dropped = 0;
        if (!VmPop(ctx, &dropped)) {
          return false;
        }
        break;
      }
      default:
        return false;
    }

    pc += 1;
  }

  return true;
}

// Builds one VM bytecode program that performs:
// 1) PKCS7 padding
// 2) 64-byte block encryption (4 rounds)
// 3) per-block key chaining
// 4) ciphertext writeback
static std::vector<uint8_t> BuildSve4VmEncryptBytecode() {
  BytecodeBuilder b;

  const uint32_t kMask32 = 0xFFFFFFFFu;
  const uint32_t kDelta = 0x70336364u;
  const uint32_t kC1 = 0x62616F7Au;
  const uint32_t kC2 = 0x6F6E6777u;
  const uint32_t kC3 = 0x696E6221u;

  // State field offsets. Keep all cast details inside helpers for readability.
  const size_t kWordBytes = sizeof(uint32_t);
  const size_t kKeyBase = offsetof(Sve4VmState, key);
  const size_t kLBase = offsetof(Sve4VmState, l);
  const size_t kRBase = offsetof(Sve4VmState, r);
  const size_t kABase = offsetof(Sve4VmState, a);
  const size_t kRkBase = offsetof(Sve4VmState, rk);
  const size_t kFBase = offsetof(Sve4VmState, f);
  auto as_off32 = [](size_t off) -> uint32_t {
    return static_cast<uint32_t>(off);
  };
  auto off_word = [&](size_t base, size_t i) -> uint32_t {
    return static_cast<uint32_t>(base + i * kWordBytes);
  };
  auto off_key = [&](size_t i) -> uint32_t { return off_word(kKeyBase, i); };
  auto off_l = [&](size_t i) -> uint32_t { return off_word(kLBase, i); };
  auto off_r = [&](size_t i) -> uint32_t { return off_word(kRBase, i); };
  auto off_a = [&](size_t i) -> uint32_t { return off_word(kABase, i); };
  auto off_rk = [&](size_t i) -> uint32_t { return off_word(kRkBase, i); };
  auto off_f = [&](size_t i) -> uint32_t { return off_word(kFBase, i); };
  const uint32_t off_padded_len = as_off32(offsetof(Sve4VmState, padded_len));
  const uint32_t off_ksum = as_off32(offsetof(Sve4VmState, ksum));
  const uint32_t off_sum = as_off32(offsetof(Sve4VmState, sum));
  const uint32_t off_tmp0 = as_off32(offsetof(Sve4VmState, tmp0));
  const uint32_t off_tmp1 = as_off32(offsetof(Sve4VmState, tmp1));

  // State memory read/write helpers (base register r15).
  auto emit_load32_state = [&](uint32_t off) {
    b.EmitPushReg(15);
    b.EmitPushImm32(off);
    b.EmitOpOnly(OP_ADD);
    b.EmitOpOnly(OP_LOAD32);
  };
  auto emit_store32_state = [&](uint32_t off) {
    b.EmitPushReg(15);
    b.EmitPushImm32(off);
    b.EmitOpOnly(OP_ADD);
    b.EmitOpOnly(OP_STORE32);
  };
  auto emit_store64_state = [&](uint32_t off) {
    b.EmitPushReg(15);
    b.EmitPushImm32(off);
    b.EmitOpOnly(OP_ADD);
    b.EmitOpOnly(OP_STORE64);
  };

  // Generic memory address builders and read/write helpers.
  auto emit_add_reg_and_reg = [&](uint8_t base_reg, uint8_t off_reg) {
    b.EmitPushReg(base_reg);
    b.EmitPushReg(off_reg);
    b.EmitOpOnly(OP_ADD);
  };

  auto emit_load8_base_plus = [&](uint8_t base_reg, uint8_t off_reg, uint32_t imm_add) {
    emit_add_reg_and_reg(base_reg, off_reg);
    if (imm_add != 0) {
      b.EmitPushImm32(imm_add);
      b.EmitOpOnly(OP_ADD);
    }
    b.EmitOpOnly(OP_LOAD8);
  };
  auto emit_store8_base_plus_from_reg = [&](uint8_t value_reg, uint8_t base_reg, uint8_t off_reg, uint32_t imm_add) {
    b.EmitPushReg(value_reg);
    emit_add_reg_and_reg(base_reg, off_reg);
    if (imm_add != 0) {
      b.EmitPushImm32(imm_add);
      b.EmitOpOnly(OP_ADD);
    }
    b.EmitOpOnly(OP_STORE8);
  };
  auto emit_load32_base_plus = [&](uint8_t base_reg, uint8_t off_reg, uint32_t imm_add) {
    emit_add_reg_and_reg(base_reg, off_reg);
    if (imm_add != 0) {
      b.EmitPushImm32(imm_add);
      b.EmitOpOnly(OP_ADD);
    }
    b.EmitOpOnly(OP_LOAD32);
  };
  auto emit_store32_base_plus_from_reg = [&](uint8_t value_reg, uint8_t base_reg, uint8_t off_reg, uint32_t imm_add) {
    b.EmitPushReg(value_reg);
    emit_add_reg_and_reg(base_reg, off_reg);
    if (imm_add != 0) {
      b.EmitPushImm32(imm_add);
      b.EmitOpOnly(OP_ADD);
    }
    b.EmitOpOnly(OP_STORE32);
  };
  auto emit_load64_base_plus_scaled = [&](uint8_t base_reg, uint8_t idx_reg, uint8_t shift_bits) {
    b.EmitPushReg(base_reg);
    b.EmitPushReg(idx_reg);
    b.EmitPushImm8(shift_bits);
    b.EmitOpOnly(OP_SHL);
    b.EmitOpOnly(OP_ADD);
    b.EmitOpOnly(OP_LOAD64);
  };
  auto emit_store64_base_plus_scaled_from_reg = [&](uint8_t value_reg, uint8_t base_reg, uint8_t idx_reg, uint8_t shift_bits) {
    b.EmitPushReg(value_reg);
    b.EmitPushReg(base_reg);
    b.EmitPushReg(idx_reg);
    b.EmitPushImm8(shift_bits);
    b.EmitOpOnly(OP_SHL);
    b.EmitOpOnly(OP_ADD);
    b.EmitOpOnly(OP_STORE64);
  };

  // 32-bit arithmetic helpers (VM arithmetic is 64-bit by default).
  auto emit_mask32 = [&]() {
    b.EmitPushImm32(kMask32);
    b.EmitOpOnly(OP_AND);
  };
  auto emit_add_mask = [&]() {
    b.EmitOpOnly(OP_ADD);
    emit_mask32();
  };
  auto emit_rol_const = [&](uint8_t shift) {
    b.EmitOpOnly(OP_DUP);
    b.EmitPushImm8(shift);
    b.EmitOpOnly(OP_SHL);
    b.EmitOpOnly(OP_SWAP);
    b.EmitPushImm8(static_cast<uint8_t>(32u - shift));
    b.EmitOpOnly(OP_SHR);
    b.EmitOpOnly(OP_OR);
    emit_mask32();
  };
  auto emit_ror_const = [&](uint8_t shift) {
    b.EmitOpOnly(OP_DUP);
    b.EmitPushImm8(shift);
    b.EmitOpOnly(OP_SHR);
    b.EmitOpOnly(OP_SWAP);
    b.EmitPushImm8(static_cast<uint8_t>(32u - shift));
    b.EmitOpOnly(OP_SHL);
    b.EmitOpOnly(OP_OR);
    emit_mask32();
  };
  auto emit_shift_xor = [&](uint8_t shl_bits, uint8_t shr_bits) {
    b.EmitOpOnly(OP_DUP);
    b.EmitPushImm8(shl_bits);
    b.EmitOpOnly(OP_SHL);
    b.EmitOpOnly(OP_SWAP);
    b.EmitPushImm8(shr_bits);
    b.EmitOpOnly(OP_SHR);
    b.EmitOpOnly(OP_XOR);
    emit_mask32();
  };
  // Byte swap helper used for BE<->LE conversion on 32-bit words.
  auto emit_bswap32 = [&]() {
    b.EmitPopReg(0);

    b.EmitPushReg(0);
    b.EmitPushImm8(24);
    b.EmitOpOnly(OP_SHR);
    b.EmitPushImm32(0x000000FFu);
    b.EmitOpOnly(OP_AND);
    b.EmitPopReg(1);

    b.EmitPushReg(0);
    b.EmitPushImm8(8);
    b.EmitOpOnly(OP_SHR);
    b.EmitPushImm32(0x0000FF00u);
    b.EmitOpOnly(OP_AND);
    b.EmitPopReg(2);

    b.EmitPushReg(0);
    b.EmitPushImm8(8);
    b.EmitOpOnly(OP_SHL);
    b.EmitPushImm32(0x00FF0000u);
    b.EmitOpOnly(OP_AND);
    b.EmitPopReg(3);

    b.EmitPushReg(0);
    b.EmitPushImm8(24);
    b.EmitOpOnly(OP_SHL);
    b.EmitPushImm32(0xFF000000u);
    b.EmitOpOnly(OP_AND);
    b.EmitPopReg(4);

    b.EmitPushReg(1);
    b.EmitPushReg(2);
    b.EmitOpOnly(OP_OR);
    b.EmitPushReg(3);
    b.EmitOpOnly(OP_OR);
    b.EmitPushReg(4);
    b.EmitOpOnly(OP_OR);
    emit_mask32();
  };
  // Round/key-schedule helpers for the custom 4-round SVE4 core.
  auto emit_update_key_word = [&](uint32_t dst, uint32_t src1, uint32_t src2, uint8_t rot_bits) {
    emit_load32_state(src1);
    emit_load32_state(src2);
    b.EmitOpOnly(OP_XOR);
    emit_rol_const(rot_bits);
    emit_load32_state(dst);
    emit_add_mask();
    emit_store32_state(dst);
  };
  auto emit_rk_xor3 = [&](uint32_t dst, uint32_t x, uint32_t y, uint32_t z) {
    emit_load32_state(x);
    emit_load32_state(y);
    b.EmitOpOnly(OP_XOR);
    emit_load32_state(z);
    b.EmitOpOnly(OP_XOR);
    emit_store32_state(dst);
  };
  auto emit_rk_xor2_sum_const = [&](uint32_t dst, uint32_t x, uint32_t y, uint32_t add_const) {
    emit_load32_state(x);
    emit_load32_state(y);
    b.EmitOpOnly(OP_XOR);
    emit_load32_state(off_ksum);
    b.EmitPushImm32(add_const);
    emit_add_mask();
    b.EmitOpOnly(OP_XOR);
    emit_store32_state(dst);
  };
  auto emit_rk_add2 = [&](uint32_t dst, uint32_t x, uint32_t y) {
    emit_load32_state(x);
    emit_load32_state(y);
    emit_add_mask();
    emit_store32_state(dst);
  };
  auto emit_rk_xor2 = [&](uint32_t dst, uint32_t x, uint32_t y) {
    emit_load32_state(x);
    emit_load32_state(y);
    b.EmitOpOnly(OP_XOR);
    emit_store32_state(dst);
  };
  auto emit_speck_pair = [&](uint32_t x_off, uint32_t y_off, uint32_t k_off) {
    emit_load32_state(x_off);
    emit_ror_const(8);
    emit_store32_state(off_tmp0);

    emit_load32_state(off_tmp0);
    emit_load32_state(y_off);
    emit_add_mask();
    emit_store32_state(off_tmp0);

    emit_load32_state(off_tmp0);
    emit_load32_state(k_off);
    b.EmitOpOnly(OP_XOR);
    emit_store32_state(off_tmp0);

    emit_load32_state(y_off);
    emit_rol_const(3);
    emit_store32_state(off_tmp1);

    emit_load32_state(off_tmp1);
    emit_load32_state(off_tmp0);
    b.EmitOpOnly(OP_XOR);
    emit_store32_state(off_tmp1);

    emit_load32_state(off_tmp0);
    emit_store32_state(x_off);

    emit_load32_state(off_tmp1);
    emit_store32_state(y_off);
  };

  // Register use in this VM program:
  // r0..r7: loop/math temporaries
  // r9/r10: byte offset / block offset
  // r11..r15: pointers passed from host
  // r0=in_len/64, r1=floor*64, r2=mod, r3=pad, r4=padded_len, r7=immutable padded_len copy.
  b.EmitPushReg(13);
  b.EmitPushImm8(64);
  b.EmitOpOnly(OP_DIV);
  b.EmitPopReg(0);

  b.EmitPushReg(0);
  b.EmitPushImm8(64);
  b.EmitOpOnly(OP_MUL);
  b.EmitPopReg(1);

  b.EmitPushReg(13);
  b.EmitPushReg(1);
  b.EmitOpOnly(OP_SUB);
  b.EmitPopReg(2);

  b.EmitPushImm8(64);
  b.EmitPushReg(2);
  b.EmitOpOnly(OP_SUB);
  b.EmitPopReg(3);

  b.EmitPushReg(13);
  b.EmitPushReg(3);
  b.EmitOpOnly(OP_ADD);
  b.EmitPopReg(4);

  b.EmitPushReg(4);
  emit_store64_state(off_padded_len);
  b.EmitPushReg(4);
  b.EmitPopReg(7);

  // Copy input -> padded, first by 8-byte chunks.
  b.EmitPushReg(13);
  b.EmitPushImm8(8);
  b.EmitOpOnly(OP_DIV);
  b.EmitPopReg(5);  // chunk_count

  b.EmitPushImm8(0);
  b.EmitPopReg(9);  // i = 0

  size_t copy64_loop = b.Mark();
  b.EmitPushReg(9);
  b.EmitPushReg(5);
  b.EmitOpOnly(OP_CMP_LT);
  size_t copy64_end_rel = b.EmitJumpPlaceholder(OP_JNZ);

  emit_load64_base_plus_scaled(14, 9, 3);
  b.EmitPopReg(6);
  emit_store64_base_plus_scaled_from_reg(6, 12, 9, 3);

  b.EmitPushReg(9);
  b.EmitPushImm8(1);
  b.EmitOpOnly(OP_ADD);
  b.EmitPopReg(9);
  size_t copy64_jmp_rel = b.EmitJumpPlaceholder(OP_JMP);

  size_t copy64_end = b.Mark();
  b.PatchJump(copy64_end_rel, copy64_end);
  b.PatchJump(copy64_jmp_rel, copy64_loop);

  // Copy tail bytes.
  b.EmitPushReg(5);
  b.EmitPushImm8(3);
  b.EmitOpOnly(OP_SHL);
  b.EmitPopReg(9);  // byte offset

  size_t tail_loop = b.Mark();
  b.EmitPushReg(9);
  b.EmitPushReg(13);
  b.EmitOpOnly(OP_CMP_LT);
  size_t tail_end_rel = b.EmitJumpPlaceholder(OP_JNZ);

  emit_load8_base_plus(14, 9, 0);
  b.EmitPopReg(6);
  emit_store8_base_plus_from_reg(6, 12, 9, 0);

  b.EmitPushReg(9);
  b.EmitPushImm8(1);
  b.EmitOpOnly(OP_ADD);
  b.EmitPopReg(9);
  size_t tail_jmp_rel = b.EmitJumpPlaceholder(OP_JMP);

  size_t tail_end = b.Mark();
  b.PatchJump(tail_end_rel, tail_end);
  b.PatchJump(tail_jmp_rel, tail_loop);

  // Fill PKCS7 padding.
  b.EmitPushReg(13);
  b.EmitPopReg(9);

  size_t pad_loop = b.Mark();
  b.EmitPushReg(9);
  b.EmitPushReg(7);
  b.EmitOpOnly(OP_CMP_LT);
  size_t pad_end_rel = b.EmitJumpPlaceholder(OP_JNZ);

  emit_store8_base_plus_from_reg(3, 12, 9, 0);

  b.EmitPushReg(9);
  b.EmitPushImm8(1);
  b.EmitOpOnly(OP_ADD);
  b.EmitPopReg(9);
  size_t pad_jmp_rel = b.EmitJumpPlaceholder(OP_JMP);

  size_t pad_end = b.Mark();
  b.PatchJump(pad_end_rel, pad_end);
  b.PatchJump(pad_jmp_rel, pad_loop);

  // key = 00..1f (BE words).
  b.EmitPushImm32(0x00010203u);
  emit_store32_state(off_key(0));
  b.EmitPushImm32(0x04050607u);
  emit_store32_state(off_key(1));
  b.EmitPushImm32(0x08090A0Bu);
  emit_store32_state(off_key(2));
  b.EmitPushImm32(0x0C0D0E0Fu);
  emit_store32_state(off_key(3));
  b.EmitPushImm32(0x10111213u);
  emit_store32_state(off_key(4));
  b.EmitPushImm32(0x14151617u);
  emit_store32_state(off_key(5));
  b.EmitPushImm32(0x18191A1Bu);
  emit_store32_state(off_key(6));
  b.EmitPushImm32(0x1C1D1E1Fu);
  emit_store32_state(off_key(7));

  // offset = 0.
  b.EmitPushImm8(0);
  b.EmitPopReg(10);

  size_t block_loop = b.Mark();
  b.EmitPushReg(10);
  b.EmitPushReg(7);
  b.EmitOpOnly(OP_CMP_LT);
  size_t block_end_rel = b.EmitJumpPlaceholder(OP_JNZ);

  // L/R = BE32(padded[offset + ...])
  for (size_t i = 0; i < 8; i++) {
    emit_load32_base_plus(12, 10, static_cast<uint32_t>(i * 4));
    emit_bswap32();
    emit_store32_state(off_l(i));
  }
  for (size_t i = 0; i < 8; i++) {
    emit_load32_base_plus(12, 10, static_cast<uint32_t>((8 + i) * 4));
    emit_bswap32();
    emit_store32_state(off_r(i));
  }

  for (size_t i = 0; i < 8; i++) {
    emit_load32_state(off_key(i));
    emit_store32_state(off_a(i));
  }

  b.EmitPushImm32(0x73756572u);
  emit_store32_state(off_ksum);
  b.EmitPushImm32(0);
  emit_store32_state(off_sum);

  // 4 encryption rounds per 64-byte block.
  for (size_t round = 0; round < 4; round++) {
    emit_load32_state(off_ksum);
    b.EmitPushImm32(static_cast<uint32_t>(kDelta + static_cast<uint32_t>(round)));
    emit_add_mask();
    emit_store32_state(off_ksum);

    emit_load32_state(off_sum);
    b.EmitPushImm32(kDelta);
    emit_add_mask();
    emit_store32_state(off_sum);

    emit_update_key_word(off_a(0), off_a(1), off_ksum, 3);
    emit_update_key_word(off_a(1), off_a(2), off_a(0), 5);
    emit_update_key_word(off_a(2), off_a(3), off_a(1), 7);
    emit_update_key_word(off_a(3), off_a(4), off_a(2), 11);
    emit_update_key_word(off_a(4), off_a(5), off_a(3), 13);
    emit_update_key_word(off_a(5), off_a(6), off_a(4), 17);
    emit_update_key_word(off_a(6), off_a(7), off_a(5), 19);
    emit_update_key_word(off_a(7), off_a(0), off_a(6), 23);

    emit_rk_xor3(off_rk(0), off_a(0), off_a(2), off_ksum);
    emit_rk_xor2_sum_const(off_rk(1), off_a(1), off_a(3), kC1);
    emit_rk_xor2_sum_const(off_rk(2), off_a(4), off_a(6), kC2);
    emit_rk_xor2_sum_const(off_rk(3), off_a(5), off_a(7), kC3);
    emit_rk_add2(off_rk(4), off_a(0), off_a(4));
    emit_rk_add2(off_rk(5), off_a(1), off_a(5));
    emit_rk_add2(off_rk(6), off_a(2), off_a(6));
    emit_rk_add2(off_rk(7), off_a(3), off_a(7));
    emit_rk_xor2(off_rk(8), off_a(0), off_a(5));
    emit_rk_xor2(off_rk(9), off_a(1), off_a(6));
    emit_rk_xor2(off_rk(10), off_a(2), off_a(7));
    emit_rk_xor2(off_rk(11), off_a(3), off_a(4));

    for (size_t p = 0; p < 4; p++) {
      size_t i = p * 2;
      emit_speck_pair(off_r(i), off_r(i + 1), off_rk(p));
    }

    for (size_t i = 0; i < 8; i++) {
      emit_load32_state(off_r(i));
      emit_shift_xor(4, 5);
      emit_load32_state(off_r((i + 1) & 7));
      emit_add_mask();
      emit_store32_state(off_tmp0);

      emit_load32_state(off_sum);
      emit_load32_state(off_rk(4 + i));
      emit_add_mask();
      emit_load32_state(off_tmp0);
      b.EmitOpOnly(OP_XOR);
      emit_store32_state(off_tmp0);

      emit_load32_state(off_r((i + 3) & 7));
      emit_rol_const(static_cast<uint8_t>((i + 1) & 31));
      emit_store32_state(off_tmp1);

      emit_load32_state(off_tmp1);
      emit_load32_state(off_sum);
      b.EmitPushImm8(static_cast<uint8_t>((i + 1) & 7));
      b.EmitOpOnly(OP_SHR);
      b.EmitOpOnly(OP_XOR);
      emit_store32_state(off_tmp1);

      emit_load32_state(off_tmp0);
      emit_load32_state(off_tmp1);
      emit_add_mask();
      emit_store32_state(off_f(i));
    }

    for (size_t i = 0; i < 8; i++) {
      emit_load32_state(off_l(i));
      emit_load32_state(off_f(i));
      b.EmitOpOnly(OP_XOR);
      emit_store32_state(off_rk(i));
    }

    for (size_t i = 0; i < 8; i++) {
      emit_load32_state(off_r(i));
      emit_store32_state(off_l(i));

      emit_load32_state(off_rk(i));
      emit_store32_state(off_r(i));
    }
  }

  // Write ciphertext block in big-endian bytes.
  for (size_t i = 0; i < 8; i++) {
    emit_load32_state(off_l(i));
    emit_bswap32();
    b.EmitPopReg(6);
    emit_store32_base_plus_from_reg(6, 11, 10, static_cast<uint32_t>(i * 4));
  }
  for (size_t i = 0; i < 8; i++) {
    emit_load32_state(off_r(i));
    emit_bswap32();
    b.EmitPopReg(6);
    emit_store32_base_plus_from_reg(6, 11, 10, static_cast<uint32_t>((8 + i) * 4));
  }

  // next_key[i] = BE32((C[i*4..] XOR C[32+i*4..]))
  for (size_t i = 0; i < 8; i++) {
    emit_load32_base_plus(11, 10, static_cast<uint32_t>(i * 4));
    b.EmitPopReg(0);
    emit_load32_base_plus(11, 10, static_cast<uint32_t>(32 + i * 4));
    b.EmitPopReg(1);
    b.EmitPushReg(0);
    b.EmitPushReg(1);
    b.EmitOpOnly(OP_XOR);
    emit_bswap32();
    emit_store32_state(off_key(i));
  }

  b.EmitPushReg(10);
  b.EmitPushImm8(64);
  b.EmitOpOnly(OP_ADD);
  b.EmitPopReg(10);
  size_t block_jmp_rel = b.EmitJumpPlaceholder(OP_JMP);

  size_t block_end = b.Mark();
  b.PatchJump(block_end_rel, block_end);
  b.PatchJump(block_jmp_rel, block_loop);

  // Program exit.
  b.EmitOpOnly(OP_HALT);
  return b.TakeCode();
}

// Lazy compile/cache for the single full-flow SVE4 VM encrypt program.
static bool GetSve4VmEncryptProgram(const std::vector<DecodedInst>** out_program) {
  static std::vector<DecodedInst> program;
  static bool initialized = false;
  static bool ok = false;

  if (!initialized) {
    std::vector<uint8_t> bytecode = BuildSve4VmEncryptBytecode();
    ok = CompileProgram(bytecode, &program);
    initialized = true;
  }
  if (!ok) {
    return false;
  }
  *out_program = &program;
  return true;
}

static uint16_t ReadU16LEAt(const uint8_t* data, size_t offset) {
  return static_cast<uint16_t>(data[offset]) |
      static_cast<uint16_t>(static_cast<uint16_t>(data[offset + 1]) << 8);
}

static uint32_t ReadU32LEAt(const uint8_t* data, size_t offset) {
  return static_cast<uint32_t>(data[offset]) |
      (static_cast<uint32_t>(data[offset + 1]) << 8) |
      (static_cast<uint32_t>(data[offset + 2]) << 16) |
      (static_cast<uint32_t>(data[offset + 3]) << 24);
}

static bool ValidateWavInMemory(
    const uint8_t* input,
    size_t input_len,
    size_t* data_offset_out,
    size_t* data_size_out) {
  if (input == nullptr || input_len < 44) {
    return false;
  }

  const uint32_t kRiff = 0x46464952u;
  const uint32_t kWave = 0x45564157u;
  const uint32_t kFmt = 0x20746d66u;
  const uint32_t kData = 0x61746164u;

  if (ReadU32LEAt(input, 0) != kRiff || ReadU32LEAt(input, 8) != kWave) {
    return false;
  }

  bool fmt_found = false;
  bool data_found = false;
  uint16_t audio_format = 0;
  uint16_t channels = 0;
  uint16_t bits_per_sample = 0;
  uint16_t block_align = 0;
  size_t data_offset = 0;
  size_t data_size = 0;

  size_t chunk_offset = 12;
  while (chunk_offset + 8 <= input_len) {
    uint32_t chunk_id = ReadU32LEAt(input, chunk_offset);
    uint32_t chunk_size = ReadU32LEAt(input, chunk_offset + 4);
    size_t payload_offset = chunk_offset + 8;

    if (payload_offset > input_len) {
      return false;
    }

    size_t payload_len = static_cast<size_t>(chunk_size);
    if (payload_len > input_len - payload_offset) {
      return false;
    }

    if (chunk_id == kFmt && chunk_size >= 16) {
      audio_format = ReadU16LEAt(input, payload_offset + 0);
      channels = ReadU16LEAt(input, payload_offset + 2);
      block_align = ReadU16LEAt(input, payload_offset + 12);
      bits_per_sample = ReadU16LEAt(input, payload_offset + 14);
      fmt_found = true;
    } else if (chunk_id == kData) {
      data_offset = payload_offset;
      data_size = payload_len;
      data_found = true;
    }

    size_t advance = payload_len + (chunk_size & 1u);
    if (advance > input_len - payload_offset) {
      return false;
    }
    chunk_offset = payload_offset + advance;
  }

  if (!fmt_found || !data_found) {
    return false;
  }

  if (audio_format != 1 || bits_per_sample != 16) {
    return false;
  }
  if (channels == 0 || channels > 8) {
    return false;
  }

  uint16_t expected_block_align = static_cast<uint16_t>(channels * (bits_per_sample / 8));
  if (block_align != expected_block_align || block_align < 2) {
    return false;
  }

  if (data_size == 0 || (data_size % block_align) != 0) {
    return false;
  }
  if (data_offset > input_len || data_size > input_len - data_offset) {
    return false;
  }

  if (data_offset_out != nullptr) {
    *data_offset_out = data_offset;
  }
  if (data_size_out != nullptr) {
    *data_size_out = data_size;
  }
  return true;
}

static napi_value VmEncrypt(napi_env env, napi_callback_info info) {
  size_t argc = 1;
  napi_value argv[1];
  napi_get_cb_info(env, info, &argc, argv, nullptr, nullptr);
  if (argc < 1) {
    return ThrowError(env);
  }

  bool is_buffer = false;
  napi_is_buffer(env, argv[0], &is_buffer);
  if (!is_buffer) {
    return ThrowError(env);
  }

  void* input_data = nullptr;
  size_t input_len = 0;
  napi_get_buffer_info(env, argv[0], &input_data, &input_len);

  const uint8_t* src = static_cast<const uint8_t*>(input_data);
  std::vector<uint8_t> output;
  if (!ValidateWavInMemory(src, input_len, nullptr, nullptr)) {
    // Invalid WAV falls back to placeholder encryption path.
    output = PlaceholderVmEncrypt(src, input_len);
  } else {
    if (!VmEncryptSve4(src, input_len, &output)) {
      return ThrowError(env);
    }
  }

  napi_value result;
  void* copied = nullptr;
  napi_status status =
      napi_create_buffer_copy(env, output.size(), output.data(), &copied, &result);
  if (status != napi_ok) {
    return ThrowError(env);
  }
  return result;
}

static bool SetPropertyWithXorName(
    napi_env env,
    napi_value object,
    const uint8_t* encoded_name,
    size_t encoded_len,
    uint8_t xor_key,
    napi_value value) {
  std::string name;
  name.resize(encoded_len);
  for (size_t i = 0; i < encoded_len; i++) {
    name[i] = static_cast<char>(encoded_name[i] ^ xor_key);
  }

  napi_value key;
  if (napi_create_string_utf8(env, name.c_str(), name.size(), &key) != napi_ok) {
    return false;
  }

  return napi_set_property(env, object, key, value) == napi_ok;
}

static napi_value Init(napi_env env, napi_value exports) {
  napi_value fn;
  if (napi_create_function(env, nullptr, 0, VmEncrypt, nullptr, &fn) != napi_ok) {
    return ThrowError(env);
  }

  static const uint8_t kVmEncryptName[] =
      {0x2C, 0x37, 0x1F, 0x34, 0x39, 0x28, 0x23, 0x2A, 0x2E};
  const uint8_t kNameXor = 0x5A;

  if (!SetPropertyWithXorName(
          env, exports, kVmEncryptName, sizeof(kVmEncryptName), kNameXor, fn)) {
    return ThrowError(env);
  }
  return exports;
}

}  // namespace

NAPI_MODULE(NODE_GYP_MODULE_NAME, Init)
