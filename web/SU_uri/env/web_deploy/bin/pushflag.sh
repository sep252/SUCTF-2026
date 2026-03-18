#!/bin/sh
set -eu

# Template baseline only.
# Current challenge uses static flag chain (setup/readflag.c -> /readflag output),
# not dynamic DB/file injection in the main web container.

if [ "$#" -lt 1 ]; then
  echo "usage: $0 'flag{...}'" >&2
  exit 1
fi

FLAG_VALUE="$1"
echo "$FLAG_VALUE" > /flag

echo "[NOTICE] static-flag challenge currently; env/web_deploy/bin/pushflag.sh not fully wired."
