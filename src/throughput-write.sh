#!/bin/bash
## Determine write throughput to given mount path (directory)
set -euo pipefail

## fnc
cleanup() { local status=$1 target=$2
  logger -sp DEBUG -- "Cleanup" \
    :: "status=$status" \
       "target=$target"

  rm -rf "$target"
}
trap 'cleanup "$?" $target' INT TERM

## env
: ${1?path}

target="$1/$( mktemp -uq | xargs basename )"

## main
logger -sp DEBUG -- "Enter" "path=$1" "target=$target"

</dev/zero pv >"$target"
