#!/usr/bin/env bash
# Run docker compose with a working Docker socket connection.
# Refreshes the docker group via sg(1) when the current shell lacks it.
set -euo pipefail

DOCKER_BIN="${DOCKER_BIN:-/bin/docker}"

run_compose() {
  "${DOCKER_BIN}" compose "$@"
}

if run_compose version >/dev/null 2>&1; then
  exec "${DOCKER_BIN}" compose "$@"
fi

if command -v sg >/dev/null 2>&1 && sg docker -c "${DOCKER_BIN} info" >/dev/null 2>&1; then
  quoted=()
  for arg in "$@"; do
    quoted+=("$(printf '%q' "$arg")")
  done
  # shellcheck disable=SC2086
  exec sg docker -c "${DOCKER_BIN} compose ${quoted[*]}"
fi

cat >&2 <<'EOF'
error: cannot run docker compose (permission denied).

You are likely in the docker group but this shell session does not have it yet.
Try one of:

  newgrp docker
  sg docker -c "make docker-build"

Or open a new login shell after being added to the docker group.
EOF
exit 1
