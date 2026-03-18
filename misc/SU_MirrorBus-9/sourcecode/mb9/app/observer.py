"""Delayed observation queue and POLL delivery."""

from __future__ import annotations

import heapq
from dataclasses import dataclass, field
from typing import Dict

from app.utils import kv_line


@dataclass(order=True)
class ScheduledFrame:
    """A frame scheduled for delayed publication."""

    ready_tick: int
    seq: int
    line: str = field(compare=False)


class Observer:
    """Maintains delayed and ready frame queues."""

    def __init__(self) -> None:
        self._seq = 0
        self._pending: list[ScheduledFrame] = []
        self._ready: list[str] = []

    def reset(self) -> None:
        self._seq = 0
        self._pending.clear()
        self._ready.clear()

    @property
    def backlog(self) -> int:
        return len(self._ready) + len(self._pending)

    def _next_seq(self) -> int:
        self._seq += 1
        return self._seq

    def schedule_line(self, ready_tick: int, line: str) -> None:
        seq = self._next_seq()
        heapq.heappush(self._pending, ScheduledFrame(ready_tick=ready_tick, seq=seq, line=line))

    def schedule_frame(
        self,
        ready_tick: int,
        cid: int,
        tick: int,
        lane: int,
        sig: int,
        aux: int,
        tag: str,
        extra: Dict[str, object] | None = None,
    ) -> None:
        fields: Dict[str, object] = {
            "cid": cid,
            "tick": tick,
            "lane": lane,
            "sig": sig,
            "aux": aux,
            "tag": tag,
        }
        if extra:
            fields.update(extra)
        line = kv_line("F", fields)
        self.schedule_line(ready_tick=ready_tick, line=line)

    def advance(self, now_tick: int) -> None:
        while self._pending and self._pending[0].ready_tick <= now_tick:
            item = heapq.heappop(self._pending)
            self._ready.append(item.line)

    def poll(self, k: int, now_tick: int) -> list[str]:
        self.advance(now_tick)
        if k <= 0:
            return []
        count = min(k, len(self._ready))
        out = self._ready[:count]
        self._ready = self._ready[count:]
        return out

