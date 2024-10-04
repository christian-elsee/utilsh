#!/bin/bash
## Launches Google Chrome on macos and performs cleanup on process exit
#$ ./chrome.sh "/Applications/Google Chrome.app"
set -euo pipefail
2>/dev/null >&3 || exec 3>/dev/null

## fnc
logger() { command logger $@ 2>&3 ;}
cleanup() { local status=$? app=$1 garbage=${2:-}
  logger -sp DEBUG -- "Trapped signal" \
    :: "status=$status" \
       "app=$app" \
       "gargage=$garbage"

  # kill all app instances with the exception of current pid
  pgrep -f "$app" \
    | grep -v "$$" \
    | xargs kill 2>&3 \
  ||: 
  logger -sp DEBUG -- "Killed chrome" \
    :: "status=$status" \
       "app=$app" \
       "gargage=$*"

  # remove that garbage
  printf "$garbage" \
    | tr : \\0 \
    | xargs -0n1 -- sh -c 'rm -rvf "$1" &>/dev/fd/3' _  \
  ||:  
  logger -sp DEBUG -- "Removed chrome garbage" \
    :: "status=$status" \
       "app=$app" \
       "gargage=$*"    
}

## env
export GARBAGE=${GARBAGE:-"$HOME/Library/Google:$HOME/Library/Application Support/Google:"}

pathdotapp=${1:-/Applications/Google\ Chrome.app/}

## main
logger -sp DEBUG -- "Enter" \
  :: "path=$pathdotapp" \
     "remove=$GARBAGE"

trap "cleanup '$pathdotapp' '$GARBAGE'" EXIT INT TERM
logger -sp DEBUG -- "Registered kernel trap" \
  :: "path=$pathdotapp" \
     "remove=$GARBAGE"

open -W "$pathdotapp" & wait
logger -sp DEBUG -- "Chrome process exited" \
  :: "path=$pathdotapp" \
     "remove=$GARBAGE"
