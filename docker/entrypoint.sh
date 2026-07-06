#!/usr/bin/env bash
set -euo pipefail

: "${OPAMROOT:=/lm/users/arul/.opam}"
: "${OPAMSWITCH:=default}"

if [[ ! -w "${HOME:-/}" ]]; then
  export HOME="/workspace/.docker-home"
  export XDG_CACHE_HOME="/workspace/.cache"
  mkdir -p "${HOME}" "${XDG_CACHE_HOME}"
fi

if [[ ! -d "${OPAMROOT}" ]]; then
  echo "error: OPAMROOT not found at ${OPAMROOT}" >&2
  echo "Mount your host opam directory, e.g.:" >&2
  echo "  OPAMROOT=/lm/users/arul/.opam docker compose run --rm build" >&2
  exit 1
fi

if [[ ! -d "${OPAMROOT}/${OPAMSWITCH}" ]]; then
  echo "error: opam switch '${OPAMSWITCH}' not found under ${OPAMROOT}" >&2
  exit 1
fi

export OPAMROOT OPAMSWITCH
# shellcheck disable=SC1090
eval "$(opam env --switch="${OPAMSWITCH}" --set-switch)"

exec "$@"
