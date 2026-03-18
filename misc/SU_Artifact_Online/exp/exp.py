#!/usr/bin/env python3
import hashlib
import itertools
import re
import socket
import ssl
import string
import sys
import time
from collections import deque

rmap = {
    'a':'ᚠ','b':'ᚢ','c':'ᚦ','d':'ᚨ','e':'ᚱ','f':'ᚲ','g':'ᚷ','h':'ᚹ',
    'i':'ᚺ','j':'ᚾ','k':'ᛁ','l':'ᛃ','m':'ᛇ','n':'ᛈ','o':'ᛉ','p':'ᛋ',
    'q':'ᛏ','r':'ᛒ','s':'ᛖ','t':'ᛗ','u':'ᛚ','v':'ᛜ','w':'ᛟ','x':'ᛞ',
    'y':'ᛣ','z':'ᛤ',',':'ᛥ',';':'ᛦ','.':'ᛧ',' ':'ᛨ','?':'ᛩ',
    '{':'ᚪ','}':'ᚫ','-':'ᚬ','"':'ᚭ','!':'ᚮ',"'":'ᚯ',
}
rrev = {v: k for k, v in rmap.items()}

def decode(text):
    return "".join(rrev.get(c, c) for c in text)

def solve_pow(prefix):
    charset = string.ascii_letters + string.digits
    print(f'[*] Solving PoW: sha256("{prefix}" + S)[:6] == "000000"')
    t0, cnt = time.time(), 0
    for length in range(1, 20):
        for combo in itertools.product(charset, repeat=length):
            s = "".join(combo)
            if hashlib.sha256((prefix + s).encode()).hexdigest()[:6] == "000000":
                print(f'[+] PoW solved: S="{s}" ({cnt} attempts, {time.time()-t0:.2f}s)')
                return s
            cnt += 1
            if cnt % 5_000_000 == 0:
                e = time.time() - t0
                print(f"  [pow] {cnt/1e6:.1f}M attempts, {cnt/e/1e6:.2f}M/s, {e:.1f}s")

cmd = "cd ..;cat flag"
sz = 5
fnames = ["F", "R", "B", "L", "U", "D"]
all_moves = [f"{p}{i}{s}" for p in "RCF" for i in range(1, 6) for s in ("", "'")]
allpos = [(f, r, c) for f in fnames for r in range(sz) for c in range(sz)]
orbsz = {(0,0):6, (0,1):24, (0,2):24, (1,1):24, (1,2):48, (2,2):24}
arrows = {"up": b"\x1b[A", "down": b"\x1b[B", "right": b"\x1b[C", "left": b"\x1b[D"}
ansi_re = re.compile(r"\x1b\[[0-9;]*[A-Za-z]")
grid_re = re.compile(
    r'([\u16A0-\u16EB](?:\s+[\u16A0-\u16EB]){4})'
    r'\s+\|\s+'
    r'([\u16A0-\u16EB](?:\s+[\u16A0-\u16EB]){4})'
)
mapall_seq = (
    [f"R{i}" for i in range(1, 6)] + [f"R{i}" for i in range(1, 6)] +
    [f"R{i}'" for i in range(1, 6)] + [f"R{i}'" for i in range(1, 6)] +
    [f"C{i}'" for i in range(1, 6)] + [f"C{i}" for i in range(1, 6)] +
    [f"C{i}" for i in range(1, 6)] + [f"C{i}'" for i in range(1, 6)]
)
mapall_idx = {4: ("B", False), 9: ("L", False), 24: ("U", True), 34: ("D", True)}

def orb(c, r):
    a, b = abs(c - 2), abs(r - 2)
    return (min(a, b), max(a, b))

def inv(m):
    return m[:-1] if m.endswith("'") else m + "'"

class Conn:
    def __init__(self, host, port, use_ssl=False):
        raw = socket.create_connection((host, port), timeout=30)
        if use_ssl:
            ctx = ssl.create_default_context()
            ctx.check_hostname = False
            ctx.verify_mode = ssl.CERT_NONE
            self.s = ctx.wrap_socket(raw, server_hostname=host)
        else:
            self.s = raw
        self.buf = b""

    def recvuntil(self, delim, timeout=15):
        dl = time.time() + timeout
        while delim not in self.buf:
            rem = dl - time.time()
            if rem <= 0: break
            self.s.settimeout(max(rem, 0.1))
            try:
                d = self.s.recv(4096)
                if not d: break
                self.buf += d
            except socket.timeout:
                break
        i = self.buf.find(delim)
        if i >= 0:
            r = self.buf[:i + len(delim)]
            self.buf = self.buf[i + len(delim):]
            return r
        r = self.buf
        self.buf = b""
        return r

    def send(self, data):
        self.s.sendall(data + b"\n")

    def close(self):
        self.s.close()

