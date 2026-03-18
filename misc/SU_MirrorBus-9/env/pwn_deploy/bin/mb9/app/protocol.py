"""Text protocol parser for MirrorBus-9."""

from __future__ import annotations

from dataclasses import dataclass

from app.errors import MB9Error


@dataclass
class ParsedCommand:
    """Parsed command line."""

    name: str
    args: list[str]
    raw: str


class ProtocolParser:
    """Strict parser with stable error behavior."""

    def __init__(self, line_limit: int = 512) -> None:
        self.line_limit = line_limit

    def parse(self, raw_line: str) -> ParsedCommand:
        line = raw_line.rstrip("\r\n")
        if not line:
            raise MB9Error("E_PARSE", "empty_line")
        if len(line) > self.line_limit:
            raise MB9Error("E_PARSE", "line_too_long")
        if "\x00" in line:
            raise MB9Error("E_PARSE", "nul_byte")
        tokens = line.strip().split()
        if not tokens:
            raise MB9Error("E_PARSE", "empty_tokens")

        name = tokens[0].upper()
        args = tokens[1:]

        if name in {"HELP", "STATUS", "RESET", "ARM", "QUIT", "VER", "PING", "LIST"}:
            if args:
                raise MB9Error("E_ARGS", f"{name.lower()}_no_args")
            return ParsedCommand(name=name, args=args, raw=line)

        if name == "ENQ":
            if len(args) < 1:
                raise MB9Error("E_ARGS", "enq_need_opcode")
            return ParsedCommand(name=name, args=args, raw=line)

        if name == "COMMIT":
            if len(args) > 1:
                raise MB9Error("E_ARGS", "commit_need_0_or_1")
            return ParsedCommand(name=name, args=args, raw=line)

        if name == "POLL":
            if len(args) > 1:
                raise MB9Error("E_ARGS", "poll_need_0_or_1")
            return ParsedCommand(name=name, args=args, raw=line)

        if name == "PROVE":
            if len(args) != 3:
                raise MB9Error("E_ARGS", "prove_need_3")
            return ParsedCommand(name=name, args=args, raw=line)

        raise MB9Error("E_CMD", "unknown_command")
