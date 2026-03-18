package main

import (
	"encoding/base64"
	"encoding/binary"
	"errors"
	"math/bits"
	"strconv"
	"strings"
	"syscall/js"
)

const (
	saltSeed uint32 = 0xA3B1C2D3
	saltUA   uint32 = 0xB16B00B5
	saltPerm uint32 = 0xC0DEC0DE
	windowMs int64  = 30000
)

var kConst = []byte("k9v3_suctf26_sigma")
var rotScr = [8]int{1, 5, 9, 13, 17, 3, 11, 19}

func main() {
	js.Global().Set("__suPrep", js.FuncOf(jsPrep))
	select {}
}

func jsPrep(this js.Value, args []js.Value) interface{} {
	if len(args) < 9 {
		return ""
	}
	method := args[0].String()
	path := args[1].String()
	q := args[2].String()
	nonce := args[3].String()
	tsStr := args[4].String()
	seedPack := args[5].String()
	salt := args[6].String()
	ua := args[7].String()
	probe := args[8].String()

	ts, err := strconv.ParseInt(tsStr, 10, 64)
	if err != nil {
		return ""
	}

	out, err := prep(method, path, q, nonce, ts, seedPack, salt, ua, probe)
	if err != nil {
		return ""
	}
	return out
}

func prep(method, path, q, nonce string, ts int64, seedPack string, salt string, ua string, probe string) (string, error) {
	seedX, err := unpackSeed(seedPack, nonce, salt, ts)
	if err != nil || len(seedX) != 32 {
		return "", errors.New("bad seed")
	}
	nb, err := base64.RawURLEncoding.DecodeString(nonce)
	if err != nil || len(nb) < 8 {
		return "", errors.New("bad nonce")
	}

	if len(q) == 0 || method == "GET" || isDebug(probe) {
		return decoy(nonce, ts, probe), nil
	}

	if strings.Contains(probe, "tz=") {
		_ = kdf([]byte("z|"+probe), saltUA^0x0F0F0F0F)
	}
	if strings.Contains(probe, "b=") {
		_ = kdf([]byte("b|"+probe), saltPerm^0x12345678)
	}
	if len(probe)%5 == 1 {
		_ = uaMixKey("ua/ghost", salt, ts)
	}
	if len(q)%3 == 2 {
		_ = kdf([]byte(q+"|"+salt), saltSeed^0x5A5A5A5A)
	}

	k1 := kdf(append(append(nb, u64le(ts)...), kConst...), saltSeed)
	dyn := uaMixKey(ua, salt, ts)
	permuteInv(seedX)
	seed := xor32(seedX, dyn[:])
	secret := xor32(seed, k1[:])
	secret2 := xor32(secret, dyn[:])

	return scramble(secret2, nonce, ts), nil
}

func scramble(secret2 []byte, nonce string, ts int64) string {
	mask := maskBytes(nonce, ts)
	buf := make([]byte, 32)
	for i := 0; i < 32; i++ {
		buf[i] = secret2[i] ^ mask[i]
	}
	for i := 0; i < 8; i++ {
		w := binary.LittleEndian.Uint32(buf[i*4 : i*4+4])
		w = bits.RotateLeft32(w, rotScr[i])
		binary.LittleEndian.PutUint32(buf[i*4:i*4+4], w)
	}
	return base64.RawURLEncoding.EncodeToString(buf)
}

func maskBytes(nonce string, ts int64) [32]byte {
	var out [32]byte
	nb, _ := base64.RawURLEncoding.DecodeString(nonce)
	var s uint32
	for _, b := range nb {
		s = (s * 131) + uint32(b)
	}
	s ^= uint32(ts) ^ uint32(ts>>32)
	for i := 0; i < 32; i++ {
		s ^= s << 13
		s ^= s >> 17
		s ^= s << 5
		out[i] = byte(s)
	}
	return out
}

func tsStr(ts int64) string {
	return strconv.FormatInt(ts, 10)
}

func u64le(v int64) []byte {
	buf := make([]byte, 8)
	binary.LittleEndian.PutUint64(buf, uint64(v))
	return buf
}

