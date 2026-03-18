"""Deterministic replay tests under same seed."""

from __future__ import annotations


TRANSCRIPT = [
    "STATUS",
    "ENQ INJ 0 7",
    "ENQ ROT 2",
    "ENQ MIX 1 2 3",
    "COMMIT",
    "POLL 64",
    "ENQ BIAS 4",
    "COMMIT",
    "POLL 64",
]


def run(session) -> list[str]:
    out: list[str] = []
    for cmd in TRANSCRIPT:
        out.append(f">>> {cmd}")
        out.extend(session.handle_line(cmd))
    return out


def test_same_seed_same_transcript_same_output(make_session) -> None:
    s1 = make_session(seed="det-seed")
    s2 = make_session(seed="det-seed")
    assert run(s1) == run(s2)

