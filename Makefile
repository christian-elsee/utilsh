export NAME := $(shell basename "$$PWD" )
export SHA  := $(shell git rev-parse --short HEAD)
export TS   := $(shell date +%s)
export PREFIX ?= $(HOME)/bin/utilsh

.DEFAULT_GOAL := @goal
.ONESHELL:
.POSIX:

## workflow
@goal: check

check:
	: ## $@

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

