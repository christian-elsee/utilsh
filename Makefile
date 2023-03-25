export NAME := $(shell basename "$$PWD" )
export SHA  := $(shell git rev-parse --short HEAD)
export TS   := $(shell date +%s)

.DEFAULT_GOAL := @goal
.ONESHELL:
.POSIX:

## workflow
@goal: dist

dist: assets/bats-assert assets/bats-core assets/bats-support ;: ## dist
	mkdir -p $@/test/test_helper

	cp -rf assets/bats-core "$@/test/bats"
	cp -rf assets/bats-support "$@/test/test_helper/bats-support"
	cp -rf assets/bats-assert "$@/test/test_helper/bats-assert"

assets/bats-assert assets/bats-core assets/bats-support: ;: ## assets/$@
	dirname $@ | xargs -- mkdir -p
	basename $@ \
		| xargs -I% -- \
			git clone https://github.com/bats-core/%.git assets/%

check: export PATH := $(PWD)/src:$(PATH)
check: export TMPDIR := /tmp/check
check: ;: ## check
	cp -rf test dist
	dist/test/bats/bin/bats dist/test/*.bats \
		--tap

distclean: ;: ## distclean
	rm -rvf dist
clean: distclean ;: ## clean
	rm -rvf assets

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
