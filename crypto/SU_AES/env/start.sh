#!/bin/sh
set -eu

PORT="${PORT:-9999}"
CHAL="/home/ctf/chal.py"

# Inject dynamic flag for common CTF platforms.
python3 - <<'PY'
import os
from pathlib import Path

secret = Path('/home/ctf/secret.py')
flag = os.getenv('FLAG') or os.getenv('GZCTF_FLAG') or os.getenv('DASCTF')
if flag:
    old = secret.read_text(encoding='utf-8', errors='ignore')
    use_bytes = 'flag = b' in old
    value = repr(flag.encode()) if use_bytes else repr(flag)
    secret.write_text(f'flag = {value}\n', encoding='utf-8')
PY

# no_socket crypto mode: create a python session for each TCP connection.
socat TCP4-LISTEN:"${PORT}",reuseaddr,fork EXEC:"python3 -u ${CHAL}",stderr &

# Keep container alive for platform acceptance checks.
tail -f /dev/null