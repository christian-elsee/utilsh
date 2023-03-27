#!/usr/bin/env bats

@test "can foobar" {
  foobar.sh | grep foobar
}

@test "can not barfoo" {
  ! ( foobar.sh | grep barfoo )
}
