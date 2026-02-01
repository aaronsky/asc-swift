"""
Declares non-BCR deps used by asc-swift
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _asc_swift_dev_deps_impl(_mctx):
    http_archive(
        name = "com_apple_app_store_connect_api",
        build_file = "@asc_swift//bazel/specs:com_apple_app_store_connect_api/BUILD.overlay",
        sha256 = "59fc0d42ea10d8b105da3a66fcabadb7a6cfcc41ba150a1f4b05f91b74e3131c",
        urls = ["https://developer.apple.com/sample-code/app-store-connect/app-store-connect-openapi-specification.zip"],
    )
    http_archive(
        name = "com_apple_enterprise_program_api",
        build_file = "@asc_swift//bazel/specs:com_apple_enterprise_program_api/BUILD.overlay",
        sha256 = "d8ee548acbf5258edd5456d057fbb0dacaa6201de2dd3a362bf36388c3b27e9d",
        urls = ["https://developer.apple.com/sample-code/enterprise/enterprise-program-openapi-oas.zip"],
    )
    http_archive(
        name = "com_github_aaronsky_createapi",
        build_file = "@asc_swift//bazel/third_party:com_github_aaronsky_createapi/BUILD.overlay",
        sha256 = "69ae5a4822e5950dafd92ff5c07cf681adbfb1e0141ee751065289c7ed2f837d",
        strip_prefix = "CreateAPI-0.2.0-alpha.4",
        url = "https://github.com/aaronsky/CreateAPI/archive/refs/tags/0.2.0-alpha.4.zip",
    )
    http_archive(
        name = "com_github_liamnichols_swift_configuration_parser",
        build_file = "@asc_swift//bazel/third_party:com_github_liamnichols_swift_configuration_parser/BUILD.overlay",
        sha256 = "7788ca2817419ac20dfde96ff1dae16b2b5688b9ca9ed4f20c5a54d98cad0a9a",
        strip_prefix = "swift-configuration-parser-0.0.4",
        url = "https://github.com/liamnichols/swift-configuration-parser/archive/refs/tags/0.0.4.zip",
    )
    http_archive(
        name = "com_github_createapi_openapikit",
        build_file = "@asc_swift//bazel/third_party:com_github_createapi_openapikit/BUILD.overlay",
        sha256 = "89073cd99b2381c8f48d1e01aafc4393f25f94158f858c8fc81f8a602dc1dd3d",
        strip_prefix = "OpenAPIKit-6eb4baa0abbece9746f6f01837381e5c9999b373",
        url = "https://github.com/CreateAPI/OpenAPIKit/archive/6eb4baa0abbece9746f6f01837381e5c9999b373.zip",
    )
    http_archive(
        name = "com_github_createapi_yams",
        build_file = "@asc_swift//bazel/third_party:com_github_createapi_yams/BUILD.overlay",
        sha256 = "b4f5fe30bee90c127fe7a8af5a6531e4bd93f1e46bf25c9909a1088b74c61563",
        strip_prefix = "Yams-d2ebc53afeb2001474dacf81c4480fef114045a1",
        url = "https://github.com/CreateAPI/Yams/archive/d2ebc53afeb2001474dacf81c4480fef114045a1.zip",
    )
    http_archive(
        name = "com_github_cosmo_grammaticalnumber",
        build_file = "@asc_swift//bazel/third_party:com_github_cosmo_grammaticalnumber/BUILD.overlay",
        sha256 = "308ff4905fce376b6bc1fbf435414ee9b75a687c6df3da55cf3820c7db033df7",
        strip_prefix = "GrammaticalNumber-0.0.3",
        url = "https://github.com/cosmo/GrammaticalNumber/archive/refs/tags/0.0.3.zip",
    )
    http_archive(
        name = "com_github_eonist_filewatcher",
        build_file = "@asc_swift//bazel/third_party:com_github_eonist_filewatcher/BUILD.overlay",
        sha256 = "f5ae5db783ffc25dbdf227b857ad125ea7e713662d631493194437879ffb83be",
        strip_prefix = "FileWatcher-0.2.3",
        url = "https://github.com/eonist/FileWatcher/archive/refs/tags/0.2.3.zip",
    )

asc_swift_dev_deps = module_extension(implementation = _asc_swift_dev_deps_impl)
