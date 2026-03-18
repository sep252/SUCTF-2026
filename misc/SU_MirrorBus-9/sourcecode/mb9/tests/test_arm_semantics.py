"""Consistency tests between ARM and ENQ ARM entrypoints."""

from __future__ import annotations


def _run_arm_path(session, arm_cmd: str) -> list[str]:
    session.handle_line("RESET")
    session.handle_line(arm_cmd)
    session.handle_line("COMMIT")
    lines = session.handle_line("POLL 64")
    return lines


def test_arm_and_enq_arm_are_semantically_equivalent(make_session) -> None:
    s1 = make_session(seed="arm-semantic-seed")
    s2 = make_session(seed="arm-semantic-seed")
    polled_1 = _run_arm_path(s1, "ARM")
    polled_2 = _run_arm_path(s2, "ENQ ARM")
    assert polled_1 == polled_2