func xor32(a, b []byte) []byte {
	out := make([]byte, 32)
	for i := 0; i < 32; i++ {
		out[i] = a[i] ^ b[i]
	}
	return out
}

func permuteInv(b []byte) {
	for i := 0; i < 8; i++ {
		w := binary.LittleEndian.Uint32(b[i*4 : i*4+4])
		w = bits.RotateLeft32(w, -int((i*7+3)%31))
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

func uaMixKey(ua, salt string, ts int64) [32]byte {
	if ua == "" {
		ua = "ua/empty"
	}
	bucket := strconv.FormatInt(ts/windowMs, 10)
	msgA := ua + "|" + salt + "|" + bucket
	msgB := bucket + "|" + salt + "|" + ua
	msgC := ua + "|" + bucket

	a := kdf([]byte(msgA), saltUA)
	b := kdf([]byte(msgB), saltUA^0x13579BDF)
	c := kdf([]byte(msgC), saltUA^0x2468ACE0)

	b2 := rotWords(b[:], 5)
	c2 := rotWords(c[:], 11)
	mix := xor32(a[:], b2)
	mix = xor32(mix, c2)

	if len(ua)%7 == 3 {
		fake := kdf([]byte("x|"+ua+"|"+salt), 0xDEADBEEF)
		f2 := rotWords(fake[:], 7)
		mix = xor32(mix, f2)
	}

	var out [32]byte
	copy(out[:], mix)
	return out
}

func rotWords(in []byte, r int) []byte {
	out := make([]byte, 32)
	for i := 0; i < 8; i++ {
		w := binary.LittleEndian.Uint32(in[i*4 : i*4+4])
		w = bits.RotateLeft32(w, r)
		binary.LittleEndian.PutUint32(out[i*4:i*4+4], w)
	}
	return out
}

func decoy(nonce string, ts int64, probe string) string {
	msg := nonce + "|" + tsStr(ts) + "|" + probe + "|x"
	m := kdf([]byte(msg), 0xD00DFEED)
	buf := make([]byte, 32)
	copy(buf, m[:])
	return scramble(buf, nonce, ts)
}

func isDebug(probe string) bool {
	return strings.Contains(probe, "wd=1")
}

func unpackSeed(pack, nonce, salt string, ts int64) ([]byte, error) {
	parts := strings.Split(pack, ".")
	if len(parts) != 4 {
		return nil, errors.New("pack")
	}
	perm, padL, padR, mask := seedPackParams(nonce, salt, ts)
	chunks := make([][]byte, 4)
	for i := 0; i < 4; i++ {
		b, err := base64.RawURLEncoding.DecodeString(parts[i])
		if err != nil {
			return nil, errors.New("part")
		}
		idx := perm[i]
		exp := int(padL[idx]+padR[idx]) + 8
		if len(b) != exp {
			return nil, errors.New("len")
		}
		data := make([]byte, 8)
		copy(data, b[int(padL[idx]):int(padL[idx])+8])
		for j := 0; j < 8; j++ {
			data[j] ^= mask[idx] + byte(j*17)
		}
		chunks[idx] = data
	}
	out := make([]byte, 32)
	for i := 0; i < 4; i++ {
		copy(out[i*8:], chunks[i])
	}
	return out, nil
}

func seedPackParams(nonce, salt string, ts int64) ([4]int, [4]byte, [4]byte, [4]byte) {
	bucket := strconv.FormatInt(ts/windowMs, 10)
	msg := nonce + "|" + salt + "|" + bucket
	k := kdf([]byte(msg), saltPerm)
	var padL [4]byte
	var padR [4]byte
	var mask [4]byte
	for i := 0; i < 4; i++ {
		padL[i] = k[i] % 5
		padR[i] = k[i+4] % 5
		mask[i] = k[i+8]
	}
	idx := [4]int{0, 1, 2, 3}
	pos := 12
	for i := 3; i > 0; i-- {
		j := int(k[pos] % byte(i+1))
		idx[i], idx[j] = idx[j], idx[i]
		pos++
	}
	return idx, padL, padR, mask
}
