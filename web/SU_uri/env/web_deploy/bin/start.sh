#!/bin/sh
set -eu

# Single-image bootstrap:
# 1) prepare /host/flag and /host/readflag
# 2) then run original service entrypoint
if [ ! -d /host ]; then
  echo "[setup] ERROR: /host mount not found" >&2
  exit 1
fi

echo "[setup] step1: write decoy /host/flag"
cat >/host/flag <<'EOF'
Flag is not here. executable /readflag to get it!
EOF
chown root:root /host/flag
chmod 400 /host/flag

if [ -x /host/readflag ]; then
  echo "[setup] step2: /host/readflag already exists, skipping copy"
else
  echo "[setup] step2: install /app/readflag -> /host/readflag"
  cp /app/readflag /host/readflag
fi

echo "[setup] step3: set permissions for /host/readflag"
chown root:root /host/readflag
chmod 4755 /host/readflag

echo "[setup] done"
exec /entrypoint.sh
