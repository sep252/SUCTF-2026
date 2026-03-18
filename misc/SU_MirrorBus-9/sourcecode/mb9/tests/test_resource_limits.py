"""Resource budget tests to prevent session abuse."""

from __future__ import annotations

from app.config import load_config
from app.session import MirrorBusSession


def test_command_budget_enforced() -> None:
    cfg = load_config(
        {
            "MB9_SEED": "limit-seed-cmd",
            "FLAG": "flag{limit}",
            "MB9_MAX_COMMANDS": "128",
        }
    )
    s = MirrorBusSession(cfg)
    for _ in range(128):
        line = s.handle_line("STATUS")[0]
        assert line.startswith("OK cmd=STATUS")
    out = s.handle_line("STATUS")[0]
    assert out.startswith("ERR code=E_LIMIT")
    assert not s.is_alive()


def test_tick_budget_enforced() -> None:
    cfg = load_config(
        {
            "MB9_SEED": "limit-seed-tick",
            "FLAG": "flag{limit}",
            "MB9_MAX_TICK": "512",
        }
    )
    s = MirrorBusSession(cfg)
    for _ in range(512):
        s.handle_line("POLL 1")
    out = s.handle_line("POLL 1")[0]
    assert out.startswith("ERR code=E_LIMIT")
    assert not s.is_alive()
