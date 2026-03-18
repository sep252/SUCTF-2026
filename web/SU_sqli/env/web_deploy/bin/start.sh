#!/usr/bin/env bash
set -euo pipefail

POSTGRES_DB="${POSTGRES_DB:-ctf}"
POSTGRES_USER="${POSTGRES_USER:-postgres}"
POSTGRES_PASSWORD="${POSTGRES_PASSWORD:-postgres}"
PORT="${PORT:-8080}"
DATABASE_URL="${DATABASE_URL:-postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@127.0.0.1:5432/${POSTGRES_DB}?sslmode=disable}"

export POSTGRES_DB POSTGRES_USER POSTGRES_PASSWORD PORT DATABASE_URL

pg_pid=""
web_pid=""

cleanup() {
  if [[ -n "${web_pid}" ]] && kill -0 "${web_pid}" 2>/dev/null; then
    kill "${web_pid}" 2>/dev/null || true
  fi
  if [[ -n "${pg_pid}" ]] && kill -0 "${pg_pid}" 2>/dev/null; then
    kill "${pg_pid}" 2>/dev/null || true
  fi
  wait 2>/dev/null || true
}
trap cleanup INT TERM

echo "[start] starting PostgreSQL..."
docker-entrypoint.sh postgres &
pg_pid=$!

echo "[start] waiting for PostgreSQL readiness..."
ready=0
for _ in $(seq 1 60); do
  if pg_isready -h 127.0.0.1 -p 5432 -U "${POSTGRES_USER}" >/dev/null 2>&1; then
    ready=1
    break
  fi
  if ! kill -0 "${pg_pid}" 2>/dev/null; then
    echo "[ERROR] PostgreSQL exited before becoming ready." >&2
    exit 1
  fi
  sleep 1
done
if [[ "${ready}" -ne 1 ]]; then
  echo "[ERROR] PostgreSQL not ready after timeout." >&2
  exit 1
fi

echo "[start] starting web service..."
/app/server &
web_pid=$!
sleep 1
if ! kill -0 "${web_pid}" 2>/dev/null; then
  echo "[ERROR] /app/server failed to start." >&2
  exit 1
fi

echo "[start] PostgreSQL and web service are running."
while true; do
  if ! kill -0 "${pg_pid}" 2>/dev/null; then
    echo "[ERROR] PostgreSQL process exited unexpectedly." >&2
    exit 1
  fi
  if ! kill -0 "${web_pid}" 2>/dev/null; then
    echo "[ERROR] Web process exited unexpectedly." >&2
    exit 1
  fi
  sleep 2
done
