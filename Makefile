export NAME := $(shell basename "$$PWD" )
export SHA  := $(shell git rev-parse --short HEAD)
export TS   := $(shell date +%s)

.DEFAULT_GOAL := @goal
.ONESHELL:
.POSIX:

## workflow
@goal: dist

dist: ;: ## dist
	mkdir -p $@/test/test_helper

	git clone https://github.com/bats-core/bats-core.git "$@/test/bats"
	git clone https://github.com/bats-core/bats-support.git "$@/test/test_helper/bats-support"
	git clone https://github.com/bats-core/bats-assert.git "$@/test/test_helper/bats-assert"

check:
	cp -rf test dist
	dist/test/bats/bin/bats --tap dist/test

distclean: ;: ## distclean
	rm -rvf dist
clean: distclean ;: ## clean

## ad hoc
push: branch := $(shell git branch --show-current)
push:
	test "$(branch)"

	# ensure working tree is clean for push
	git status --porcelain \
		| xargs \
		| grep -qv .

	ssh-agent bash -c \
		"<secrets/key.gpg gpg -d | ssh-add - \
			&& git push origin $(branch) -f    \
		"
