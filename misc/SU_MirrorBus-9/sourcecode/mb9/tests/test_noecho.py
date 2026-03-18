"""No-echo semantics tests."""

from __future__ import annotations


def test_enq_only_ack_no_observation(make_session) -> None:
    session = make_session()
    line = session.handle_line("ENQ INJ 0 42")[0]
    assert line.startswith("QOK ")
    assert "sig=" not in line
    assert "aux=" not in line


def test_observation_only_appears_after_commit_and_poll(make_session) -> None:
    session = make_session()
    session.handle_line("ENQ INJ 0 1")
    session.handle_line("ENQ MIX 2 3 5")
    session.handle_line("COMMIT")
    polled = session.handle_line("POLL 64")
    assert polled[0].startswith("POK ")
    assert polled[-1] == "END"
    assert any(line.startswith("F ") for line in polled)

