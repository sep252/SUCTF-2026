"""Deterministic noise and delay schedule."""

from __future__ import annotations

import hashlib
from dataclasses import dataclass


@dataclass
class DeterministicNoise:
    """
    Noise source with random-access sampling.

    The noise is deterministic from (seed, tick, channel), so replay with the
    same transcript is bit-for-bit identical.
    """

    seed_int: int
    state_amp: int = 7
    obs_amp: int = 17
    delay_min: int = 2
    delay_span: int = 3

    def _sample_u32(self, tick: int, channel: int, salt: str) -> int:
        payload = f"{self.seed_int}|{tick}|{channel}|{salt}".encode("utf-8")
        digest = hashlib.sha256(payload).digest()
        return int.from_bytes(digest[:4], "big")

    def _centered(self, raw_u32: int, amp: int) -> int:
        span = 2 * amp + 1
        return (raw_u32 % span) - amp

    def eta_vector(self, tick: int, dim: int, mod: int) -> list[int]:
        out: list[int] = []
        for i in range(dim):
            centered = self._centered(self._sample_u32(tick, i, "eta"), self.state_amp)
            out.append(centered % mod)
        return out

    def obs_noise(self, tick: int, channel: int, mod: int) -> int:
        centered = self._centered(self._sample_u32(tick, channel, "obs"), self.obs_amp)
        return centered % mod

    def delay(self, command_sig: int, commit_id: int, tick: int) -> int:
        """
        Deterministic delay in [delay_min, delay_min + delay_span - 1].
        """
        mix = (command_sig ^ (commit_id << 9) ^ (tick << 3) ^ self.seed_int) & 0xFFFFFFFF
        return self.delay_min + (mix % self.delay_span)
