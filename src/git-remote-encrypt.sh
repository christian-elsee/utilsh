#!/bin/bash
set -euo pipefail

## fnc
repo() { printf "%s\0" "$*" | xargs -0 -I% basename % .git ;}
fingerprint () {
  gpg --fingerprint "$( repo $@ )" \
    | sed -n "2p" \
    | tr -d " "
}

## env
: ${1?name}
: ${2?uri}
branch=${3:-main}

## main
logger -sp DEBUG -- "Enter" \
  "name=$1" \
  "remote=$2" \
  "branch=$branch"

cat <<eof
git remote remove "$1" ||:
git remote add "$1" "gcrypt::$2#$branch"
git config "remote.$1.gcrypt-participants" "$( fingerprint $2 )"
git config "remote.$1.gcrypt-signingkey" "$( fingerprint $2 )"
git ls-remote "$1"
