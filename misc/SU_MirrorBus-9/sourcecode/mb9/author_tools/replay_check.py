#!/usr/bin/env python3
"""Replay determinism checker over TCP."""

from __future__ import annotations

import argparse
import pathlib
import sys
from typing import List

ROOT = pathlib.Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from author_tools.mb9_client import MB9Client


TRANSCRIPT = [
    "STATUS",
    "ENQ INJ 0 7",
    "ENQ MIX 3 5 7",
    "ENQ ROT 1",
    "COMMIT",
    "POLL 64",
    "STATUS",
]


def run_transcript(client: MB9Client, transcript: List[str]) -> List[str]:
    out: list[str] = []
    for cmd in transcript:
        lines = client.cmd(cmd)
        out.append(f">>> {cmd}")
        out.extend(lines)
    return out


def main() -> int:
    parser = argparse.ArgumentParser(description="MirrorBus-9 replay checker")
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", default=9999, type=int)
    parser.add_argument("--timeout", default=5.0, type=float)
    args = parser.parse_args()

    client = MB9Client(host=args.host, port=args.port, timeout=args.timeout)
    try:
        client.cmd("RESET")
        first = run_transcript(client, TRANSCRIPT)
        client.cmd("RESET")
        second = run_transcript(client, TRANSCRIPT)
    finally:
        client.close()

    if first == second:
        print("PASS deterministic replay")
        return 0

    print("FAIL deterministic replay")
    limit = min(len(first), len(second))
    idx = 0
    while idx < limit and first[idx] == second[idx]:
        idx += 1
    print(f"first_diff_index={idx}")
    if idx < len(first):
        print(f"first[{idx}]={first[idx]}")
    if idx < len(second):
        print(f"second[{idx}]={second[idx]}")
    return 1


if __name__ == "__main__":
    sys.exit(main())
