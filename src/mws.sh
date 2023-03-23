#!/bin/sh
set -eu

## lib
. "$( dirname $0 )/common.sh"

## arg
usage "<port>" \
      "A minimal HTTP server" \
      "$@"

## env
: ${1?port}

## main
logger -sp DEBUG -- "Enter" \
  :: "port=$1"

socat -v -d -d \
  "tcp-listen:$1,crlf,reuseaddr,fork" \
  system:"
    echo HTTP/1.0 200 OK;
    echo;
  "
