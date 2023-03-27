#!/bin/sh
set -eu

## lib
. "$( dirname $0 )/common.sh"

## arg
usage "<argv>" \
      "Run argv on posix-strict shell" \
      "$@"

: ${ENV:=/dev/null}
: ${TAG:=latest}

argv=$@

## main
logger -sp DEBUG -- "Enter" \
  :: "$*"

# disable stderr if we don't want shellcheck spamming terminal
echo "$*" \
  | shellcheck --shell=dash /dev/stdin 1>&2