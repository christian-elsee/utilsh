export NAME := $(shell basename "$$PWD" )
export SHA  := $(shell git rev-parse --short HEAD)
export TS   := $(shell date +%s)

.DEFAULT_GOAL := @goal
.ONESHELL:
.POSIX:

## workflow
@goal: dist build check

dist: assets/bats-assert assets/bats-core assets/bats-support ;: ## dist
	mkdir -p $@

build: dist
	docker build \
		-t local/$(NAME):latest \
		.

check: build ;: ## check
	# requires dind to test script thats
	docker create \
		--name check.$(NAME) \
		--rm \
		local/$(NAME):latest
	docker cp test check.$(NAME):/opt/main
	docker cp src check.$(NAME):/opt/main
	docker start -ai check.$(NAME)

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
			&& git push --force origin $(branch)    \
		"
