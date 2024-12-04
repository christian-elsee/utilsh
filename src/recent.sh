#!/bin/bash
## Writes a given $number of files at a given directory $path, sorted by
## descending order, to STDOUT
#$ ./recent.sh path/to/directory [$number]
#$ ./recent.sh $HOME/Downloads 33
set -euo pipefail
2>/dev/null >&3 || exec 3>/dev/null

## fnc
logger() { command logger $@ 2>&3 ;}

## env
path=${1?!req path/to/directory}
n=${2:-10}

## main
logger -sp DEBUG -- "Enter" \
  :: "path=$path" \
     "number=$n"

ls -tl \
  --time-style=+"%Y-%m-%d@%H:%M:%S" \
| head -n"$n"
