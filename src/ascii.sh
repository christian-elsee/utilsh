#!/bin/bash
set -eu
set -o pipefail ||:

## main
logger -sp DEBUG -- "Enter"

iconv -f utf-8 \
			-t ascii//TRANSLIT
