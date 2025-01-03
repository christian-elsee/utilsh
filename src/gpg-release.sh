#!/bin/bash
## Decrypts a given path and writes the result to
## a gpg key's passphrase cache
set -euo pipefail
2>/dev/null >&3 || exec 3>/dev/null

## fnc
logger() { command logger $@ 2>&3 ;}

## env
export OPENSSLARGS="enc -d -aes-256-cbc"

path=${1?req! path/to/enc/pass} ;shift
recipient=${1:-}
gpgargs="-r $recipient"

## main
logger -sp DEBUG -- "Enter" \
  :: "openssl-arguments=$OPENSSLARGS" \
     "path=$path" \
     "recipient=$recipient"

if [ -z "$recipient" ] ;then
	logger -sp DEBUG -- "Set recipient is default self" \
		:: "path=$path" \
       "recipient=$recipient"
  gpgargs="--default-recipient-self"
fi

{ <"$path" base64 -d &>/dev/null \
  && <"$path" base64 -d \
  || <"$path" cat

} | openssl $OPENSSLARGS 2>&3 \
  | { : \
  		| gpg -ae $gpgargs \
  		| gpg -d --passphrase-fd 100

  	} 100<&0
