#!/usr/bin/env python3
"""Reference black-box solve flow for MirrorBus-9."""

from __future__ import annotations

import argparse
import pathlib
import sys
from typing import Dict, Iterable, Tuple

ROOT = pathlib.Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from author_tools.common import MOD, crc16_ccitt, first_frame_by_tag, parse_kv_line, solve_2x2
from author_tools.mb9_client import MB9Client


def poll_until(client: MB9Client, wanted_tags: Iterable[str], rounds: int = 8) -> Dict[str, str]:
    wanted = set(wanted_tags)
    for _ in range(rounds):
        lines = client.cmd("POLL 64")
        for line in lines:
            head, fields = parse_kv_line(line)
            if head != "F":
                continue
            tag = fields.get("tag")
            if tag in wanted:
                return fields
    raise RuntimeError(f"no wanted frame after polling: {sorted(wanted)}")


def run_trial(client: MB9Client, injections: Dict[int, int]) -> Dict[str, str]:
    client.cmd("RESET")
    for lane, value in sorted(injections.items()):
        client.cmd(f"ENQ INJ {lane} {value}")
    client.cmd("ENQ ARM")
    client.cmd("COMMIT")
    return poll_until(client, wanted_tags={"ARM_FAIL", "CHAL"})


def run_pair_trial(client: MB9Client, lane_i: int, value_i: int, lane_j: int, value_j: int) -> Dict[str, str]:
    client.cmd("RESET")
    client.cmd(f"ENQ INJ {lane_i} {value_i}")
    client.cmd(f"ENQ INJ {lane_j} {value_j}")
    client.cmd("ENQ ARM")
    client.cmd("COMMIT")
    return poll_until(client, wanted_tags={"ARM_FAIL", "CHAL"})


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
        line = client.cmd(f"PROVE {p1} {p2} {p3}")[0]
        return line

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

    # One Newton-like correction loop for nonlinear residue.
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
    parser = argparse.ArgumentParser(description="MirrorBus-9 reference black-box solver")
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", default=9999, type=int)
    parser.add_argument("--timeout", default=5.0, type=float)
    args = parser.parse_args()

    client = MB9Client(host=args.host, port=args.port, timeout=args.timeout)
    try:
        line = solve(client)
    finally:
        client.close()

    print(line)
    if "status=PASS" not in line:
        return 2
    if "flag=" not in line:
        return 3
    return 0


if __name__ == "__main__":
    sys.exit(main())



