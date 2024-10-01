SHELL=/bin/bash -O extglob -c

.PHONY: fmt
fmt:
	@stylua **/*.lua

.PHONY: lint
lint:
	@luacheck **/*.lua
