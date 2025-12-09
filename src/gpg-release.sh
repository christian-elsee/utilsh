#!/bin/bash
## Decrypts a given path and writes the result to
## a gpg key's passphrase cache
set -euo pipefail
2>/dev/null >&3 || exec 3>/dev/null

## fnc
logger() { command logger $@ 2>&3 ;}
release() { local argv=${@?}
  : \
  | gpg -ae $@ \
  | gpg -d --passphrase-fd 100

} 100<&0

## env
export OPENSSLARGS="enc -d -aes-256-cbc"
export DEFAULT_RECIPIENT=christian@accelerate

path=${1?req! path/to/enc/pass}
recipient=${2:-$DEFAULT_RECIPIENT}
gpgargs="-r $recipient"

## main
logger -sp DEBUG -- "Enter" \
  :: "openssl-arguments=$OPENSSLARGS" \
     "path=$path" \
     "recipient=$recipient"

if : | release $gpgargs ;then
  logger -sp DEBUG -- "Determined private key" \
    :: "path=$path" \
       "gpgargs=$gpgargs" \
       "released=true"

else
  # check if path is base64 encoded - if the
  # case decode, otherwise write to stdout
  logger -sp DEBUG -- "Determined private key" \
    :: "path=$path" \
       "gpgargs=$gpgargs" \
       "released=false"

  { <"$path" base64 -d &>/dev/null \
      && <"$path" base64 -d \
      || <"$path" cat

  } | openssl $OPENSSLARGS \
    | release $gpgargs

fi &>/dev/fd/3
logger -sp INFO -- "Private key released" \
    :: "path=$path" \
       "gpgargs=$gpgargs"
