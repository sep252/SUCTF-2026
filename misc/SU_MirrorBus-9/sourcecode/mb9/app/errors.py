"""Error types and stable error codes for the MirrorBus-9 protocol."""

from dataclasses import dataclass


@dataclass
class MB9Error(Exception):
    """A user-facing protocol/runtime error."""

    code: str
    msg: str

    def __str__(self) -> str:
        return f"{self.code}:{self.msg}"

