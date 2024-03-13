#!/bin/sh
## Calculates a consistent md5sum hash from given variadic
## path arguments, ignoring argument order, sort order and
## file meta attributes
#$ ./checksum.sh path/to/dir [path/to/file] [fu/bar.txt]
set -euo pipefail
2>/dev/null >&3 || exec 3>/dev/null

## env
: ${@?paths}

## main
logger -sp DEBUG -- "Enter" \
  :: "$(echo $@ | base64 | tr -d \\n )" \
2>&3

find $@ -type f \
        -exec md5sum {} + \
| sort -k 2 \
| md5sum \
| cut -f1 -d" "
