"""Session orchestration for the MirrorBus-9 text protocol."""

from __future__ import annotations

import secrets
from dataclasses import dataclass
from typing import Dict, List

from app.config import MB9Config, derive_session_seed
from app.errors import MB9Error
from app.gate import GateEngine
from app.kernel import MirrorKernel
from app.noise import DeterministicNoise
from app.observer import Observer
from app.protocol import ParsedCommand, ProtocolParser
from app.queue_engine import QueueEngine
from app.utils import kv_line, parse_int, stable_hash64


@dataclass
class SessionMeta:
    """Human-readable session metadata."""

    name: str = "MirrorBus-9"
    version: str = "1"


PARTICIPANT_GIFT_FLAG = "SUCTF{TTE05bCE5omL5q2l5p6qLeeDveeBq+WcsOW4pi02SDc0UVNHMEJTQ0RSMzhKRTE1VDc=}"


class MirrorBusSession:
    """Implements command semantics for one connection."""

    def __init__(self, config: MB9Config) -> None:
        self.config = config
        self.meta = SessionMeta()
        self.parser = ProtocolParser(line_limit=config.line_limit)
        self.session_tag = ""
        self.runtime_seed_int = config.seed_int
        if config.session_seed_mode == "per_connection":
            self.session_tag = secrets.token_hex(8)
            self.runtime_seed_int = derive_session_seed(config.seed_int, self.session_tag)
        self.noise = DeterministicNoise(
            seed_int=self.runtime_seed_int,
            state_amp=config.state_amp,
            obs_amp=config.obs_amp,
            delay_min=config.delay_min,
            delay_span=config.delay_span,
        )
        self.kernel = MirrorKernel(
            seed_int=self.runtime_seed_int,
            mod=config.mod,
            dim=config.dimension,
            noise=self.noise,
        )
        self.observer = Observer()
        self.gate = GateEngine(
            seed_int=self.runtime_seed_int,
            mod=config.mod,
            dim=config.dimension,
            ttl=config.arm_ttl,
            attempts=config.prove_attempts,
        )
        self.queue = QueueEngine(max_queue=config.max_queue, dim=config.dimension, mod=config.mod)

        self.phase = 0
        self.tick = 0
        self.commit_id = 0
        self.poll_count = 0
        self.cmd_count = 0
        self.alive = True

    def banner_lines(self) -> list[str]:
        fields: Dict[str, object] = {"name": self.meta.name, "ver": self.meta.version, "mode": "half_duplex"}
        if self.config.session_seed_mode != "fixed":
            fields["seed_mode"] = self.config.session_seed_mode
            fields["sid"] = self.session_tag
        if self.config.reveal_seed_tag:
            fields["seed_tag"] = f"{self.runtime_seed_int & 0xFFFFFFFF:08x}"
        hint = f"MB9_HINT cmd=HELP noecho=1 gift={PARTICIPANT_GIFT_FLAG}"
        if self.config.session_seed_mode == "per_connection":
            hint += " replay_scope=session"
        return [
            kv_line("MB9", fields),
            hint,
        ]

    def is_alive(self) -> bool:
        return self.alive

    def _err(self, exc: MB9Error) -> list[str]:
        return [kv_line("ERR", {"code": exc.code, "msg": exc.msg})]

    def _status_fields(self) -> Dict[str, object]:
        heartbeat = (self.tick * 17 + self.phase * 13 + self.queue.size + self.commit_id) % 100000
        return {
            "cmd": "STATUS",
            "tick": self.tick,
            "phase": self.phase,
            "qlen": self.queue.size,
            "backlog": self.observer.backlog,
            "cid": self.commit_id,
            "challenge": int(self.gate.has_active_challenge()),
            "heartbeat": heartbeat,
        }

    def _advance_tick(self, delta: int) -> None:
        nxt = self.tick + delta
        if nxt > self.config.max_tick:
            raise MB9Error("E_LIMIT", "tick_budget_exhausted")
        self.tick = nxt

    def reset_runtime(self) -> None:
        self.queue.reset()
        self.observer.reset()
        self.gate.reset()
        self.kernel.reset()
        self.phase = 0
        self.tick = 0
        self.commit_id = 0
        self.poll_count = 0

    def handle_line(self, raw_line: str) -> List[str]:
        self.cmd_count += 1
        if self.cmd_count > self.config.max_commands:
            self.alive = False
            return [kv_line("ERR", {"code": "E_LIMIT", "msg": "cmd_budget_exhausted"})]
        try:
            cmd = self.parser.parse(raw_line)
        except MB9Error as exc:
            return self._err(exc)
        try:
            return self._dispatch(cmd)
        except MB9Error as exc:
            if exc.code == "E_LIMIT":
                self.alive = False
            return self._err(exc)

    def _dispatch(self, cmd: ParsedCommand) -> List[str]:
        name = cmd.name
        if name == "HELP":
            return [
                "INFO protocol=MirrorBus-9 noecho=queue_commit_poll",
                "INFO commands=HELP,STATUS,ENQ,ARM,COMMIT,POLL,RESET,PROVE,LIST,VER,PING,QUIT",
                "INFO enq_opcodes=INJ,ROT,MIX,BIAS,NOP,ARM",
                kv_line("OK", {"cmd": "HELP"}),
            ]
        if name == "VER":
            return [kv_line("OK", {"cmd": "VER", "name": self.meta.name, "ver": self.meta.version})]
        if name == "PING":
            return [kv_line("OK", {"cmd": "PING", "pong": self.tick})]
        if name == "LIST":
            opcodes = ",".join(self.queue.list_ops())
            return [kv_line("OK", {"cmd": "LIST", "opcodes": opcodes})]
        if name == "STATUS":
            return [kv_line("OK", self._status_fields())]
        if name == "RESET":
            self.reset_runtime()
            return [kv_line("OK", {"cmd": "RESET", "tick": self.tick, "phase": self.phase, "qlen": 0, "backlog": 0})]
        if name == "QUIT":
            self.alive = False
            return [kv_line("OK", {"cmd": "QUIT", "bye": 1})]
        if name == "ENQ":
            opcode = cmd.args[0]
            raw_args = cmd.args[1:]
            item = self.queue.enqueue(opcode=opcode, raw_args=raw_args, raw_line=cmd.raw)
            return [
                kv_line(
                    "QOK",
                    {"qid": item.qid, "opcode": item.opcode, "argc": len(item.args), "qlen": self.queue.size},
                )
            ]
        if name == "ARM":
            item = self.queue.enqueue(opcode="ARM", raw_args=[], raw_line=cmd.raw)
            return [kv_line("QOK", {"qid": item.qid, "opcode": "ARM", "argc": 0, "qlen": self.queue.size})]
        if name == "COMMIT":
            return self._cmd_commit(cmd.args)
        if name == "POLL":
            return self._cmd_poll(cmd.args)
        if name == "PROVE":
            return self._cmd_prove(cmd.args)
        raise MB9Error("E_CMD", "dispatch_unknown")

    def _cmd_commit(self, args: list[str]) -> list[str]:
        if args:
            n = parse_int(args[0], "n", 0, self.config.max_queue)
            items = self.queue.take(n)
        else:
            items = self.queue.take_all()
        if not items:
            return [
                kv_line(
                    "COK",
                    {
                        "cid": self.commit_id,
                        "exec": 0,
                        "produced": 0,
                        "qlen": self.queue.size,
                        "backlog": self.observer.backlog,
                        "tick": self.tick,
                        "phase": self.phase,
                    },
                )
            ]
        self.commit_id += 1
        cid = self.commit_id

        exec_count = 0
        produced = 0

        for item in items:
            exec_count += 1
            if item.opcode == "ARM":
                out = self.gate.try_arm(state=self.kernel.state(), tick=self.tick, cid=cid)
                cmd_sig = stable_hash64(f"ARM|{item.qid}|{cid}|{self.tick}")
                delay = self.noise.delay(command_sig=cmd_sig, commit_id=cid, tick=self.tick)
                ready_tick = self.tick + delay
                if out.success:
                    self.observer.schedule_frame(
                        ready_tick=ready_tick,
                        cid=cid,
                        tick=self.tick,
                        lane=0,
                        sig=out.sig,
                        aux=out.aux,
                        tag="CHAL",
                        extra={"nonce": out.nonce, "ttl": out.ttl},
                    )
                else:
                    self.observer.schedule_frame(
                        ready_tick=ready_tick,
                        cid=cid,
                        tick=self.tick,
                        lane=0,
                        sig=out.sig,
                        aux=out.aux,
                        tag="ARM_FAIL",
                    )
                produced += 1
                self._advance_tick(1)
                continue

            ctrl, phase_delta = self.queue.control_for(item=item, phase=self.phase)
            self.phase = (self.phase + phase_delta) % self.config.dimension
            step = self.kernel.step(control=ctrl, tick=self.tick, phase=self.phase)

            cmd_sig = stable_hash64(f"{item.opcode}|{item.args}|{item.qid}|{cid}|{self.phase}")
            delay = self.noise.delay(command_sig=cmd_sig, commit_id=cid, tick=self.tick)
            ready_tick = self.tick + delay
            self.observer.schedule_frame(
                ready_tick=ready_tick,
                cid=cid,
                tick=self.tick,
                lane=step.lane_hint,
                sig=step.sig,
                aux=step.aux,
                tag="OBS",
            )
            produced += 1
            self._advance_tick(1)

        self.observer.advance(self.tick)
        return [
            kv_line(
                "COK",
                {
                    "cid": cid,
                    "exec": exec_count,
                    "produced": produced,
                    "qlen": self.queue.size,
                    "backlog": self.observer.backlog,
                    "tick": self.tick,
                    "phase": self.phase,
                },
            )
        ]

    def _cmd_poll(self, args: list[str]) -> list[str]:
        if args:
            k = parse_int(args[0], "k", 1, self.config.poll_limit)
        else:
            k = min(16, self.config.poll_limit)
        self.poll_count += 1
        # Polling advances the bus clock by one cycle so delayed frames can mature
        # even when the queue is currently empty.
        self._advance_tick(1)
        frames = self.observer.poll(k=k, now_tick=self.tick)
        out = [
            kv_line(
                "POK",
                {
                    "requested": k,
                    "count": len(frames),
                    "backlog": self.observer.backlog,
                    "polls": self.poll_count,
                    "tick": self.tick,
                },
            )
        ]
        out.extend(frames)
        out.append("END")
        return out

    def _cmd_prove(self, args: list[str]) -> list[str]:
        p1 = parse_int(args[0], "p1", 0, self.config.mod - 1)
        p2 = parse_int(args[1], "p2", 0, self.config.mod - 1)
        p3 = parse_int(args[2], "p3", 0, 65535)
        self.gate.verify_prove(p1=p1, p2=p2, p3=p3, tick=self.tick)
        return [kv_line("OK", {"cmd": "PROVE", "status": "PASS", "flag": self.config.flag})]
