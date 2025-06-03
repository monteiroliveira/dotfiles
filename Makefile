ifeq (, $(shell which stow 2> /dev/null))
$(error "Stow is not installed")
endif

DIR=$(shell pwd)/
TARGET=$(HOME)/

.PHONY: build build-adopt purge

all: build

build:
	@echo "Build symlinks"
	@echo "TAGET=$(TARGET) DIR=$(DIR)"
	stow --dir=$(DIR) --target=$(TARGET) --verbose .

build-adopt:
	@echo "Build symlinks"
	@echo "TAGET=$(TARGET) DIR=$(DIR)"
	stow --dir=$(DIR) --target=$(TARGET) --verbose --adopt .

purge:
	@echo "Purge symslinks"
	stow --dir=$(DIR) --target=$(TARGET) --delete --verbose .
