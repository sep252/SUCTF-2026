"""ARM/PROVE final gate logic."""

from __future__ import annotations

import hashlib
from dataclasses import dataclass
from typing import Sequence

from app.errors import MB9Error
from app.utils import crc16_ccitt, stable_hash64


@dataclass
class ArmOutcome:
    """Result of evaluating an ARM command against the hidden state."""

    success: bool
    sig: int
    aux: int
    nonce: str = ""
    ttl: int = 0


@dataclass
class _Challenge:
    nonce: str
    expected_p1: int
    expected_p2: int
    expected_p3: int
    expire_tick: int
    attempts_left: int


class GateEngine:
    """Deterministic final gate state machine."""

    def __init__(self, seed_int: int, mod: int, dim: int, ttl: int = 64, attempts: int = 3) -> None:
        self.seed_int = seed_int
        self.mod = mod
        self.dim = dim
        self.ttl = ttl
        self.attempts = attempts
        self.arm_v1 = [1 + (stable_hash64(f"{seed_int}|arm_v1|{i}") % (mod - 1)) for i in range(dim)]
        self.arm_v2 = [1 + (stable_hash64(f"{seed_int}|arm_v2|{i}") % (mod - 1)) for i in range(dim)]
        self.target1 = stable_hash64(f"{seed_int}|target1") % mod
        self.target2 = stable_hash64(f"{seed_int}|target2") % mod
        self.fail_m11 = 1 + (stable_hash64(f"{seed_int}|fail_m11") % (mod - 1))
        self.fail_m12 = 1 + (stable_hash64(f"{seed_int}|fail_m12") % (mod - 1))
        self.fail_m21 = 1 + (stable_hash64(f"{seed_int}|fail_m21") % (mod - 1))
        self.fail_m22 = 1 + (stable_hash64(f"{seed_int}|fail_m22") % (mod - 1))
        det = (self.fail_m11 * self.fail_m22 - self.fail_m12 * self.fail_m21) % mod
        if det == 0:
            self.fail_m22 = (self.fail_m22 + 1) % mod or 1
        self._challenge: _Challenge | None = None

    def reset(self) -> None:
        self._challenge = None

    def has_active_challenge(self) -> bool:
        return self._challenge is not None

    def _dot(self, a: Sequence[int], b: Sequence[int]) -> int:
        total = 0
        for x, y in zip(a, b):
            total = (total + x * y) % self.mod
        return total

    def _mk_nonce(self, tick: int, cid: int, s1: int, s2: int) -> str:
        payload = f"{self.seed_int}|{tick}|{cid}|{s1}|{s2}".encode("utf-8")
        return hashlib.sha256(payload).hexdigest()[:12]

    def try_arm(self, state: Sequence[int], tick: int, cid: int) -> ArmOutcome:
        s1 = self._dot(self.arm_v1, state)
        s2 = self._dot(self.arm_v2, state)
        d1 = (self.target1 - s1) % self.mod
        d2 = (self.target2 - s2) % self.mod
        if d1 != 0 or d2 != 0:
            self._challenge = None
            # Publish affine-mixed residuals, not raw distances.
            sig = (self.fail_m11 * d1 + self.fail_m12 * d2) % self.mod
            aux = (self.fail_m21 * d1 + self.fail_m22 * d2) % self.mod
            return ArmOutcome(success=False, sig=sig, aux=aux)

        nonce = self._mk_nonce(tick=tick, cid=cid, s1=s1, s2=s2)

        # Eased gate profile:
        # - CHAL publishes the two projections directly (sig=s1, aux=s2).
        # - Final step still requires recognizing the 16-bit CCITT checksum path.
        p1 = s1
        p2 = s2
        p3 = crc16_ccitt(f"{nonce}:{p1}:{p2}".encode("utf-8"))

        ttl = self.ttl
        self._challenge = _Challenge(
            nonce=nonce,
            expected_p1=p1,
            expected_p2=p2,
            expected_p3=p3,
            expire_tick=tick + ttl,
            attempts_left=self.attempts,
        )
        return ArmOutcome(success=True, sig=s1, aux=s2, nonce=nonce, ttl=ttl)

    def verify_prove(self, p1: int, p2: int, p3: int, tick: int) -> None:
        chal = self._challenge
        if chal is None:
            raise MB9Error("E_STATE", "no_active_challenge")
        if tick > chal.expire_tick:
            self._challenge = None
            raise MB9Error("E_STATE", "challenge_expired")
        if p1 == chal.expected_p1 and p2 == chal.expected_p2 and p3 == chal.expected_p3:
            self._challenge = None
            return
        chal.attempts_left -= 1
        if chal.attempts_left <= 0:
            self._challenge = None
        raise MB9Error("E_PROVE", "bad_proof")



