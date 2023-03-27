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

docker run \
	-it \
	--rm \
	--env-file "$ENV" \
	-- "alpine:$TAG" sh -xc \
	'cat /etc/os-release; $@' _ "$@"
