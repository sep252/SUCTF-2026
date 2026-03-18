"""Small line-oriented TCP client for MirrorBus-9."""

from __future__ import annotations

import socket
from dataclasses import dataclass
from typing import List


@dataclass
class MB9Client:
    host: str
    port: int
    timeout: float = 5.0

    def __post_init__(self) -> None:
        self.sock = socket.create_connection((self.host, self.port), timeout=self.timeout)
        self.sock.settimeout(self.timeout)
        self.rfile = self.sock.makefile("r", encoding="utf-8", newline="\n")
        self.wfile = self.sock.makefile("w", encoding="utf-8", newline="\n")

        # Consume deterministic two-line banner.
        self.banner = [self._readline(), self._readline()]

    def close(self) -> None:
        try:
            self.wfile.close()
        finally:
            try:
                self.rfile.close()
            finally:
                self.sock.close()

    def _readline(self) -> str:
        line = self.rfile.readline()
        if line == "":
            raise RuntimeError("connection closed")
        return line.rstrip("\r\n")

    def _send(self, cmd: str) -> None:
        self.wfile.write(cmd + "\n")
        self.wfile.flush()

    def cmd(self, cmd: str) -> List[str]:
        cmd_name = cmd.strip().split()[0].upper()
        self._send(cmd)
        if cmd_name == "POLL":
            out: List[str] = []
            while True:
                line = self._readline()
                out.append(line)
                if line == "END":
                    break
            return out
        if cmd_name == "HELP":
            out = []
            while True:
                line = self._readline()
                out.append(line)
                if line.startswith("OK cmd=HELP") or line.startswith("ERR "):
                    break
            return out
        return [self._readline()]

