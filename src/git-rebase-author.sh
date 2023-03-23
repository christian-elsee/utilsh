#!/bin/sh
set -eu

## lib
. "$( dirname $0 )/common.sh"

## arg

while getopts h-: OPT; do
  # support long options: https://stackoverflow.com/a/28466267/519360
  if [ "$OPT" = "-" ]; then   # long option: reformulate OPT and OPTARG
    OPT="${OPTARG%%=*}"       # extract long option name
    OPTARG="${OPTARG#$OPT}"   # extract long option argument (may be empty)
    OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
  fi
  case "$OPT" in
    h | help )
      echo "usage:$( basename $0 ) <sha> <author> <name>" >&2
      exit 0
    ;;

    ??* ) # bad long option
      echo "Illegal option --$OPT"
      exit 2
    ;;

    ? ) exit 2 ;;  # bad short option (error reported via getopts)
  esac
done
shift $((OPTIND-1)) # remove parsed options and args from $@ list

: ${1?sha}
: ${2?name}
: ${3?email}

## main
logger -sp DEBUG -- "Enter" \
  :: "sha=$1"   \
     "name=$2"  \
     "email=$3"

set -x
git rebase \
  -i "$1" \
  -x "git commit --no-edit --amend --author '$2 <$3>'"
