#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

rm -f "$SCRIPT_DIR/jeewms.war"
(cd "$SCRIPT_DIR/jeewms" && zip -rq ../jeewms.war .)

echo "Repacked: $SCRIPT_DIR/jeewms.war"
