#!/bin/bash
## Merge given kubeconfig maps and writes the composite to stdout
## $ kubeconfig-merge.sh path1 [...pathN]
set -euo pipefail
2>/dev/null >&3 || exec 3>/dev/null

## fnc
logger() { command logger $@ 2>&3 ;}

## env
: ${@?req! ...paths}

## main
logger -sp DEBUG -- "Enter" \
    :: "$( echo $@ | base64 | tr -d )"

KUBECONFIG="$( printf "%s:" "$@" )" \
  kubectl config view \
    --merge \
    --flatten
