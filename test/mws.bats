#!/usr/bin/env bats

@test "can send an http request" {
  logger -sp DEBUG -- "Test" \
    :: "pid=$pid" \
    :: "can send an http request"

  curl localhost:8080
}

@test "can receive an http response" {
  logger -sp DEBUG -- "Test" \
    :: "can receive an http response"

  curl --fail localhost:8080
}

setup_file() {
  logger -sp DEBUG -- "Setup"

  mws.sh 8080 &
}

teardown_file() {
  logger -sp DEBUG -- "Teardown"
  pkill -9 -f socat
}