def parse_grid(raw):
    clean = ansi_re.sub("", raw)
    fr, rr = [], []
    for line in clean.splitlines():
        m = grid_re.search(line)
        if m:
            fr.append([decode(c) for c in m.group(1).split()])
            rr.append([decode(c) for c in m.group(2).split()])
    return (fr[-sz:], rr[-sz:]) if len(fr) >= sz else (None, None)

def batch_send(r, mvs):
    if mvs:
        r.s.sendall(b"\n".join(m.encode() for m in mvs) + b"\n")

def batch_recv(r, n):
    return [r.recvuntil(b"move>", timeout=10).decode(errors="replace") for _ in range(n)]

def read_faces(resps, front, right):
    st = {"F": front, "R": right}
    for idx, (name, use_f) in mapall_idx.items():
        f, r = parse_grid(resps[idx])
        g = f if use_f else r
        if g is None: return None
        st[name] = g
    return st

def cyc(t):
    return (t[1], t[2], t[3], t[0])

def deduce_perm(s0, s1, s2, s3):
    perm, used = {}, set()
    keys = {}
    for p in allpos:
        fn, r, c = p
        keys[p] = (s0[fn][r][c], s1[fn][r][c], s2[fn][r][c], s3[fn][r][c])
    for p in allpos:
        k = keys[p]
        if k[0] == k[1] == k[2] == k[3]:
            perm[p] = p
            used.add(p)
    di = {}
    for p in allpos:
        if p in used: continue
        di.setdefault(cyc(keys[p]), []).append(p)
    amb = []
    for p in allpos:
        if p in perm: continue
        k = keys[p]
        if k[0] == k[1] == k[2] == k[3]: continue
        cands = [q for q in di.get(k, []) if q not in used]
        if len(cands) == 1:
            perm[p] = cands[0]
            used.add(cands[0])
        elif cands:
            amb.append((p, cands))
    for p, cands in amb:
        if p in perm: continue
        fn, r, c = p
        o = orb(c, r)
        oc = [q for q in cands if q not in used and orb(q[2], q[1]) == o]
        if oc:
            perm[p] = oc[0]
            used.add(oc[0])
    for p in allpos:
        if p not in perm:
            perm[p] = p
    return perm

def probe_perms(conn, s0):
    perms = {}
    seq = list(mapall_seq)
    for px in "RCF":
        for i in range(1, 6):
            base = f"{px}{i}"
            ib = inv(base)
            batch = [base] + seq + [base] + seq + [base] + seq + [base] + seq + [ib] * 4
            batch_send(conn, batch)
            resps = batch_recv(conn, 168)
            states, ok = [], True
            for j in range(3):
                off = j * 41
                f, r = parse_grid(resps[off])
                if f is None: ok = False; break
                st = read_faces(resps[off+1:off+41], f, r)
                if st is None: ok = False; break
                states.append(st)
            if not ok or len(states) < 3: continue
            pm = deduce_perm(s0, states[0], states[1], states[2])
            perms[base] = pm
            perms[base + "'"] = {v: k for k, v in pm.items()}
    return perms

def build_comms(perms):
    comms = {}
    for m1 in all_moves:
        m1i = inv(m1)
        p1, p1i = perms[m1], perms[m1i]
        for m2 in all_moves:
            if m2 == m1 or m2 == m1i: continue
            m2i = inv(m2)
            p2, p2i = perms[m2], perms[m2i]
            res, nontrivial = {}, False
            for p in allpos:
                d = p2i[p1i[p2[p1[p]]]]
                res[p] = d
                if d != p: nontrivial = True
            if nontrivial:
                comms[(m1, m2)] = (res, [m1, m2, m1i, m2i])
    return comms

def safe_ops(frozen, perms, comms=None):
    ops = [(perms[t], [t]) for t in all_moves if all(perms[t][p] == p for p in frozen)]
    if comms:
        ops += [(pm, mv) for (_, _), (pm, mv) in comms.items()
                if all(pm[p] == p for p in frozen)]
    return ops

