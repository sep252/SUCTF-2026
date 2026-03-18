#!/usr/bin/env python3
"""
MirrorBus-9 complete exp script (black-box solve).

Usage:
  python exp.py --host 127.0.0.1 --port 9999
"""

from __future__ import annotations

import argparse
import socket
from dataclasses import dataclass
from typing import Dict, Iterable, List, Tuple


MOD = 65521


def parse_kv_line(line: str) -> tuple[str, Dict[str, str]]:
    tokens = line.strip().split()
    if not tokens:
        return "", {}
    head = tokens[0]
    fields: Dict[str, str] = {}
    for token in tokens[1:]:
        if "=" not in token:
            continue
        k, v = token.split("=", 1)
        fields[k] = v
    return head, fields


def inv_mod(x: int, mod: int = MOD) -> int:
    x %= mod
    if x == 0:
        raise ValueError("non-invertible value")
    return pow(x, -1, mod)


def solve_2x2(
    a11: int,
    a12: int,
    a21: int,
    a22: int,
    b1: int,
    b2: int,
    mod: int = MOD,
) -> Tuple[int, int]:
    det = (a11 * a22 - a12 * a21) % mod
    inv_det = inv_mod(det, mod)
    x1 = ((b1 * a22 - b2 * a12) * inv_det) % mod
    x2 = ((a11 * b2 - a21 * b1) * inv_det) % mod
    return x1, x2


def crc16_ccitt(data: bytes) -> int:
    crc = 0xFFFF
    for byte in data:
        crc ^= byte << 8
        for _ in range(8):
            if crc & 0x8000:
                crc = ((crc << 1) ^ 0x1021) & 0xFFFF
            else:
                crc = (crc << 1) & 0xFFFF
    return crc


@dataclass
class MB9Client:
    host: str
    port: int
    timeout: float = 5.0

    def __post_init__(self) -> None:
        self.sock = socket.create_connection((self.host, self.port), timeout=self.timeout)
        self.sock.settimeout(self.timeout)
        self.rfile = self.sock.makefile("r", encoding="utf-8", newline="\n")
        self.wfile = self.sock.makefile("w", encoding="utf-8", newline="\n")
        self.banner = [self._readline(), self._readline()]

    def close(self) -> None:
        try:
            self.wfile.close()
        finally:
            try:
                self.rfile.close()
            finally:
                self.sock.close()

    def _readline(self) -> str:
        line = self.rfile.readline()
        if line == "":
            raise RuntimeError("connection closed")
        return line.rstrip("\r\n")

    def _send(self, cmd: str) -> None:
        self.wfile.write(cmd + "\n")
        self.wfile.flush()

    def cmd(self, cmd: str) -> List[str]:
        cmd_name = cmd.strip().split()[0].upper()
        self._send(cmd)
        if cmd_name == "POLL":
            out: List[str] = []
            while True:
                line = self._readline()
                out.append(line)
                if line == "END":
                    break
            return out
        if cmd_name == "HELP":
            out = []
            while True:
                line = self._readline()
                out.append(line)
                if line.startswith("OK cmd=HELP") or line.startswith("ERR "):
                    break
            return out
        return [self._readline()]


def poll_until(client: MB9Client, wanted_tags: Iterable[str], rounds: int = 8) -> Dict[str, str]:
    wanted = set(wanted_tags)
    for _ in range(rounds):
        lines = client.cmd("POLL 64")
        for line in lines:
            head, fields = parse_kv_line(line)
            if head != "F":
                continue
            if fields.get("tag") in wanted:
                return fields
    raise RuntimeError(f"no wanted frame after polling: {sorted(wanted)}")


def run_trial(client: MB9Client, injections: Dict[int, int]) -> Dict[str, str]:
    client.cmd("RESET")
    for lane, value in sorted(injections.items()):
        client.cmd(f"ENQ INJ {lane} {value}")
    client.cmd("ENQ ARM")
    client.cmd("COMMIT")
    return poll_until(client, {"ARM_FAIL", "CHAL"})


