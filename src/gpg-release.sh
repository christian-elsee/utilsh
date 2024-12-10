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
gpgargs=${@:---default-recipient-self}

## main
logger -sp DEBUG -- "Enter" \
  :: "openssl-arguments=$OPENSSLARGS" \
     "path=$path" \
     "gpgargs=$gpgargs"

if [ $# -eq 1 ] ;then
	logger -sp DEBUG -- "Prepend recipient flag to key id" \
		:: "path=$path" \
     	 "keyid=$1"
  gpgargs="-r $1"
fi

{ <"$path" base64 -d &>/dev/null \
  && <"$path" base64 -d \
  || <"$path" cat

} | openssl $OPENSSLARGS 2>&3 \
  | { : \
  		| gpg -ae "$gpgargs" \
  		| gpg -d --passphrase-fd 100

  	} 100<&0
