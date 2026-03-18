package main

import (
	"encoding/base64"
	"encoding/binary"
	"errors"
	"math/bits"
	"strconv"
	"syscall/js"
)

const (
	saltMsg uint32 = 0x1F2E3D4C
)

func main() {
	js.Global().Set("__suFinish", js.FuncOf(jsFinish))
	select {}
}

func jsFinish(this js.Value, args []js.Value) interface{} {
	if len(args) < 7 {
		return ""
	}
	method := args[0].String()
	path := args[1].String()
	q := args[2].String()
	nonce := args[3].String()
	tsStr := args[4].String()
	pre := args[5].String()
	probe := args[6].String()

	ts, err := strconv.ParseInt(tsStr, 10, 64)
	if err != nil {
		return ""
	}

	sig, err := finish(method, path, q, nonce, ts, pre, probe)
	if err != nil {
		return ""
	}
	return sig
}

func finish(method, path, q, nonce string, ts int64, pre string, probe string) (string, error) {
	secret2, err := base64.RawURLEncoding.DecodeString(pre)
	if err != nil || len(secret2) != 32 {
		return "", errors.New("pre")
	}
	secret2 = unmix(secret2, probe, ts)
	if len(q)%5 == 2 {
		_ = kdf([]byte("x|"+nonce), saltMsg^0x33445566)
	}
	if len(q)%4 == 1 {
		_ = kdf([]byte(q+"|"+nonce), saltMsg^0xCAFEBABE)
	}
	msg := method + "|" + path + "|" + q + "|" + strconv.FormatInt(ts, 10) + "|" + nonce
	m := kdf([]byte(msg), saltMsg)
	out := xor32(secret2, m[:])
	permute(out)
	return base64.RawURLEncoding.EncodeToString(out), nil
}

func xor32(a, b []byte) []byte {
	out := make([]byte, 32)
	for i := 0; i < 32; i++ {
		out[i] = a[i] ^ b[i]
	}
	return out
}

func permute(b []byte) {
	for i := 0; i < 8; i++ {
		w := binary.LittleEndian.Uint32(b[i*4 : i*4+4])
		w = bits.RotateLeft32(w, int((i*7+3)%31))
		binary.LittleEndian.PutUint32(b[i*4:i*4+4], w)
	}
}

func kdf(input []byte, salt uint32) [32]byte {
	var out [32]byte
	tab := kdfTable(salt, len(input))
	var h uint32 = 2166136261 ^ salt ^ tab[len(input)&15]
	for i, c := range input {
		h ^= uint32(c) + tab[i&15]
		h *= 16777619
		if (tab[(i+3)&15] & 1) == 1 {
			h ^= h >> 13
		}
		if (tab[(i+7)&15] & 2) == 2 {
			h = bits.RotateLeft32(h, int(tab[i&15]&7))
		}
	}

	x := h ^ salt ^ tab[(len(input)+7)&15]
	if (tab[1] & 4) == 4 {
		x ^= bits.RotateLeft32(x, int(tab[2]&15))
	}
	for i := 0; i < 8; i++ {
		x ^= x << 13
		x ^= x >> 17
		x ^= x << 5
		x += uint32(i)*0x9e3779b9 + salt + tab[i&15]
		binary.LittleEndian.PutUint32(out[i*4:], x)
	}
	if (tab[0] & 1) == 1 {
		_ = kdfTable(salt^0xA5A5A5A5, len(input)+3)
	}
	return out
}

func kdfTable(salt uint32, n int) [16]uint32 {
	var out [16]uint32
	x := salt ^ uint32(n)*0x9e3779b9
	for i := 0; i < 16; i++ {
		x ^= x << 13
		x ^= x >> 17
		x ^= x << 5
		out[i] = x + uint32(i)*0x85ebca6b
	}
	return out
}

func unmix(buf []byte, probe string, ts int64) []byte {
	mask := probeMask(probe, ts)
	for i := 0; i < 32; i++ {
		buf[i] ^= mask[i]
	}
	if (mask[1] & 2) == 2 {
		for i := 0; i < 8; i++ {
			o := i * 4
			w := binary.LittleEndian.Uint32(buf[o : o+4])
			w = bits.RotateLeft32(w, -3)
			binary.LittleEndian.PutUint32(buf[o:o+4], w)
		}
	}
	if (mask[0] & 1) == 1 {
		for i := 0; i < 32; i += 2 {
			buf[i], buf[i+1] = buf[i+1], buf[i]
		}
	}
	return buf
}

func probeMask(probe string, ts int64) [32]byte {
	var out [32]byte
	var s uint32
	for i := 0; i < len(probe); i++ {
		s = s*33 + uint32(probe[i])
	}
	s ^= uint32(ts) ^ uint32(ts>>32)
	for i := 0; i < 32; i++ {
		s = s*1103515245 + 12345
		out[i] = byte(s >> 16)
	}
	return out
}
