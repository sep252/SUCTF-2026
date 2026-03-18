"""Shared helpers for MirrorBus-9 author tools."""

from __future__ import annotations

from typing import Dict, Iterable, Tuple


MOD = 65521


def parse_kv_line(line: str) -> tuple[str, Dict[str, str]]:
    tokens = line.strip().split()
    if not tokens:
        return "", {}
    head = tokens[0]
    fields: Dict[str, str] = {}
    for token in tokens[1:]:
        if "=" not in token:
            continue
        k, v = token.split("=", 1)
        fields[k] = v
    return head, fields


def inv_mod(x: int, mod: int = MOD) -> int:
    x %= mod
    if x == 0:
        raise ValueError("non-invertible value")
    return pow(x, -1, mod)


def solve_2x2(
    a11: int,
    a12: int,
    a21: int,
    a22: int,
    b1: int,
    b2: int,
    mod: int = MOD,
) -> Tuple[int, int]:
    det = (a11 * a22 - a12 * a21) % mod
    inv_det = inv_mod(det, mod)
    x1 = ((b1 * a22 - b2 * a12) * inv_det) % mod
    x2 = ((a11 * b2 - a21 * b1) * inv_det) % mod
    return x1, x2


def crc16_ccitt(data: bytes) -> int:
    crc = 0xFFFF
    for byte in data:
        crc ^= byte << 8
        for _ in range(8):
            if crc & 0x8000:
                crc = ((crc << 1) ^ 0x1021) & 0xFFFF
            else:
                crc = (crc << 1) & 0xFFFF
    return crc


def first_frame_by_tag(lines: Iterable[str], wanted_tag: str) -> Dict[str, str] | None:
    for line in lines:
        head, fields = parse_kv_line(line)
        if head != "F":
            continue
        if fields.get("tag") == wanted_tag:
            return fields
    return None

