"""pytest fixtures for MirrorBus-9."""

from __future__ import annotations

import pathlib
import sys

import pytest

ROOT = pathlib.Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from app.config import load_config  # noqa: E402
from app.session import MirrorBusSession  # noqa: E402


@pytest.fixture
def make_session():
    def _make(seed: str = "pytest-seed", flag: str = "flag{pytest}") -> MirrorBusSession:
        cfg = load_config({"MB9_SEED": seed, "FLAG": flag, "MB9_DEBUG": "0"})
        return MirrorBusSession(cfg)

    return _make

