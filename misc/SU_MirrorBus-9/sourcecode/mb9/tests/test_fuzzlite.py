"""Structured fuzz-lite tests for parser/runtime hardening."""

from __future__ import annotations


FUZZ_LINES = [
    "",
    " ",
    "\t\t",
    "UNKNOWN",
    "ENQ",
    "ENQ INJ",
    "ENQ INJ x 1",
    "ENQ INJ 999999 1",
    "ENQ ROT 999999",
    "ENQ MIX 1 2",
    "POLL -1",
    "COMMIT -1",
    "PROVE 1 2",
    "HELP extra",
    "STATUS extra",
    ("A" * 600),
    "ENQ NOP\0",
]


def test_fuzzlite_inputs_do_not_raise(make_session) -> None:
    session = make_session(seed="fuzz-lite-seed")
    for line in FUZZ_LINES:
        out = session.handle_line(line)
        assert isinstance(out, list)
        assert len(out) >= 1
        assert out[0].startswith("ERR ") or out[0].startswith("OK ") or out[0].startswith("QOK ") or out[0].startswith("COK ") or out[0].startswith("POK ")

