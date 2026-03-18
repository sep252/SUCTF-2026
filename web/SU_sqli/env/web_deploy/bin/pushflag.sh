#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "usage: $0 'flag{...}'" >&2
  exit 1
fi

FLAG_VALUE="$1"
POSTGRES_DB="${POSTGRES_DB:-ctf}"
POSTGRES_USER="${POSTGRES_USER:-postgres}"
POSTGRES_PASSWORD="${POSTGRES_PASSWORD:-postgres}"
export PGPASSWORD="${POSTGRES_PASSWORD}"

echo "${FLAG_VALUE}" > /flag

if pg_isready -h 127.0.0.1 -p 5432 -U "${POSTGRES_USER}" >/dev/null 2>&1; then
  FLAG_ESCAPED="$(printf "%s" "${FLAG_VALUE}" | sed "s/'/''/g")"
  psql -h 127.0.0.1 -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" -v ON_ERROR_STOP=1 \
    -c "UPDATE secrets SET flag='${FLAG_ESCAPED}' WHERE id=1;" >/dev/null
  echo "[pushflag] updated /flag and database secrets.flag(id=1)."
else
  echo "[pushflag] PostgreSQL not ready, updated /flag only." >&2
fi
