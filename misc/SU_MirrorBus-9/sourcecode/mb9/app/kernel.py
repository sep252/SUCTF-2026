"""MirrorBus-9 hidden state kernel."""

from __future__ import annotations

from dataclasses import dataclass
from typing import Sequence

from app.noise import DeterministicNoise
from app.utils import stable_hash64


@dataclass
class KernelStep:
    """State transition output needed by the observer and gate."""

    prev2: list[int]
    prev1: list[int]
    prev0: list[int]
    new_state: list[int]
    sig: int
    aux: int
    lane_hint: int


class MirrorKernel:
    """
    9-dimensional linear-ish deterministic kernel with explicit history.

    The update intentionally depends on x_t, x_{t-1}, x_{t-2} to force
    long-range tracking in black-box identification.
    """

    def __init__(self, seed_int: int, mod: int, dim: int, noise: DeterministicNoise) -> None:
        self.seed_int = seed_int
        self.mod = mod
        self.dim = dim
        self.noise = noise

        # Per-lane dynamics coefficients.
        self.alpha = [2 + self._coef("alpha", i, 7) for i in range(dim)]
        self.beta = [1 + self._coef("beta", i, 5) for i in range(dim)]
        self.gamma = [1 + self._coef("gamma", i, 5) for i in range(dim)]

        # Observer projections.
        self.w_sig0 = [1 + self._coef("w_sig0", i, mod - 1) for i in range(dim)]
        self.w_sig1 = [1 + self._coef("w_sig1", i, mod - 1) for i in range(dim)]
        self.w_sig2 = [1 + self._coef("w_sig2", i, mod - 1) for i in range(dim)]
        self.w_aux0 = [1 + self._coef("w_aux0", i, mod - 1) for i in range(dim)]
        self.w_aux1 = [1 + self._coef("w_aux1", i, mod - 1) for i in range(dim)]

        self._x2: list[int] = []
        self._x1: list[int] = []
        self._x0: list[int] = []
        self.reset()

    def _coef(self, tag: str, index: int, modulus: int) -> int:
        text = f"{self.seed_int}|{tag}|{index}"
        return stable_hash64(text) % modulus

    def _init_vec(self, tag: str) -> list[int]:
        out: list[int] = []
        for i in range(self.dim):
            out.append(self._coef(tag, i, self.mod))
        return out

    def reset(self) -> None:
        self._x2 = self._init_vec("init_x2")
        self._x1 = self._init_vec("init_x1")
        self._x0 = self._init_vec("init_x0")

    def state(self) -> list[int]:
        return list(self._x0)

    def _dot(self, a: Sequence[int], b: Sequence[int]) -> int:
        total = 0
        for x, y in zip(a, b):
            total = (total + x * y) % self.mod
        return total

    def step(self, control: Sequence[int], tick: int, phase: int) -> KernelStep:
        """
        Apply one state transition and produce mixed observation projections.

        phase participates in lane index rotation, making command order and
        command type history matter for inference.
        """
        prev2 = list(self._x2)
        prev1 = list(self._x1)
        prev0 = list(self._x0)
        eta = self.noise.eta_vector(tick=tick, dim=self.dim, mod=self.mod)
        nxt = [0] * self.dim

        for i in range(self.dim):
            j0 = (i + phase) % self.dim
            j1 = (i + 2) % self.dim
            j2 = (i + 5) % self.dim
            val = (
                self.alpha[i] * prev0[j0]
                + self.beta[i] * prev2[j1]
                + self.gamma[i] * prev1[j2]
                + int(control[i])
                + eta[i]
            )
            nxt[i] = val % self.mod

        ctrl_mix = 0
        for i, value in enumerate(control):
            ctrl_mix = (ctrl_mix + (i + 1) * int(value)) % self.mod

        sig = (
            self._dot(self.w_sig0, nxt)
            + self._dot(self.w_sig1, prev0)
            + self._dot(self.w_sig2, prev2)
            + ctrl_mix
            + self.noise.obs_noise(tick=tick, channel=1, mod=self.mod)
        ) % self.mod
        aux = (
            self._dot(self.w_aux0, nxt)
            + self._dot(self.w_aux1, prev1)
            + (phase * 97)
            + self.noise.obs_noise(tick=tick, channel=2, mod=self.mod)
        ) % self.mod

        lane_hint = (phase + nxt[0] + prev0[3]) % self.dim

        self._x2, self._x1, self._x0 = prev1, prev0, nxt
        return KernelStep(
            prev2=prev2,
            prev1=prev1,
            prev0=prev0,
            new_state=nxt,
            sig=sig,
            aux=aux,
            lane_hint=lane_hint,
        )

