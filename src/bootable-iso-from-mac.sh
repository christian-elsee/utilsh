#!/bin/bash
## Create bootable usb from iso using macos disk tools
set -euo pipefail

## fnc
cleanup() { local status=$1 iso=$2 disk=$3
  logger -sp DEBUG -- "Cleanup" \
    :: "status=$status" \
       "iso=$iso" \
       "disk=$disk"

  rm -rf "$iso.dmg"
}
trap 'cleanup "$?" $@' INT TERM


## env
: ${1?iso}
: ${2?disk}

## main
logger -sp DEBUG -- "Enter" "iso=$1" "disk=$2"

diskutil unmountDisk "$2"

rm -rf "$1.dmg"
hdiutil convert "$1" \
  -format UDRW \
  -o "$1.dmg"

dd if="$1.dmg" of="$2" bs=1M
