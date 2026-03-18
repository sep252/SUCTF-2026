#!/bin/sh
set -eu

# Root is needed to access /var/run/docker.sock (mounted from host, typically root-owned).
# We start socat as root, then drop privileges to ctfer for the Go web app.
socat TCP-LISTEN:2375,bind=127.0.0.1,reuseaddr,fork UNIX-CONNECT:/var/run/docker.sock &

exec su-exec ctfer:ctfer /app/cloudhook-service

