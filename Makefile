# Facts
GIT_REPO_TOPLEVEL := $(shell git rev-parse --show-toplevel)

# Formatting
SWIFT_FORMAT_BIN := swift format
SWIFT_FORMAT_CONFIG_FILE := $(GIT_REPO_TOPLEVEL)/.swift-format
FORMAT_PATHS := \
	$(GIT_REPO_TOPLEVEL)/Package.swift \
	$(GIT_REPO_TOPLEVEL)/Examples \
	$(GIT_REPO_TOPLEVEL)/Sources \
	$(GIT_REPO_TOPLEVEL)/Tests

.PHONY: format
format:
	$(SWIFT_FORMAT_BIN) \
		--configuration $(SWIFT_FORMAT_CONFIG_FILE) \
		--ignore-unparsable-files \
		--in-place \
		--parallel \
		--recursive \
		$(FORMAT_PATHS)

.PHONY: lint
lint:
	$(SWIFT_FORMAT_BIN) lint \
		--configuration $(SWIFT_FORMAT_CONFIG_FILE) \
		--ignore-unparsable-files \
		--parallel \
		--recursive \
		$(FORMAT_PATHS)