def bfs(start, goal, ops):
    if start == goal: return []
    vis = {start: None}
    q = deque([start])
    while q:
        cur = q.popleft()
        for pm, ms in ops:
            nxt = pm[cur]
            if nxt not in vis:
                vis[nxt] = (cur, ms)
                if nxt == goal:
                    path, n = [], nxt
                    while vis[n] is not None:
                        prev, m = vis[n]
                        path = list(m) + path
                        n = prev
                    return path
                q.append(nxt)
    return None

def copy_state(st):
    return {n: [row[:] for row in st[n]] for n in fnames}

def apply_moves(st, tokens, perms):
    for tok in tokens:
        nf = {n: [[None] * sz for _ in range(sz)] for n in fnames}
        for (sf, sr, sc), (df, dr, dc) in perms[tok].items():
            nf[df][dr][dc] = st[sf][sr][sc]
        for n in fnames:
            st[n] = nf[n]

def solve(state, path, perms, comms):
    orderings = [
        sorted(path, key=lambda x: orbsz[orb(x[1][0], x[1][1])]),
        sorted(path, key=lambda x: -orbsz[orb(x[1][0], x[1][1])]),
        list(path), list(reversed(path)),
        sorted(path, key=lambda x: (x[1][0], orbsz[orb(x[1][0], x[1][1])])),
        sorted(path, key=lambda x: (orbsz[orb(x[1][0], x[1][1])], x[1][0])),
        sorted(path, key=lambda x: x[1][1]),
    ]
    seen = set()
    for order in orderings:
        k = tuple(order)
        if k in seen: continue
        seen.add(k)
        sim = copy_state(state)
        frozen, seq, ok = set(), [], True
        for ch, (tc, tr) in order:
            tp = ("F", tr, tc)
            to = orb(tc, tr)
            cands = [(f, r, c) for f in fnames for r in range(sz) for c in range(sz)
                     if sim[f][r][c] == ch and orb(c, r) == to]
            if not cands: ok = False; break
            cands.sort(key=lambda p: 0 if p[0] == 'F' else 1)
            found = False
            for uc in [False, True]:
                ops = safe_ops(frozen, perms, comms if uc else None)
                for cd in cands:
                    res = bfs(cd, tp, ops)
                    if res is not None:
                        apply_moves(sim, res, perms)
                        seq.extend(res)
                        frozen.add(tp)
                        found = True
                        break
                if found: break
            if not found: ok = False; break
        if not ok: continue
        if all(sim["F"][r][c] == ch for ch, (c, r) in path):
            return seq
    return None

def find_paths(state):
    needed = {}
    for ch in cmd:
        needed[ch] = needed.get(ch, 0) + 1
    avail = {}
    for ch in needed:
        av = {}
        for fn in fnames:
            for r in range(sz):
                for c in range(sz):
                    if state[fn][r][c] == ch:
                        o = orb(c, r)
                        if o != (0, 0):
                            av[o] = av.get(o, 0) + 1
        avail[ch] = av
    paths, used = [], set()
    def dfs(idx, cx, cy, hz, cur):
        if idx == len(cmd):
            paths.append(cur[:])
            return
        ch = cmd[idx]
        if ch not in avail: return
        for c in range(sz):
            for r in range(sz):
                if hz and r != cy: continue
                if not hz and c != cx: continue
                if (c, r) in used: continue
                o = orb(c, r)
                if o == (0, 0): continue
                if avail[ch].get(o, 0) == 0: continue
                used.add((c, r))
                cur.append((ch, (c, r)))
                dfs(idx + 1, c, r, not hz, cur)
                cur.pop()
                used.discard((c, r))
    dfs(0, 0, 0, True, [])
    paths.sort(key=lambda p: (
        -len(set(c for _, (c, _) in p)),
        -len(set(r for _, (_, r) in p)),
        sum(orbsz[orb(c, r)] for _, (c, r) in p)
    ))
    return paths

def drain(conn, timeout=0.6):
    chunks = [conn.buf]
    conn.buf = b""
    dl = time.time() + timeout
    while True:
        rem = dl - time.time()
        if rem <= 0: break
        conn.s.settimeout(max(rem, 0.05))
        try:
            d = conn.s.recv(4096)
            if not d: break
            chunks.append(d)
            dl = time.time() + 0.3
        except socket.timeout:
            break
    conn.buf = b""
    return b"".join(chunks)

def key_wait(conn, key):
    conn.s.sendall(key)
    conn.recvuntil(b"Cursor:", timeout=3)
    conn.recvuntil(b"\n", timeout=1)
    conn.recvuntil(b"\n", timeout=1)

