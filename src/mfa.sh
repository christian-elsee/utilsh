#!/bin/bash
set -eu

pbpaste | ssh laptop "cat >/tmp/mfa"
