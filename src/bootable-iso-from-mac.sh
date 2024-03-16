#!/bin/bash
## Create bootable usb from iso using macos disk tools
set -euo pipefail

## fnc
cleanup() { local status=$1 iso=$2 disk=$3
  logger -sp DEBUG -- "Cleanup" \
    :: "status=$status" \
       "iso=$iso" \
       "disk=$3"
}
trap 'cleanup "$?" "$1" "$2"' INT TERM


## env
: ${1?iso}
: ${2?disk}

## main
logger -sp DEBUG -- "Enter" "iso=$1" "disk=$2"

hdiutil convert \
  -format UDRW \
  -o "$1.dmg" \
  -- "$1"

diskutil unmountDisk "$2"
dd if="$1.dmg" of="$2" bs=1m
