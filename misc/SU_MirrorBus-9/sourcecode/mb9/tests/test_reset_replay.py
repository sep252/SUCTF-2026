"""RESET replay invariants."""

from __future__ import annotations


TRANSCRIPT = [
    "ENQ INJ 1 11",
    "ENQ MIX 3 5 7",
    "ENQ ROT -1",
    "COMMIT",
    "POLL 64",
    "STATUS",
]


def execute(session) -> list[str]:
    out: list[str] = []
    for cmd in TRANSCRIPT:
        out.append(f">>> {cmd}")
        out.extend(session.handle_line(cmd))
    return out


def test_reset_replay_same_output(make_session) -> None:
    session = make_session(seed="replay-seed")
    session.handle_line("RESET")
    first = execute(session)
    session.handle_line("RESET")
    second = execute(session)
    assert first == second

