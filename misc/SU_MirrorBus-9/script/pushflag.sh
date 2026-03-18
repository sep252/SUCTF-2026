#! /bin/bash
set -eu

if [ $# -lt 1 ]; then
    echo "usage: pushflag.sh <flag>"
    exit 1
fi

FLAG_VALUE="$1"

# MirrorBus-9 compatibility:
# service reads flag from file only:
# - /home/ctf/flag
# - /flag
mkdir -p /home/ctf
echo "$FLAG_VALUE" > /home/ctf/flag
echo "$FLAG_VALUE" > /flag
