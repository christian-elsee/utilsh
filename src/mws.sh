#!/bin/sh
set -eu

## lib
. "$( dirname $0 )/common.sh"

## arg
usage "[port=8080]" \
      "A minimal HTTP server" \
      "$@"

## env
port=${1:-8080}

## main
logger -sp DEBUG -- "Enter" \
  :: "port=$port"

socat -v -d -d \
  "tcp-listen:$port,crlf,reuseaddr,fork" \
  system:"
    echo HTTP/1.1 302 OK;
    echo Location\: \"https://msn.com\";
    echo;
  "
