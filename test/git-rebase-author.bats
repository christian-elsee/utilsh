#!/usr/bin/env bats

@test "can rebase a commit log's author" {
  logger -sp DEBUG -- "Test" \
    :: "repository=$repo" \
    :: "can rebase a commit log's author"

  ( cd $repo
    git-rebase-author.sh root foobar foo@bar.com
    git log -1 --format="%an" | grep -- foobar
  )
}

setup_file() {
  logger -sp DEBUG -- "Setup"
  export repo=$( mktemp -ud )

  git config --global user.name  "me"
  git config --global user.email "me@example.com"
  git config --global init.defaultBranch master

  git init $repo
  cd $repo
  touch foo bar
  git add .
  git commit -am "foo and bar"
}

teardown_file() {
  logger -sp DEBUG -- "Teardown" "repository=$repo"
  rm -rvf $repo
}