def navigate(conn, coords):
    acts, cx, cy, hz = [], 0, 0, True
    for tx, ty in coords:
        if hz:
            rd, ld = (tx - cx) % sz, (cx - tx) % sz
            acts.append(("right", rd) if rd <= ld else ("left", ld))
            cx = tx
        else:
            dd, ud = (ty - cy) % sz, (cy - ty) % sz
            acts.append(("down", dd) if dd <= ud else ("up", ud))
            cy = ty
        hz = not hz
    print(f"  [nav] {len(coords)} chars, {sum(c for _, c in acts)} key presses")
    conn.send(b"2")
    got = conn.recvuntil(b"Cursor:", timeout=8)
    if b"Cursor:" not in got:
        return "(error)", "(error)"
    conn.recvuntil(b"\n", timeout=1)
    conn.recvuntil(b"\n", timeout=1)
    for si, (d, n) in enumerate(acts):
        for _ in range(n):
            key_wait(conn, arrows[d])
        conn.s.sendall(b"\r")
        conn.recvuntil(b"Cursor:", timeout=3)
        conn.recvuntil(b"\n", timeout=1)
        sp = conn.recvuntil(b"\n", timeout=1)
        print(f"  [nav] step {si+1}/{len(acts)}: {ansi_re.sub('', sp.decode(errors='replace')).strip()}")
    conn.s.sendall(b"x")
    raw = drain(conn, timeout=4.0)
    text = ansi_re.sub("", raw.decode(errors="replace"))
    runes, plain, out = [], [], False
    for line in text.splitlines():
        s = line.strip()
        if not s: continue
        if "activating" in s: out = True; continue
        if out:
            if any(k in s for k in ["Enter", "continue", "Press", "hums"]): break
            runes.append(s)
            plain.append(decode(s))
    conn.s.sendall(b"\r")
    time.sleep(0.3)
    return "\n".join(runes) or "(no output)", "\n".join(plain) or "(no output)"

def main():
    if len(sys.argv) < 3:
        print(f"Usage: {sys.argv[0]} <host> <port> [--ssl]")
        sys.exit(1)
    host, port = sys.argv[1], int(sys.argv[2])
    use_ssl = "--ssl" in sys.argv
    t0 = time.time()
    conn = Conn(host, port, use_ssl)

    raw = conn.recvuntil(b"S: ", timeout=15).decode(errors="replace")
    m = re.search(r'sha256\("([^"]+)"\s*\+\s*S\)', raw)
    if not m:
        print("[-] bad pow"); conn.close(); return
    ans = solve_pow(m.group(1))
    if not ans:
        print("[-] pow failed"); conn.close(); return
    conn.send(ans.encode())
    data = conn.recvuntil(b"> ", timeout=15).decode(errors="replace")
    if "OK" not in data:
        print("[-] pow rejected"); conn.close(); return

    front, right = parse_grid(data)
    if front is None:
        print("[-] parse failed"); conn.close(); return
    conn.send(b"1")
    conn.recvuntil(b"move>", timeout=10)
    batch_send(conn, mapall_seq)
    resps = batch_recv(conn, 40)
    s0 = read_faces(resps, front, right)
    if s0 is None:
        print("[-] faces failed"); conn.close(); return

    perms = probe_perms(conn, s0)
    if len(perms) < 30:
        print(f"[-] only {len(perms)} perms"); conn.close(); return

    comms = build_comms(perms)
    paths = find_paths(s0)
    if not paths:
        print("[-] no paths"); conn.close(); return

    sol, used_path, tried = None, None, 0
    for p in paths[:500]:
        if time.time() - t0 > 30: break
        tried += 1
        ms = solve(s0, p, perms, comms)
        if ms is not None:
            sol, used_path = ms, p
            break
    if sol is None:
        print(f"[-] no solution ({tried} tried)"); conn.close(); return
    print(f"[+] Solution: {len(sol)} moves, tried {tried} paths ({time.time()-t0:.1f}s)")

    batch_send(conn, sol)
    batch_recv(conn, len(sol))
    conn.send(b"q")
    conn.recvuntil(b"> ", timeout=10)

    coords = [(c, r) for _, (c, r) in used_path]
    rout, pout = navigate(conn, coords)
    elapsed = time.time() - t0

    print(f"\n{'='*50}")
    print(f"Moves: {len(sol)} | Time: {elapsed:.1f}s")
    print(f"\nRune:\n{rout}")
    print(f"\nPlain:\n{pout}")
    print(f"{'='*50}")
    try:
        conn.send(b"q")
    except Exception:
        pass
    conn.close()

if __name__ == "__main__":
    main()
