#!/bin/sh
set -eu

## func

die() { local status=$1; shift; echo "$*" >&2; exit $status; }  # complain to STDERR and exit with error
needs_arg() { if [ -z "$OPTARG" ]; then die "$( basename $0 ):option requires an argument -- --$OPT"; fi; }

usage() { local args=$1 desc=$2 ;shift 2
  # if no argument have been passed to caller, we
  # default to -h case
  if [ "$#" -eq 0 ] ;then
    set -- -h
  fi

  while getopts h-: OPT; do
    if [ "$OPT" = "-" ]; then   # long option: reformulate OPT and OPTARG
      OPT="${OPTARG%%=*}"       # extract long option name
      OPTARG="${OPTARG#$OPT}"   # extract long option argument (may be empty)
      OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
    fi
    case "$OPT" in
      h | help )
        printf "usage: %s %s\n\n%s\n" \
          "$( basename $0 )" \
          "$args" \
          "$desc" \
        >&2
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
}