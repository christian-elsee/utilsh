#!/bin/sh
set -eu

## lib
. "$( dirname $0 )/common.sh"

## arg
usage "<sha> <author> <email>" \
      "Rebase commit logs to update contact" \
      "$@"

: ${1?sha}
: ${2?name}
: ${3?email}

## main
logger -sp DEBUG -- "Enter" \
  :: "sha=$1"   \
     "name=$2"  \
     "email=$3"

if [ "$1" = "root" ]; then
  set -- "--root" "$2" "$3"
else
  set -- "-i $1" "$2" "$3"
fi
logger -sp DEBUG -- "Reset positional arguments" \
  :: "$*"

set -x
git rebase --autosquash \
  "$1" \
  -x "git commit --no-edit --amend --author '$2 <$3>'"
