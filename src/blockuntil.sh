#!/bin/sh
# Block until expression is true and uses "watch" as polling engine
set -eu

## env
expression=${@?reqarg:expression}

## main
# run command in background and block with foreground
# wait, which is interruptable
( watch -te  -- "! $@" >&- & wait )
