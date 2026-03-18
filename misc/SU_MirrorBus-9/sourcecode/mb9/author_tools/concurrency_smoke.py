#!/usr/bin/env python3
"""Concurrent connection smoke test against xinetd service."""

from __future__ import annotations

import argparse
import concurrent.futures
import pathlib
import sys

ROOT = pathlib.Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from author_tools.mb9_client import MB9Client


def worker(host: str, port: int, timeout: float, rounds: int) -> tuple[bool, str]:
    try:
        client = MB9Client(host=host, port=port, timeout=timeout)
        try:
            for _ in range(rounds):
                status = client.cmd("STATUS")[0]
                if not status.startswith("OK cmd=STATUS"):
                    return False, f"bad_status:{status}"
                ping = client.cmd("PING")[0]
                if not ping.startswith("OK cmd=PING"):
                    return False, f"bad_ping:{ping}"
            client.cmd("QUIT")
        finally:
            client.close()
    except Exception as exc:  # noqa: BLE001
        return False, f"exception:{exc}"
    return True, "ok"


def main() -> int:
    parser = argparse.ArgumentParser(description="MirrorBus-9 concurrent smoke")
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", type=int, default=9999)
    parser.add_argument("--timeout", type=float, default=5.0)
    parser.add_argument("--workers", type=int, default=16)
    parser.add_argument("--rounds", type=int, default=3)
    args = parser.parse_args()

    ok = 0
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.workers) as pool:
        futs = [pool.submit(worker, args.host, args.port, args.timeout, args.rounds) for _ in range(args.workers)]
        for idx, fut in enumerate(futs):
            passed, reason = fut.result()
            ok += int(passed)
            print(f"worker={idx} pass={int(passed)} reason={reason}")

    print(f"summary total={args.workers} pass={ok} fail={args.workers - ok}")
    return 0 if ok == args.workers else 1


if __name__ == "__main__":
    sys.exit(main())
