"""Golden transcript hash test for deterministic regression checks."""

from __future__ import annotations

import hashlib

from app.config import load_config
from app.session import MirrorBusSession


GOLDEN_TRANSCRIPT = [
    "STATUS",
    "ENQ INJ 0 7",
    "ENQ ROT 2",
    "ENQ MIX 1 2 3",
    "COMMIT",
    "POLL 64",
    "ENQ BIAS 4",
    "ENQ ARM",
    "COMMIT",
    "POLL 64",
    "STATUS",
]

GOLDEN_SHA256 = "7ec7b063e59daa5ec57542bb49fa27608111322bbcdc3dc83e0e450be0fff085"


def test_golden_transcript_hash() -> None:
    cfg = load_config({"MB9_SEED": "golden-seed-2026", "FLAG": "flag{golden}"})
    s = MirrorBusSession(cfg)
    lines: list[str] = []
    for cmd in GOLDEN_TRANSCRIPT:
        lines.append(f">>> {cmd}")
        lines.extend(s.handle_line(cmd))
    payload = ("\n".join(lines) + "\n").encode("utf-8")
    assert hashlib.sha256(payload).hexdigest() == GOLDEN_SHA256

