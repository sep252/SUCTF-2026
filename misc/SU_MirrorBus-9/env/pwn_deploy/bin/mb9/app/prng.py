"""Deterministic PRNG utilities."""

from __future__ import annotations

from dataclasses import dataclass


@dataclass
class LCG31:
    """Classic 31-bit LCG used for deterministic but portable generation."""

    state: int

    _A = 1103515245
    _C = 12345
    _M = 1 << 31

    def __post_init__(self) -> None:
        self.state %= self._M

    def next_u31(self) -> int:
        self.state = (self._A * self.state + self._C) % self._M
        return self.state

    def rand_mod(self, modulus: int) -> int:
        if modulus <= 0:
            raise ValueError("modulus must be positive")
        return self.next_u31() % modulus

