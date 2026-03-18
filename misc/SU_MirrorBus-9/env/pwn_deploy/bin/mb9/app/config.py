"""Configuration loading for MirrorBus-9."""

from __future__ import annotations

import hashlib
import os
from dataclasses import dataclass
from typing import Mapping

from app.utils import bool_from_env


@dataclass(frozen=True)
class MB9Config:
    """Runtime config with deterministic parameters."""

    flag: str
    seed_raw: str
    seed_int: int
    debug: bool
    mod: int = 65521
    dimension: int = 9
    max_queue: int = 256
    poll_limit: int = 128
    line_limit: int = 512
    max_commands: int = 4096
    max_tick: int = 20000
    state_amp: int = 7
    obs_amp: int = 17
    delay_min: int = 2
    delay_span: int = 3
    arm_ttl: int = 64
    prove_attempts: int = 3
    reveal_seed_tag: bool = False
    session_seed_mode: str = "fixed"


def _read_flag_from_file(path: str) -> str | None:
    try:
        with open(path, "r", encoding="utf-8") as f:
            value = f.read().strip()
    except OSError:
        return None
    return value or None


def _load_flag(env: Mapping[str, str]) -> str:
    """
    FLAG loading policy (hardened):
    1. /home/ctf/flag
    2. /flag

    NOTE:
    - Runtime no longer trusts FLAG environment variable to avoid
      accidental deployment leakage via container metadata.
    """
    for path in ("/home/ctf/flag", "/flag"):
        got = _read_flag_from_file(path)
        if got:
            return got
    return "flag{MirrorBus9_default_flag_replace_me}"


def _derive_seed(seed_raw: str, team_token: str | None) -> int:
    material = seed_raw
    if team_token:
        material = f"{seed_raw}|{team_token}"
    digest = hashlib.sha256(material.encode("utf-8")).digest()
    return int.from_bytes(digest[:8], "big")


def derive_session_seed(base_seed_int: int, session_tag: str) -> int:
    """Derive a deterministic per-session seed from a fixed base seed."""
    payload = f"{base_seed_int}|session|{session_tag}".encode("utf-8")
    digest = hashlib.sha256(payload).digest()
    return int.from_bytes(digest[:8], "big")


def _env_int(
    env: Mapping[str, str],
    key: str,
    default: int,
    min_v: int,
    max_v: int,
) -> int:
    raw = env.get(key)
    if raw is None:
        return default
    try:
        value = int(raw.strip(), 10)
    except ValueError:
        return default
    if value < min_v:
        return min_v
    if value > max_v:
        return max_v
    return value


def _seed_mode_from_env(raw: str | None) -> str:
    if raw is None:
        return "fixed"
    value = raw.strip().lower()
    if value in {"fixed", "static", "instance"}:
        return "fixed"
    if value in {"per_connection", "connection", "session", "per_session"}:
        return "per_connection"
    return "fixed"


def load_config(env: Mapping[str, str] | None = None) -> MB9Config:
    """Load config from env-like mapping."""
    if env is None:
        env = os.environ
    seed_raw = env.get("MB9_SEED", "mirrorbus9-default-seed").strip()
    team_token = env.get("TEAM_TOKEN", "").strip() or None
    seed_int = _derive_seed(seed_raw, team_token)
    debug = bool_from_env(env.get("MB9_DEBUG"), default=False)
    reveal_seed_tag = bool_from_env(env.get("MB9_REVEAL_SEED_TAG"), default=False)
    session_seed_mode = _seed_mode_from_env(env.get("MB9_SESSION_SEED_MODE"))
    flag = _load_flag(env)
    max_queue = _env_int(env, "MB9_MAX_QUEUE", 256, 8, 4096)
    poll_limit = _env_int(env, "MB9_POLL_LIMIT", 128, 1, 2048)
    line_limit = _env_int(env, "MB9_LINE_LIMIT", 512, 64, 4096)
    max_commands = _env_int(env, "MB9_MAX_COMMANDS", 4096, 128, 200000)
    max_tick = _env_int(env, "MB9_MAX_TICK", 20000, 512, 2000000)
    state_amp = _env_int(env, "MB9_STATE_AMP", 7, 0, 128)
    obs_amp = _env_int(env, "MB9_OBS_AMP", 17, 0, 256)
    delay_min = _env_int(env, "MB9_DELAY_MIN", 2, 0, 64)
    delay_span = _env_int(env, "MB9_DELAY_SPAN", 3, 1, 64)
    arm_ttl = _env_int(env, "MB9_ARM_TTL", 64, 4, 2048)
    prove_attempts = _env_int(env, "MB9_PROVE_ATTEMPTS", 3, 1, 16)

    return MB9Config(
        flag=flag,
        seed_raw=seed_raw,
        seed_int=seed_int,
        debug=debug,
        max_queue=max_queue,
        poll_limit=poll_limit,
        line_limit=line_limit,
        max_commands=max_commands,
        max_tick=max_tick,
        state_amp=state_amp,
        obs_amp=obs_amp,
        delay_min=delay_min,
        delay_span=delay_span,
        arm_ttl=arm_ttl,
        prove_attempts=prove_attempts,
        reveal_seed_tag=reveal_seed_tag,
        session_seed_mode=session_seed_mode,
    )
