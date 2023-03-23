#!/bin/sh
set -eu

## func

die() { local status=$1; shift; echo "$*" >&2; exit $status; }  # complain to STDERR and exit with error
needs_arg() { if [ -z "$OPTARG" ]; then die "$( basename $0 ):option requires an argument -- --$OPT"; fi; }
