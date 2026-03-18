#!/usr/bin/env python3
"""Preflight checker for organizer handoff and on-call smoke."""

from __future__ import annotations

import argparse
import pathlib
import stat
import sys
import zipfile

ROOT = pathlib.Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from author_tools.mb9_client import MB9Client


REQUIRED_REL_PATHS = [
    "sourcecode/mb9/app/main.py",
    "sourcecode/mb9/app/session.py",
    "sourcecode/mb9/author_tools/solve_reference.py",
    "sourcecode/mb9/author_tools/replay_check.py",
    "sourcecode/mb9/author_tools/validate_seeds.py",
    "sourcecode/mb9/author_tools/preflight_check.py",
    "sourcecode/mb9/author_tools/concurrency_smoke.py",
    "sourcecode/mb9/tests/test_protocol.py",
    "sourcecode/mb9/tests/test_gate.py",
    "sourcecode/mb9/tests/test_fuzzlite.py",
    "sourcecode/mb9/tests/test_transcript_hash.py",
    "sourcecode/mb9/docs/ORGANIZER_DEPLOY.md",
    "sourcecode/mb9/docs/JUDGE_QUICKREF.md",
    "sourcecode/mb9/docs/POSTMORTEM_OUTLINE.md",
    "env/pwn_deploy/Dockerfile",
    "env/pwn_deploy/ctf.xinetd",
    "env/pwn_deploy/start.sh",
    "env/pwn_deploy/docker-compose.yml",
    "script/pushflag.sh",
]


def _is_executable(path: pathlib.Path) -> bool:
    mode = path.stat().st_mode
    return bool(mode & stat.S_IXUSR)


def static_checks(repo_root: pathlib.Path) -> list[str]:
    issues: list[str] = []
    for rel in REQUIRED_REL_PATHS:
        p = repo_root / rel
        if not p.exists():
            issues.append(f"missing:{rel}")

    if sys.platform != "win32":
        for rel in ("env/pwn_deploy/start.sh", "script/pushflag.sh"):
            p = repo_root / rel
            if p.exists() and not _is_executable(p):
                issues.append(f"not_executable:{rel}")

    zip_path = repo_root / "sourcecode/sourcecode.zip"
    if not zip_path.exists():
        issues.append("missing:sourcecode/sourcecode.zip")
    else:
        with zipfile.ZipFile(zip_path, "r") as zf:
            bad = []
            for name in zf.namelist():
                low = name.lower()
                if "__pycache__" in low or ".pytest_cache" in low or "/venv/" in low:
                    bad.append(name)
            if bad:
                issues.append(f"zip_contains_cache:{len(bad)}")
    return issues


def remote_smoke(host: str, port: int, timeout: float) -> list[str]:
    issues: list[str] = []
    client = MB9Client(host=host, port=port, timeout=timeout)
    try:
        help_lines = client.cmd("HELP")
        status_line = client.cmd("STATUS")[0]
        qok = client.cmd("ENQ NOP")[0]
        cok = client.cmd("COMMIT")[0]
        pok = client.cmd("POLL 8")[0]
    finally:
        client.close()

    if not any(line.startswith("OK cmd=HELP") for line in help_lines):
        issues.append("smoke:help_missing_ok")
    if not status_line.startswith("OK cmd=STATUS"):
        issues.append("smoke:status_bad")
    if not qok.startswith("QOK "):
        issues.append("smoke:enq_bad")
    if not cok.startswith("COK "):
        issues.append("smoke:commit_bad")
    if not pok.startswith("POK "):
        issues.append("smoke:poll_bad")
    return issues


def main() -> int:
    parser = argparse.ArgumentParser(description="MirrorBus-9 preflight check")
    parser.add_argument(
        "--repo-root",
        default=str(pathlib.Path(__file__).resolve().parents[3]),
        help="challenge root that contains env/, sourcecode/, script/",
    )
    parser.add_argument("--host", default="")
    parser.add_argument("--port", type=int, default=9999)
    parser.add_argument("--timeout", type=float, default=5.0)
    parser.add_argument(
        "--skip-static",
        action="store_true",
        help="skip repository layout checks (useful in deployed container mode)",
    )
    args = parser.parse_args()

    repo_root = pathlib.Path(args.repo_root).resolve()
    issues: list[str] = []
    if not args.skip_static:
        issues.extend(static_checks(repo_root))
    if args.host:
        issues.extend(remote_smoke(args.host, args.port, args.timeout))

    if issues:
        print("PRECHECK_FAIL")
        for item in issues:
            print(item)
        return 1

    print("PRECHECK_PASS")
    print(f"repo_root={repo_root}")
    if args.host:
        print(f"remote_smoke={args.host}:{args.port}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
