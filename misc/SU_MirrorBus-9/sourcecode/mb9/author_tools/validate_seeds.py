#!/usr/bin/env python3
"""Batch seed validation: determinism + solvability sanity checks."""

from __future__ import annotations

import argparse
import collections
import pathlib
import sys
import time
from typing import Dict, Tuple

ROOT = pathlib.Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from app.config import load_config  # noqa: E402
from app.session import MirrorBusSession  # noqa: E402
from author_tools.common import MOD, crc16_ccitt, parse_kv_line, solve_2x2  # noqa: E402


def run_trial(session: MirrorBusSession, injections: Dict[int, int]) -> Dict[str, str]:
    session.handle_line("RESET")
    for lane, value in sorted(injections.items()):
        session.handle_line(f"ENQ INJ {lane} {value}")
    session.handle_line("ENQ ARM")
    session.handle_line("COMMIT")
    for _ in range(8):
        lines = session.handle_line("POLL 64")
        for line in lines:
            head, fields = parse_kv_line(line)
            if head == "F" and fields.get("tag") in {"ARM_FAIL", "CHAL"}:
                return fields
    raise RuntimeError("trial did not emit ARM_FAIL/CHAL")


def run_pair_trial(session: MirrorBusSession, lane_i: int, value_i: int, lane_j: int, value_j: int) -> Dict[str, str]:
    session.handle_line("RESET")
    session.handle_line(f"ENQ INJ {lane_i} {value_i}")
    session.handle_line(f"ENQ INJ {lane_j} {value_j}")
    session.handle_line("ENQ ARM")
    session.handle_line("COMMIT")
    for _ in range(8):
        lines = session.handle_line("POLL 64")
        for line in lines:
            head, fields = parse_kv_line(line)
            if head == "F" and fields.get("tag") in {"ARM_FAIL", "CHAL"}:
                return fields
    raise RuntimeError("pair trial did not emit ARM_FAIL/CHAL")


def derive_prove(chal: Dict[str, str]) -> Tuple[int, int, int]:
    nonce = chal["nonce"]
    p1 = int(chal["sig"]) % MOD
    p2 = int(chal["aux"]) % MOD
    p3 = crc16_ccitt(f"{nonce}:{p1}:{p2}".encode("utf-8"))
    return p1, p2, p3


def validate_one_seed(seed: str) -> tuple[bool, str]:
    cfg = load_config({"FLAG": "flag{seed_check}", "MB9_SEED": seed})
    session = MirrorBusSession(cfg)
    base = run_trial(session, {})
    if base.get("tag") == "CHAL":
        p1, p2, p3 = derive_prove(base)
        line = session.handle_line(f"PROVE {p1} {p2} {p3}")[0]
        return ("status=PASS" in line, "direct_challenge")

    chosen = None
    d0 = (0, 0)
    for li in range(9):
        for lj in range(li + 1, 9):
            base2 = run_pair_trial(session, li, 0, lj, 0)
            if base2.get("tag") == "CHAL":
                p1, p2, p3 = derive_prove(base2)
                line = session.handle_line(f"PROVE {p1} {p2} {p3}")[0]
                return ("status=PASS" in line, "solved")
            d0 = (int(base2["sig"]) % MOD, int(base2["aux"]) % MOD)
            tri = run_pair_trial(session, li, 1, lj, 0)
            trj = run_pair_trial(session, li, 0, lj, 1)
            if tri.get("tag") != "ARM_FAIL" or trj.get("tag") != "ARM_FAIL":
                continue
            di = (int(tri["sig"]) % MOD, int(tri["aux"]) % MOD)
            dj = (int(trj["sig"]) % MOD, int(trj["aux"]) % MOD)
            ei = ((d0[0] - di[0]) % MOD, (d0[1] - di[1]) % MOD)
            ej = ((d0[0] - dj[0]) % MOD, (d0[1] - dj[1]) % MOD)
            if (ei[0] * ej[1] - ei[1] * ej[0]) % MOD != 0:
                chosen = (li, lj, ei, ej, d0)
                break
        if chosen is not None:
            break
    if chosen is None:
        return False, "no_invertible_pair"

    li, lj, ei, ej, d0 = chosen
    vi, vj = solve_2x2(ei[0], ej[0], ei[1], ej[1], d0[0], d0[1], mod=MOD)
    vi %= MOD
    vj %= MOD

    for _ in range(4):
        got = run_pair_trial(session, li, vi, lj, vj)
        if got.get("tag") == "CHAL":
            p1, p2, p3 = derive_prove(got)
            line = session.handle_line(f"PROVE {p1} {p2} {p3}")[0]
            return ("status=PASS" in line, "solved")
        rd = (int(got["sig"]) % MOD, int(got["aux"]) % MOD)
        c1, c2 = solve_2x2(ei[0], ej[0], ei[1], ej[1], rd[0], rd[1], mod=MOD)
        vi = (vi + c1) % MOD
        vj = (vj + c2) % MOD

    return False, "not_converged"


def main() -> int:
    parser = argparse.ArgumentParser(description="MirrorBus-9 seed validator")
    parser.add_argument("--prefix", default="seed-")
    parser.add_argument("--count", type=int, default=20)
    parser.add_argument("--start", type=int, default=0)
    parser.add_argument("--seed", action="append", dest="seeds", default=None)
    parser.add_argument("--min-pass-rate", type=float, default=1.0)
    args = parser.parse_args()

    if args.seeds:
        seeds = args.seeds
    else:
        seeds = [f"{args.prefix}{args.start + i}" for i in range(args.count)]

    t0 = time.perf_counter()
    ok = 0
    reasons = collections.Counter()
    for seed in seeds:
        try:
            passed, reason = validate_one_seed(seed)
        except Exception as exc:  # noqa: BLE001
            passed = False
            reason = f"exception_{type(exc).__name__}"
        if passed:
            ok += 1
        reasons[reason] += 1
        print(f"seed={seed} pass={int(passed)} reason={reason}")
    total = len(seeds)
    fail = total - ok
    pass_rate = (ok / total) if total else 0.0
    elapsed = time.perf_counter() - t0
    print(f"summary total={total} pass={ok} fail={fail} pass_rate={pass_rate:.4f} elapsed_s={elapsed:.3f}")
    for reason, count in sorted(reasons.items()):
        print(f"reason={reason} count={count}")
    return 0 if pass_rate >= args.min_pass_rate else 1


if __name__ == "__main__":
    raise SystemExit(main())



