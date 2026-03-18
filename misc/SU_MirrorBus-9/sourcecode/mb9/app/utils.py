"""Small protocol-safe utility helpers."""

from __future__ import annotations

import hashlib
from typing import Dict

from app.errors import MB9Error


def stable_hash64(text: str) -> int:
    """Deterministic 64-bit hash for protocol scheduling and coefficients."""
    digest = hashlib.blake2b(text.encode("utf-8"), digest_size=8).digest()
    return int.from_bytes(digest, "big")


def crc16_ccitt(data: bytes) -> int:
    """CRC16-CCITT (poly=0x1021, init=0xFFFF)."""
    crc = 0xFFFF
    for byte in data:
        crc ^= byte << 8
        for _ in range(8):
            if crc & 0x8000:
                crc = ((crc << 1) ^ 0x1021) & 0xFFFF
            else:
                crc = (crc << 1) & 0xFFFF
    return crc


def parse_int(token: str, name: str, min_v: int | None = None, max_v: int | None = None) -> int:
    """Parse int token with stable range errors."""
    try:
        value = int(token, 10)
    except ValueError as exc:
        raise MB9Error("E_ARGS", f"bad_int_{name}") from exc
    if min_v is not None and value < min_v:
        raise MB9Error("E_RANGE", f"{name}_lt_{min_v}")
    if max_v is not None and value > max_v:
        raise MB9Error("E_RANGE", f"{name}_gt_{max_v}")
    return value


def bool_from_env(raw: str | None, default: bool = False) -> bool:
    """Parse bool env string with explicit accepted values."""
    if raw is None:
        return default
    val = raw.strip().lower()
    if val in {"1", "true", "yes", "on"}:
        return True
    if val in {"0", "false", "no", "off"}:
        return False
    return default


def kv_line(prefix: str, fields: Dict[str, object]) -> str:
    """Format key=value fields in insertion order."""
    parts = [prefix]
    for key, value in fields.items():
        parts.append(f"{key}={value}")
    return " ".join(parts)

