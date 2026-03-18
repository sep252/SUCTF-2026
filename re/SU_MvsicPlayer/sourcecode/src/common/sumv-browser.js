(function sumvBrowserBootstrap() {
  const MAGIC = "SUMV";
  const RC4_KEY = "SUMUSICPLAYER";

  function ror8(value, shift) {
    const s = shift & 7;
    return ((value >>> s) | (value << (8 - s))) & 0xff;
  }

  function decodePayload(encoded, expectedLength) {
    const output = [];
    let cursor = 0;

    while (cursor < encoded.length && output.length < expectedLength) {
      const control = encoded[cursor++];
      const mode = control >>> 6;
      const low = control & 0x1f;
      const flag = (control >>> 5) & 0x01;

      if (mode === 0) {
        const runLength = low + 1;
        const baseMask = flag ? 0x5a : 0x00;
        for (let i = 0; i < runLength; i += 1) {
          if (cursor >= encoded.length) {
            throw new Error("E");
          }
          const masked = encoded[cursor++];
          const value = masked ^ ((baseMask + i * 17) & 0xff);
          output.push(value);
        }
        continue;
      }

      if (mode === 1) {
        const runLength = low + 3;
        if (cursor >= encoded.length) {
          throw new Error("E");
        }
        const token = encoded[cursor++];
        const repeatValue = ror8(token ^ 0x5c, flag ? 2 : 1);
        for (let i = 0; i < runLength; i += 1) {
          output.push(repeatValue);
        }
        continue;
      }

      if (mode === 2) {
        const runLength = low + 3;
        if (cursor >= encoded.length) {
          throw new Error("E");
        }
        const base = encoded[cursor++];
        const step = flag ? 2 : 1;
        for (let i = 0; i < runLength; i += 1) {
          output.push((base + i * step) & 0xff);
        }
        continue;
      }

      const runLength = (control & 0x0f) + 4;
      if (cursor >= encoded.length) {
        throw new Error("E");
      }
      const high = (control >>> 4) & 0x03;
      const lowOffset = encoded[cursor++];
      const distance = ((high << 8) | lowOffset) + 1;
      const start = output.length - distance;
      if (start < 0) {
        throw new Error("E");
      }
      for (let i = 0; i < runLength; i += 1) {
        output.push(output[start + i]);
      }
    }

    if (output.length !== expectedLength) {
      throw new Error("E");
    }
    return new Uint8Array(output);
  }

  function rc4Transform(input, key) {
    const source = input instanceof Uint8Array ? input : new Uint8Array(input);
    const keyBytes = new TextEncoder().encode(key);
    if (keyBytes.length === 0) {
      return new Uint8Array(source);
    }

    const s = new Uint8Array(256);
    for (let i = 0; i < 256; i += 1) {
      s[i] = i;
    }

    let j = 0;
    for (let i = 0; i < 256; i += 1) {
      j = (j + s[i] + keyBytes[i % keyBytes.length]) & 0xff;
      const tmp = s[i];
      s[i] = s[j];
      s[j] = tmp;
    }

    const out = new Uint8Array(source.length);
    let i = 0;
    j = 0;
    for (let n = 0; n < source.length; n += 1) {
      i = (i + 1) & 0xff;
      j = (j + s[i]) & 0xff;
      const tmp = s[i];
      s[i] = s[j];
      s[j] = tmp;
      const k = s[(s[i] + s[j]) & 0xff];
      out[n] = source[n] ^ k;
    }
    return out;
  }

  async function parseSuMv(inputBytes) {
    const bytes =
      inputBytes instanceof Uint8Array ? inputBytes : new Uint8Array(inputBytes);

    if (bytes.length < 16) {
      throw new Error("E");
    }

    const magic = String.fromCharCode(bytes[0], bytes[1], bytes[2], bytes[3]);
    if (magic !== MAGIC) {
      throw new Error("E");
    }

    const version = bytes[4];
    const formatCode = bytes[6];
    const view = new DataView(bytes.buffer, bytes.byteOffset, bytes.byteLength);
    const originalLength = view.getUint32(8, true);
    const encodedLength = view.getUint32(12, true);

    if (originalLength === 0 || encodedLength === 0) {
      throw new Error("E");
    }
    if (16 + encodedLength > bytes.length) {
      throw new Error("E");
    }

    const encodedPayload = bytes.subarray(16, 16 + encodedLength);
    const packed = decodePayload(encodedPayload, originalLength);
    const payload = rc4Transform(packed, RC4_KEY);

    return {
      version,
      formatCode,
      isValid: true,
      payload
    };
  }

  window.SUMV = {
    parseSuMv
  };
})();
