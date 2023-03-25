#!/usr/bin/env bats

@test "can run a posix compliant command" {
  logger -sp DEBUG -- "Test" \
    :: "can run a posix compliant command"

  posix.sh true
}

@test "fails to run a non posix-compliant command" {
  logger -sp DEBUG -- "Test" \
    :: "fails to run a non posix-compliant command"

  ! ( posix.sh read -i"default" var )
}
