package sign

import (
	"crypto/rand"
	"crypto/sha256"
	"encoding/base64"
	"encoding/binary"
	"encoding/hex"
	"errors"
	"io"
	"math/bits"
	"os"
	"strconv"
	"strings"
	"sync"
	"time"
)

const (
	saltSeed uint32 = 0xA3B1C2D3
	saltMsg  uint32 = 0x1F2E3D4C
	saltUA   uint32 = 0xB16B00B5
	saltPerm uint32 = 0xC0DEC0DE
	windowMs int64  = 30000
)

var kConst = []byte("k9v3_suctf26_sigma")

type NonceStore struct {
	mu    sync.Mutex
	items map[string]nonceItem
	ttl   time.Duration
}

type nonceItem struct {
	ts     int64
	issued time.Time
	salt   string
}

func NewNonceStore(ttl time.Duration) *NonceStore {
	return &NonceStore{items: make(map[string]nonceItem), ttl: ttl}
}

func (s *NonceStore) Issue() (string, int64, string, error) {
	n := make([]byte, 12)
	if _, err := io.ReadFull(rand.Reader, n); err != nil {
		return "", 0, "", err
	}
	nonce := base64.RawURLEncoding.EncodeToString(n)
	ts := time.Now().UnixMilli()
	saltRaw := make([]byte, 8)
	if _, err := io.ReadFull(rand.Reader, saltRaw); err != nil {
		return "", 0, "", err
	}
	salt := base64.RawURLEncoding.EncodeToString(saltRaw)

	s.mu.Lock()
	s.items[nonce] = nonceItem{ts: ts, issued: time.Now(), salt: salt}
	s.mu.Unlock()

	return nonce, ts, salt, nil
}

func (s *NonceStore) Consume(nonce string, ts int64) (string, bool) {
	now := time.Now()
	empty := ""

	s.mu.Lock()
	item, ok := s.items[nonce]
	if ok {
		delete(s.items, nonce)
	}
	s.mu.Unlock()

	if !ok {
		return empty, false
	}
	if item.ts != ts {
		return empty, false
	}
	if now.Sub(item.issued) > s.ttl {
		return empty, false
	}
	return item.salt, true
}

func SecretFromEnv() []byte {
	raw := os.Getenv("SIGN_SECRET")
	if raw == "" {
		raw = "suctf2026_sign_secret_change_me_32b"
	}

	var b []byte
	if strings.HasPrefix(raw, "hex:") {
		decoded, err := hex.DecodeString(strings.TrimPrefix(raw, "hex:"))
		if err == nil {
			b = decoded
		}
	} else if strings.HasPrefix(raw, "b64:") {
		decoded, err := base64.RawStdEncoding.DecodeString(strings.TrimPrefix(raw, "b64:"))
		if err == nil {
			b = decoded
		}
	}
	if b == nil {
		b = []byte(raw)
	}
	if len(b) != 32 {
		sum := sha256.Sum256(b)
		b = sum[:]
	}
	return b
}

func SeedPackFor(nonce string, ts int64, ua, salt string, secret []byte) (string, error) {
	nb, err := decodeNonce(nonce)
	if err != nil {
		return "", err
	}
	k := kdf(append(append(nb, u64le(ts)...), kConst...), saltSeed)
	seed := xor32(secret, k[:])
	dyn := uaMixKey(ua, salt, ts)
	seedX := xor32(seed, dyn[:])
	permute(seedX)
	return packSeed(seedX, nonce, salt, ts), nil
}

func Sign(method, path, q, nonce string, ts int64, ua, salt string, secret []byte) (string, error) {
	if len(secret) != 32 {
		return "", errors.New("secret must be 32 bytes")
	}
	if _, err := decodeNonce(nonce); err != nil {
		return "", err
	}
	dyn := uaMixKey(ua, salt, ts)
	secret2 := xor32(secret, dyn[:])
	msg := method + "|" + path + "|" + q + "|" + strconv.FormatInt(ts, 10) + "|" + nonce
	m := kdf([]byte(msg), saltMsg)
	out := xor32(secret2, m[:])
	permute(out)
	return base64.RawURLEncoding.EncodeToString(out), nil
}

func Verify(expected, got string) bool {
	if len(expected) != len(got) {
		return false
	}
	var v byte
	for i := 0; i < len(expected); i++ {
		v |= expected[i] ^ got[i]
	}
	return v == 0
}

func decodeNonce(nonce string) ([]byte, error) {
	b, err := base64.RawURLEncoding.DecodeString(nonce)
	if err != nil {
		return nil, err
	}
	if len(b) < 8 {
		return nil, errors.New("nonce too short")
	}
	return b, nil
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

func packSeed(seedX []byte, nonce, salt string, ts int64) string {
	if len(seedX) != 32 {
		return ""
	}
	perm, padL, padR, mask, padBytes := seedPackParams(nonce, salt, ts)
	padPos := 0
	parts := make([]string, 4)
	for i := 0; i < 4; i++ {
		idx := perm[i]
		start := idx * 8
		data := make([]byte, 8)
		copy(data, seedX[start:start+8])
		for j := 0; j < 8; j++ {
			data[j] ^= mask[idx] + byte(j*17)
		}
		total := int(padL[idx]+padR[idx]) + 8
		chunk := make([]byte, total)
		for p := 0; p < int(padL[idx]); p++ {
			chunk[p] = padBytes[padPos%len(padBytes)]
			padPos++
		}
		copy(chunk[int(padL[idx]):int(padL[idx])+8], data)
		for p := 0; p < int(padR[idx]); p++ {
			chunk[int(padL[idx])+8+p] = padBytes[padPos%len(padBytes)]
			padPos++
		}
		parts[i] = base64.RawURLEncoding.EncodeToString(chunk)
	}
	return strings.Join(parts, ".")
}

func seedPackParams(nonce, salt string, ts int64) ([4]int, [4]byte, [4]byte, [4]byte, []byte) {
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
	padBytes := kdf([]byte("pad|"+msg), saltPerm^0x55AA55AA)
	return idx, padL, padR, mask, padBytes[:]
}
