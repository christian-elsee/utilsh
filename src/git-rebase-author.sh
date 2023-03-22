#!/bin/sh
set -eu

## env
export GIT_MERGE_AUTOEDIT=no

: ${1?sha}
: ${2?name}
: ${3?email}

## main
logger -sp DEBUG -- "Enter" \
  :: "sha=$1"   \
     "name=$2"  \
     "email=$3" \

set -x
git rebase \
  -i "$1" \
  -x "git commit --no-edit --amend --author '$2 <$3>'"
