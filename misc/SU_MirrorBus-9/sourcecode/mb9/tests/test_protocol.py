"""Protocol parsing and boundary tests."""

from __future__ import annotations

from app.config import load_config
from app.session import MirrorBusSession, PARTICIPANT_GIFT_FLAG


def test_unknown_command(make_session) -> None:
    session = make_session()
    out = session.handle_line("WHAT")
    assert out[0].startswith("ERR code=E_CMD")


def test_enq_requires_opcode(make_session) -> None:
    session = make_session()
    out = session.handle_line("ENQ")
    assert out[0].startswith("ERR code=E_ARGS")


def test_commit_argument_range(make_session) -> None:
    session = make_session()
    out = session.handle_line("COMMIT -1")
    assert out[0].startswith("ERR code=E_RANGE")


def test_prove_argument_count(make_session) -> None:
    session = make_session()
    out = session.handle_line("PROVE 1 2")
    assert out[0].startswith("ERR code=E_ARGS")


def test_commit_zero_does_not_advance_cid(make_session) -> None:
    session = make_session()
    out = session.handle_line("COMMIT 0")[0]
    assert out.startswith("COK ")
    assert "cid=0" in out


def test_poll_default_respects_poll_limit() -> None:
    cfg = load_config({"MB9_SEED": "poll-limit-seed", "FLAG": "flag{x}", "MB9_POLL_LIMIT": "4"})
    session = MirrorBusSession(cfg)
    out = session.handle_line("POLL")[0]
    assert out.startswith("POK ")
    assert "requested=4" in out


def test_banner_contains_participant_gift_flag(make_session) -> None:
    session = make_session()
    banner = session.banner_lines()
    assert len(banner) == 2
    assert f"gift={PARTICIPANT_GIFT_FLAG}" in banner[1]
