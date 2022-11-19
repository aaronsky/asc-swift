# Facts
GIT_REPO_TOPLEVEL := $(shell git rev-parse --show-toplevel)
OPENAPI_SPEC_URL := https://developer.apple.com/sample-code/app-store-connect/app-store-connect-openapi-specification.zip
OPENAPI_SPEC_OUTDIR := $(GIT_REPO_TOPLEVEL)/Sources/AppStoreConnect
OPENAPI_SPEC_OUTFILE := app_store_connect_api_2.1_openapi.json

# Apple Platform Destinations
DESTINATION_PLATFORM_IOS_SIMULATOR = platform=iOS Simulator,name=iPhone 13 Pro Max
DESTINATION_PLATFORM_MACOS = platform=macOS
DESTINATION_PLATFORM_TVOS_SIMULATOR = platform=tvOS Simulator,name=Apple TV
DESTINATION_PLATFORM_WATCHOS_SIMULATOR = platform=watchOS Simulator,name=Apple Watch Series 5 (44mm)

# Formatting
SWIFT_FORMAT_BIN := swift format
SWIFT_FORMAT_CONFIG_FILE := $(GIT_REPO_TOPLEVEL)/.swift-format.json
FORMAT_PATHS := $(GIT_REPO_TOPLEVEL)/Examples $(GIT_REPO_TOPLEVEL)/Package.swift $(GIT_REPO_TOPLEVEL)/Sources $(GIT_REPO_TOPLEVEL)/Tests

# Tasks

default: test-all

spec: spec-download spec-generate

spec-download:
	curl --fail --silent --show-error --location --output - $(OPENAPI_SPEC_URL) \
		| tar --extract --directory $(OPENAPI_SPEC_OUTDIR) --file -

spec-generate:
	swift package --allow-writing-to-package-directory generate-openapi

test-all: test-library test-library-xcode test-examples

test-library:
	swift test --parallel

test-library-xcode:
	xcodebuild test \
		-scheme AppStoreConnect \
		-destination "$(DESTINATION_PLATFORM_IOS_SIMULATOR)" \
		-quiet
	xcodebuild test \
		-scheme AppStoreConnect \
		-destination "$(DESTINATION_PLATFORM_MACOS)" \
		-quiet
	xcodebuild test \
		-scheme AppStoreConnect \
		-destination "$(DESTINATION_PLATFORM_TVOS_SIMULATOR)" \
		-quiet
	xcodebuild \
		-scheme AppStoreConnect \
		-destination "$(DESTINATION_PLATFORM_WATCHOS_SIMULATOR)" \
		-quiet

DOC_WARNINGS := $(shell xcodebuild clean docbuild \
	-scheme AppStoreConnect \
	-destination "$(DESTINATION_PLATFORM_MACOS)" \
	-quiet \
	2>&1 \
	| grep "couldn't be resolved to known documentation" \
	| sed 's|$(PWD)|.|g' \
	| tr '\n' '\1')
test-docs:
	@test "$(DOC_WARNINGS)" = "" \
		|| (echo "xcodebuild docbuild failed:\n\n$(DOC_WARNINGS)" | tr '\1' '\n' \
		&& exit 1)

format:
	$(SWIFT_FORMAT_BIN) \
		--configuration $(SWIFT_FORMAT_CONFIG_FILE) \
		--ignore-unparsable-files \
		--in-place \
		--recursive \
		$(FORMAT_PATHS)

lint:
	$(SWIFT_FORMAT_BIN) lint \
		--configuration $(SWIFT_FORMAT_CONFIG_FILE) \
		--ignore-unparsable-files \
		--recursive \
		$(FORMAT_PATHS)

.PHONY: spec spec-download spec-generate format lint test-all test-library test-library-xcode test-docs
