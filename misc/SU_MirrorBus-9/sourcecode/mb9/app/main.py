#!/usr/bin/env python3
"""xinetd stdio entrypoint for MirrorBus-9."""

from __future__ import annotations

import pathlib
import sys
import traceback


def _bootstrap_import_path() -> None:
    root = pathlib.Path(__file__).resolve().parents[1]
    root_s = str(root)
    if root_s not in sys.path:
        sys.path.insert(0, root_s)


def _safe_print(line: str) -> bool:
    """Print one protocol line and return whether the stream is still writable."""
    try:
        print(line, flush=True)
        return True
    except (BrokenPipeError, OSError):
        return False


def _drain_oversized_line() -> None:
    """Discard bytes until next newline/EOF after detecting a too-long line."""
    while True:
        chunk = sys.stdin.buffer.readline(4096)
        if chunk == b"" or chunk.endswith(b"\n"):
            return


def _read_bounded_line(limit: int) -> tuple[str | None, bool]:
    """
    Read one line from stdin with a hard byte cap.

    Returns:
    - (None, False): EOF
    - (line, False): normal line
    - ("", True): oversized line was drained and should be rejected
    """
    raw = sys.stdin.buffer.readline(limit + 2)
    if raw == b"":
        return None, False
    if len(raw) > limit and not raw.endswith(b"\n"):
        _drain_oversized_line()
        return "", True
    return raw.decode("utf-8", errors="replace"), False


def main() -> int:
    _bootstrap_import_path()
    from app.config import load_config
    from app.session import MirrorBusSession

    cfg = load_config()
    session = MirrorBusSession(cfg)

    for line in session.banner_lines():
        if not _safe_print(line):
            return 0

    while True:
        raw, too_long = _read_bounded_line(cfg.line_limit)
        if raw is None:
            break
        if too_long:
            if not _safe_print("ERR code=E_PARSE msg=line_too_long"):
                return 0
            continue
        try:
            replies = session.handle_line(raw)
        except Exception:
            if cfg.debug:
                traceback.print_exc(file=sys.stderr)
            if not _safe_print("ERR code=E_FATAL msg=internal"):
                return 0
            break
        for line in replies:
            if not _safe_print(line):
                return 0
        if not session.is_alive():
            break
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
