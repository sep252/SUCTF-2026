#!/bin/sh
set -eu

# Hardened policy: runtime ignores FLAG env and reads flag from file only.
unset FLAG || true

# Difficulty profile (default: eased for better solve rate).
# Organizers can override these at container runtime if needed.
# Public target hardening:
# - use a distinct deterministic seed per TCP connection
# - keep RESET replay stable inside the same connection
export MB9_SESSION_SEED_MODE="${MB9_SESSION_SEED_MODE:-per_connection}"
export MB9_STATE_AMP="${MB9_STATE_AMP:-2}"
export MB9_OBS_AMP="${MB9_OBS_AMP:-6}"
export MB9_DELAY_MIN="${MB9_DELAY_MIN:-0}"
export MB9_DELAY_SPAN="${MB9_DELAY_SPAN:-1}"
export MB9_ARM_TTL="${MB9_ARM_TTL:-192}"
export MB9_PROVE_ATTEMPTS="${MB9_PROVE_ATTEMPTS:-7}"

if [ ! -s /home/ctf/flag ] && [ ! -s /flag ]; then
    echo "[mirrorbus9] missing flag file: expected /home/ctf/flag or /flag" >&2
    exit 1
fi

SERVICE_CFG="/etc/xinetd.d/ctf"
if [ ! -f "$SERVICE_CFG" ]; then
    echo "[mirrorbus9] missing xinetd service config: $SERVICE_CFG" >&2
    exit 1
fi

SERVER_BIN="$(awk -F= '/^[[:space:]]*server[[:space:]]*=/{gsub(/[[:space:]]/,"",$2); print $2; exit}' "$SERVICE_CFG")"
if [ -z "$SERVER_BIN" ] || [ ! -x "$SERVER_BIN" ]; then
    echo "[mirrorbus9] invalid server executable in $SERVICE_CFG: ${SERVER_BIN:-<empty>}" >&2
    exit 1
fi

SERVER_ARGS="$(awk -F= '/^[[:space:]]*server_args[[:space:]]*=/{sub(/^[[:space:]]*/,"",$2); print $2; exit}' "$SERVICE_CFG")"
for token in $SERVER_ARGS; do
    token="$(printf '%s' "$token" | tr -d '\r')"
    case "$token" in
        /*.py|/*.pyw|/*.sh|/*.pl|/*.rb)
            if [ ! -f "$token" ]; then
                echo "[mirrorbus9] missing server script in $SERVICE_CFG: $token" >&2
                exit 1
            fi
            ;;
    esac
done

exec /usr/sbin/xinetd -dontfork -stayalive -f /etc/xinetd.conf
