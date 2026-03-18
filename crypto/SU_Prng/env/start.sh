#!/bin/sh
set -eu

PORT="${PORT:-9999}"
CHAL="/home/ctf/chal.py"

# Prefer dynamic flags used by common CTF platforms.
python3 - <<'PY'
import os
from pathlib import Path

flag = os.getenv("FLAG") or os.getenv("GZCTF_FLAG") or os.getenv("DASCTF")
if flag:
    Path("/home/ctf/secret.py").write_text(f"flag = {flag!r}\n", encoding="utf-8")
PY

# no_socket crypto mode: spawn one python session per TCP connection.
socat TCP4-LISTEN:"${PORT}",reuseaddr,fork EXEC:"python3 -u ${CHAL}",stderr &

# Keep container alive as required by acceptance rule.
tail -f /dev/null