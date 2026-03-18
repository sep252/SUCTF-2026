#!/bin/sh
set -eu

HOST="${1:-127.0.0.1}"
PORT="${2:-9999}"

cd /home/ctf/mb9
python3 -m author_tools.preflight_check --skip-static --host "$HOST" --port "$PORT"
python3 -m author_tools.replay_check --host "$HOST" --port "$PORT"
python3 -m author_tools.validate_seeds --prefix smoke-seed- --count 8 --min-pass-rate 1.0

echo "SELF_CHECK_PASS host=$HOST port=$PORT"
