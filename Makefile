# Facts
GIT_REPO_TOPLEVEL := $(shell git rev-parse --show-toplevel)
OPENAPI_SPEC_URL := https://developer.apple.com/sample-code/app-store-connect/app-store-connect-openapi-specification.zip
OPENAPI_SPEC_OUTDIR := $(GIT_REPO_TOPLEVEL)/Sources/_Specification
OPENAPI_SPEC_OUTFILE := $(OPENAPI_SPEC_OUTDIR)/app_store_connect_api_2.1_openapi.json

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

.PHONY: default
default: test-all

.PHONY: spec
spec: spec-download spec-generate

.PHONY: spec-download
spec-download:
	curl --fail --silent --show-error --location --output - $(OPENAPI_SPEC_URL) \
		| tar --extract --to-stdout --file - \
		| jq '\
			.components.schemas.BundleIdPlatform.enum |= [ "IOS", "MAC_OS", "UNIVERSAL" ] \
			| del(.["x-important"]) \
			| del(.. |."enum"? | select(. != null and length == 0))\
			' \
		> $(OPENAPI_SPEC_OUTFILE)

.PHONY: spec-generate
spec-generate:
	swift package --allow-writing-to-package-directory generate-openapi $(OPENAPI_SPEC_OUTFILE)

.PHONY: test-all
test-all: test-library test-library-xcode test-examples

.PHONY: test-library
test-library:
	swift test --parallel

.PHONY: test-library-xcode
test-library-xcode: test-library-xcode-ios test-library-xcode-macos test-library-xcode-tvos test-library-xcode-watchos

.PHONY: test-library-xcode-ios
test-library-xcode-ios:
	xcodebuild test \
		-scheme AppStoreConnect \
		-destination "$(DESTINATION_PLATFORM_IOS_SIMULATOR)" \
		-quiet

.PHONY: test-library-xcode-macos
test-library-xcode-macos:
	xcodebuild test \
		-scheme AppStoreConnect \
		-destination "$(DESTINATION_PLATFORM_MACOS)" \
		-quiet

.PHONY: test-library-xcode-tvos
test-library-xcode-tvos:
	xcodebuild test \
		-scheme AppStoreConnect \
		-destination "$(DESTINATION_PLATFORM_TVOS_SIMULATOR)" \
		-quiet

.PHONY: test-library-xcode-watchos
test-library-xcode-watchos:
	xcodebuild \
		-scheme AppStoreConnect \
		-destination "$(DESTINATION_PLATFORM_WATCHOS_SIMULATOR)" \
		-quiet

.PHONY: build-examples
build-examples: build-examples-all

.PHONY: build-examples-all
build-examples-all:
	swift build --package-path Examples

.PHONY: build-examples-invite-beta-tester
build-examples-invite-beta-tester:
	swift build --package-path Examples --product invite_beta_tester

.PHONY: build-examples-invite-user
build-examples-invite-user:
	swift build --package-path Examples --product invite_user

.PHONY: build-examples-list-builds
build-examples-list-builds:
	swift build --package-path Examples --product list_builds

.PHONY: build-examples-register-device
build-examples-register-device:
	swift build --package-path Examples --product register_device

.PHONY: build-examples-sales-finance-reports
build-examples-sales-finance-reports:
	swift build --package-path Examples --product sales_finance_reports

.PHONY: build-examples-upload-preview
build-examples-upload-preview:
	swift build --package-path Examples --product upload_preview

.PHONY: build-examples-upload-screenshot
build-examples-upload-screenshot:
	swift build --package-path Examples --product upload_screenshot

.PHONY: format
format:
	$(SWIFT_FORMAT_BIN) \
		--configuration $(SWIFT_FORMAT_CONFIG_FILE) \
		--ignore-unparsable-files \
		--in-place \
		--recursive \
		$(FORMAT_PATHS)

.PHONY: lint
lint:
	$(SWIFT_FORMAT_BIN) lint \
		--configuration $(SWIFT_FORMAT_CONFIG_FILE) \
		--ignore-unparsable-files \
		--recursive \
		$(FORMAT_PATHS)
