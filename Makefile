export NAME := $(shell basename "$$PWD" )
export SHA  := $(shell git rev-parse --short HEAD)
export TS   := $(shell date +%s)
export PREFIX ?= $(HOME)/bin/utilsh

.DEFAULT_GOAL := @goal
.ONESHELL:
.POSIX:

## workflow
@goal: distclean dist build check

dist: ;: ## dist
	mkdir -p $@

build: dist
	docker build \
		-t local/$(NAME):latest \
		.

check: ;: ## check
	# requires dind to test script thats
	docker create \
		--name check.$(NAME) \
		--rm \
		local/$(NAME):latest
	docker cp test check.$(NAME):/opt/main
	docker cp src check.$(NAME):/opt/main
	docker start -ai check.$(NAME)

install: 
	: ## $@
	rsync -av \
				--mkpath \
				--delete \
				-- src/ $(PREFIX)
	ls -1 src \
		| xargs -I% -- \
			cp src/% $(PREFIX)/$(NAME)-%

distclean: ;: ## distclean
	rm -rvf dist
clean: distclean ;: ## clean
	rm -rvf assets

