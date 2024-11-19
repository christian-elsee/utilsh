#!/bin/bash
## Decrypts a given path to the clipboard and executes an arbitrary statement
#$ ./clpass.sh path/to/password.enc gopass an/arbitrary/secret
set -euo pipefail
2>/dev/null >&3 || exec 3>/dev/null

## fnc
logger() { command logger $@ 2>&3 ;}
cleanup() { local status=$?
  logger -sp DEBUG -- "Cleanup" \
    :: "status=$status"

  pbcopy </dev/null
  logger -sp INFO -- "Clipboard cleared"
}

## env
export OPENSSLARGS="enc -d -aes-256-cbc"
path=${1?path/to/enc/pass}

shift

## main
logger -sp DEBUG -- "Enter" \
  :: "openssl-arguments=$OPENSSLARGS" \
     "path=$path" \
     "statement=$@"

trap "cleanup" EXIT INT TERM
logger -sp DEBUG -- "Registered kernel trap" \
  :: "path=$path"

{ <"$path" base64 -d &>/dev/null \
  && <"$path" base64 -d \
  || <"$path" cat

} | openssl $OPENSSLARGS 2>&3 \
  | pbcopy
logger -sp INFO -- "Decrypted path" \
  :: "openssl-arguments=$OPENSSLARGS" \
     "path=$path"

"$@"
logger -sp DEBUG -- "Executed statement" \
   :: "path=$path" \
      "statement=$@"
