"""Queueing and opcode normalization for half-duplex command execution."""

from __future__ import annotations

from dataclasses import dataclass
from typing import List, Sequence

from app.errors import MB9Error
from app.utils import parse_int


SUPPORTED_OPCODES = {"INJ", "ROT", "MIX", "BIAS", "NOP", "ARM"}


@dataclass
class QueueItem:
    """A normalized queued operation."""

    qid: int
    opcode: str
    args: List[int]
    raw: str


class QueueEngine:
    """FIFO queue with protocol-level command normalization."""

    def __init__(self, max_queue: int, dim: int, mod: int) -> None:
        self.max_queue = max_queue
        self.dim = dim
        self.mod = mod
        self._next_qid = 1
        self._items: list[QueueItem] = []

    def reset(self) -> None:
        self._next_qid = 1
        self._items.clear()

    @property
    def size(self) -> int:
        return len(self._items)

    def list_ops(self) -> list[str]:
        return sorted(SUPPORTED_OPCODES)

    def _normalize(self, opcode: str, raw_args: Sequence[str]) -> list[int]:
        op = opcode.upper()
        if op not in SUPPORTED_OPCODES:
            raise MB9Error("E_ARGS", "bad_opcode")
        if op == "NOP":
            if raw_args:
                raise MB9Error("E_ARGS", "nop_no_args")
            return []
        if op == "ARM":
            if raw_args:
                raise MB9Error("E_ARGS", "arm_no_args")
            return []
        if op == "INJ":
            if len(raw_args) != 2:
                raise MB9Error("E_ARGS", "inj_need_2")
            lane = parse_int(raw_args[0], "lane", 0, self.dim - 1)
            value = parse_int(raw_args[1], "value", -200000, 200000)
            return [lane, value]
        if op == "ROT":
            if len(raw_args) != 1:
                raise MB9Error("E_ARGS", "rot_need_1")
            delta = parse_int(raw_args[0], "delta", -64, 64)
            return [delta]
        if op == "MIX":
            if len(raw_args) != 3:
                raise MB9Error("E_ARGS", "mix_need_3")
            a = parse_int(raw_args[0], "a", -200000, 200000)
            b = parse_int(raw_args[1], "b", -200000, 200000)
            c = parse_int(raw_args[2], "c", -200000, 200000)
            return [a, b, c]
        if op == "BIAS":
            if len(raw_args) != 1:
                raise MB9Error("E_ARGS", "bias_need_1")
            v = parse_int(raw_args[0], "v", -200000, 200000)
            return [v]
        raise MB9Error("E_ARGS", "unsupported_opcode")

    def enqueue(self, opcode: str, raw_args: Sequence[str], raw_line: str) -> QueueItem:
        if len(self._items) >= self.max_queue:
            raise MB9Error("E_QUEUE", "queue_full")
        op = opcode.upper()
        args = self._normalize(op, raw_args)
        item = QueueItem(qid=self._next_qid, opcode=op, args=args, raw=raw_line)
        self._next_qid += 1
        self._items.append(item)
        return item

    def take(self, n: int) -> list[QueueItem]:
        if n < 0:
            raise MB9Error("E_ARGS", "commit_n_negative")
        if n == 0:
            return []
        n = min(n, len(self._items))
        out = self._items[:n]
        self._items = self._items[n:]
        return out

    def take_all(self) -> list[QueueItem]:
        out = self._items
        self._items = []
        return out

    def control_for(self, item: QueueItem, phase: int) -> tuple[list[int], int]:
        """
        Convert operation to control vector + phase delta.

        For ARM, this method is not used. Session handles ARM as a gate action.
        """
        ctrl = [0] * self.dim
        phase_delta = 0
        op = item.opcode

        if op == "NOP":
            return ctrl, phase_delta

        if op == "INJ":
            lane, value = item.args
            ctrl[lane] = value % self.mod
            return ctrl, phase_delta

        if op == "ROT":
            delta = item.args[0]
            phase_delta = delta % self.dim
            # ROT also injects a small deterministic impulse.
            lane = (phase + phase_delta) % self.dim
            ctrl[lane] = (delta * 131) % self.mod
            return ctrl, phase_delta

        if op == "MIX":
            a, b, c = item.args
            ctrl[(phase + 0) % self.dim] = a % self.mod
            ctrl[(phase + 3) % self.dim] = b % self.mod
            ctrl[(phase + 6) % self.dim] = c % self.mod
            return ctrl, phase_delta

        if op == "BIAS":
            v = item.args[0]
            for i in range(self.dim):
                ctrl[i] = ((i + 1) * v) % self.mod
            return ctrl, phase_delta

        raise MB9Error("E_STATE", "control_for_bad_opcode")

