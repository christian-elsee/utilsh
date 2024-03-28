#!/bin/bash
## Determine read throughput for a given target (file)
set -euo pipefail

## env
: ${1?path}

## main
logger -sp DEBUG -- "Enter" "path=$1"

<"$1" pv >/dev/null
