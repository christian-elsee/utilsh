#!/bin/sh
## Opens a background tunnel - mostly convenience
## because I keep forgetting the arguments.
## tunnel.sh host port
set -euo pipefail
2>/dev/null >&3 || exec 3>/dev/null

## fnc
logger() { command logger $@ 2>&3 ;}

## env
: ${IFACE=127.0.0.1}

: ${1?req! host}
: ${2?req! port}

## main
logger -sp DEBUG -- "Enter" \
    :: "host=$1" \
    	 "port=$2"

ssh -N -L "127.0.0.1:$2:$IFACE:$2" "$1" &
