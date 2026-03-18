#!/bin/bash
set -euo pipefail

echo "[setup] step1: write decoy /host/flag"
cat >/host/flag <<'EOF'
Flag is not here. executable /readflag to get it!
EOF
chown root:root /host/flag
chmod 400 /host/flag

if [ -x /host/readflag ]; then
  echo "[setup] step2: /host/readflag already exists, skipping compile"
else
  echo "[setup] step2: compile /setup/readflag.c -> /host/readflag"
  if [ ! -f /setup/readflag.c ]; then
    echo "[setup] ERROR: missing /setup/readflag.c and /host/readflag not present" >&2
    exit 1
  fi
  gcc -static -O2 -s -o /host/readflag /setup/readflag.c
fi

echo "[setup] step3: set permissions for /host/readflag"
chown root:root /host/readflag
chmod 4755 /host/readflag

echo "[setup] done"