def run_pair_trial(client: MB9Client, lane_i: int, value_i: int, lane_j: int, value_j: int) -> Dict[str, str]:
    client.cmd("RESET")
    client.cmd(f"ENQ INJ {lane_i} {value_i}")
    client.cmd(f"ENQ INJ {lane_j} {value_j}")
    client.cmd("ENQ ARM")
    client.cmd("COMMIT")
    return poll_until(client, {"ARM_FAIL", "CHAL"})


def extract_delta(frame: Dict[str, str]) -> Tuple[int, int]:
    return int(frame["sig"]) % MOD, int(frame["aux"]) % MOD


def compute_prove_from_chal(chal: Dict[str, str]) -> Tuple[int, int, int]:
    nonce = chal["nonce"]
    p1 = int(chal["sig"]) % MOD
    p2 = int(chal["aux"]) % MOD
    p3 = crc16_ccitt(f"{nonce}:{p1}:{p2}".encode("utf-8"))
    return p1, p2, p3


def solve(client: MB9Client) -> str:
    base = run_trial(client, {})
    if base.get("tag") == "CHAL":
        p1, p2, p3 = compute_prove_from_chal(base)
        return client.cmd(f"PROVE {p1} {p2} {p3}")[0]

    chosen = None
    d0_1 = 0
    d0_2 = 0
    for li in range(9):
        for lj in range(li + 1, 9):
            base2 = run_pair_trial(client, li, 0, lj, 0)
            if base2.get("tag") == "CHAL":
                p1, p2, p3 = compute_prove_from_chal(base2)
                return client.cmd(f"PROVE {p1} {p2} {p3}")[0]
            d0_1, d0_2 = extract_delta(base2)

            tri = run_pair_trial(client, li, 1, lj, 0)
            trj = run_pair_trial(client, li, 0, lj, 1)
            if tri.get("tag") != "ARM_FAIL" or trj.get("tag") != "ARM_FAIL":
                continue
            di_1, di_2 = extract_delta(tri)
            dj_1, dj_2 = extract_delta(trj)
            e_i = ((d0_1 - di_1) % MOD, (d0_2 - di_2) % MOD)
            e_j = ((d0_1 - dj_1) % MOD, (d0_2 - dj_2) % MOD)
            det = (e_i[0] * e_j[1] - e_i[1] * e_j[0]) % MOD
            if det != 0:
                chosen = (li, lj, e_i, e_j)
                break
        if chosen is not None:
            break
    if chosen is None:
        raise RuntimeError("no invertible lane pair found")

    li, lj, e_i, e_j = chosen
    vi, vj = solve_2x2(e_i[0], e_j[0], e_i[1], e_j[1], d0_1, d0_2, mod=MOD)
    vi %= MOD
    vj %= MOD

    for _ in range(4):
        result = run_pair_trial(client, li, vi, lj, vj)
        if result.get("tag") == "CHAL":
            p1, p2, p3 = compute_prove_from_chal(result)
            return client.cmd(f"PROVE {p1} {p2} {p3}")[0]
        r1, r2 = extract_delta(result)
        c_i, c_j = solve_2x2(e_i[0], e_j[0], e_i[1], e_j[1], r1, r2, mod=MOD)
        vi = (vi + c_i) % MOD
        vj = (vj + c_j) % MOD

    raise RuntimeError("failed to reach challenge state")


def main() -> int:
    parser = argparse.ArgumentParser(description="MirrorBus-9 complete exp")
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", type=int, default=9999)
    parser.add_argument("--timeout", type=float, default=5.0)
    args = parser.parse_args()

    client = MB9Client(host=args.host, port=args.port, timeout=args.timeout)
    try:
        line = solve(client)
    finally:
        client.close()

    print(line)
    if "status=PASS" not in line or "flag=" not in line:
        return 2
    return 0


if __name__ == "__main__":
    raise SystemExit(main())



