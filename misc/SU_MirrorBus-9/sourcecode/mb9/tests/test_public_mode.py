"""Public deployment mode tests."""

from __future__ import annotations

from app.config import load_config
from app.session import MirrorBusSession


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


def run(session: MirrorBusSession) -> list[str]:
    out: list[str] = []
    for cmd in TRANSCRIPT:
        out.append(f">>> {cmd}")
        out.extend(session.handle_line(cmd))
    return out


def make_public_session() -> MirrorBusSession:
    cfg = load_config({"MB9_SEED": "public-shared-seed", "MB9_SESSION_SEED_MODE": "per_connection"})
    return MirrorBusSession(cfg)


def test_per_connection_seed_keeps_reset_replay_stable() -> None:
    session = make_public_session()
    session.handle_line("RESET")
    first = run(session)
    session.handle_line("RESET")
    second = run(session)
    assert first == second


def test_per_connection_seed_changes_across_connections() -> None:
    s1 = make_public_session()
    s2 = make_public_session()
    banner1 = s1.banner_lines()
    banner2 = s2.banner_lines()
    assert banner1[0] != banner2[0]
    assert "seed_mode=per_connection" in banner1[0]
    assert "replay_scope=session" in banner1[1]
    assert run(s1) != run(s2)
