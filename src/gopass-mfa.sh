#!/bin/bash
## Determines mfa seed from a given gopass path to calculate
## an otp
## $ gopass-mfa.sh path/to/entry
set -euo pipefail

## fd
[ -e /dev/fd/10 ] || exec 10> >(pbcopy)

## env
: ${1?req! path}

## main
logger -sp DEBUG -- "Enter" \
	:: "path=$( echo "$1" | cut -c 1-5 )"

gopass "$1" \
	| jq -re .mfa \
	| totp-cli instant \
	| tr -d \\n \
	| tee /dev/fd/10 \
	| xargs
