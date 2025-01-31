#!/bin/bash
## Forwards a given mfa seed a totp token generator
## which writes to /dev/fd/10:pasteboard by default
## $
set -euo pipefail

## fd
[ -e /dev/fd/10 ] || exec 10> >(pbcopy)

## env
: ${1?req! mfa seed}

## main
logger -sp DEBUG -- "Enter" \
	:: "seed=$( echo "$1" | cut -c 1-5 )"

echo "$1" \
	| totp-cli instant \
	| tee /dev/fd/10
