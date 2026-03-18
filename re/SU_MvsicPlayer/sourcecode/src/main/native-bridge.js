const fs = require("fs");
const path = require("path");

function rol8(value, shift) {
  const s = shift & 7;
  return ((value << s) | (value >>> (8 - s))) & 0xff;
}

function placeholderVmEncrypt(sourceBytes) {
  const src = Buffer.from(sourceBytes);
  const out = Buffer.alloc(src.length);
  let state = 0x6d;

  for (let i = 0; i < src.length; i += 1) {
    state = (state ^ (50 + (i & 0x0f))) & 0xff;
    out[i] = rol8(src[i] ^ state, (i % 5) + 1);
  }

  const header = Buffer.alloc(4);
  header.write("SVE4", 0, "ascii");
  return Buffer.concat([header, out]);
}

function createVmEncryptorBridge(projectRoot) {
  const candidatePaths = [
    path.join(projectRoot, "native", "build", "Release", "vm_encryptor.node"),
    path.join(process.resourcesPath || "", "app.asar.unpacked", "native", "build", "Release", "vm_encryptor.node"),
    path.join(process.resourcesPath || "", "native", "build", "Release", "vm_encryptor.node")
  ];
  const encpath = candidatePaths.find((p) => p && fs.existsSync(p));

  let nativeModule = null;
  if (!encpath) {
    return {};
  }
  nativeModule = require(encpath);

  function throwOpaqueError() {
    throw new Error("E");
  }

  function vmEncrypt(bytes) {
    if (nativeModule && typeof nativeModule.vmEncrypt === "function") {
      const nativeOutput = nativeModule.vmEncrypt(Buffer.from(bytes));
      if (Buffer.isBuffer(nativeOutput)) {
        return nativeOutput;
      }
      throwOpaqueError();
    }
    return placeholderVmEncrypt(bytes);
  }

  return {
    vmEncrypt
  };
}

module.exports = {
  createVmEncryptorBridge,
  placeholderVmEncrypt
};
