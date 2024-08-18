// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AppStoreConnect",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
    ],
    products: [
        .library(
            name: "AppStoreConnect",
            targets: ["AppStoreConnect", "AppStoreAPI"]),
        .library(
            name: "EnterpriseProgram",
            targets: ["AppStoreConnect", "EnterpriseAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.3.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", .upToNextMajor(from: "3.2.0")),
        .package(url: "https://github.com/CreateAPI/URLQueryEncoder.git", .upToNextMajor(from: "0.2.1")),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0"),
    ],
    targets: [
        .target(
            name: "AppStoreConnect",
            dependencies: [
                .product(name: "Crypto", package: "swift-crypto")
            ],
            exclude: ["BUILD.bazel"]),
        .target(
            name: "AppStoreAPI",
            dependencies: [
                "AppStoreConnect",
                .product(name: "URLQueryEncoder", package: "URLQueryEncoder"),
            ],
            exclude: ["BUILD.bazel"]),
        .target(
            name: "EnterpriseAPI",
            dependencies: [
                "AppStoreConnect",
                .product(name: "URLQueryEncoder", package: "URLQueryEncoder"),
            ],
            exclude: ["BUILD.bazel"]),

        // Examples
        .executableTarget(
            name: "invite_beta_tester",
            dependencies: [
                "AppStoreAPI",
                "AppStoreConnect",
                "Utilities",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "Examples/invite_beta_tester",
            exclude: ["BUILD.bazel"]),
        .executableTarget(
            name: "invite_user",
            dependencies: [
                "AppStoreAPI",
                "AppStoreConnect",
                "EnterpriseAPI",
                "Utilities",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "Examples/invite_user",
            exclude: ["BUILD.bazel"]),
        .executableTarget(
            name: "list_builds",
            dependencies: [
                "AppStoreAPI",
                "AppStoreConnect",
                "Utilities",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "Examples/list_builds",
            exclude: ["BUILD.bazel"]),
        .executableTarget(
            name: "register_device",
            dependencies: [
                "AppStoreAPI",
                "AppStoreConnect",
                "Utilities",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "Examples/register_device",
            exclude: ["BUILD.bazel"]),
        .executableTarget(
            name: "sales_finance_reports",
            dependencies: [
                "AppStoreAPI",
                "AppStoreConnect",
                "Utilities",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "Examples/sales_finance_reports",
            exclude: ["BUILD.bazel"]),
        .executableTarget(
            name: "upload_preview",
            dependencies: [
                "AppStoreAPI",
                "AppStoreConnect",
                "Utilities",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Crypto", package: "swift-crypto"),
            ],
            path: "Examples/upload_preview",
            exclude: ["BUILD.bazel"]),
        .executableTarget(
            name: "upload_screenshot",
            dependencies: [
                "AppStoreAPI",
                "AppStoreConnect",
                "Utilities",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Crypto", package: "swift-crypto"),
            ],
            path: "Examples/upload_screenshot",
            exclude: ["BUILD.bazel"]),
        .target(
            name: "Utilities",
            dependencies: ["AppStoreConnect"],
            path: "Examples/Utilities",
            exclude: ["BUILD.bazel"]),

        // Tests
        .target(
            name: "Mocks",
            dependencies: ["AppStoreConnect"],
            path: "Tests/Mocks",
            exclude: ["BUILD.bazel"]),
        .testTarget(
            name: "AppStoreConnectTests",
            dependencies: ["AppStoreConnect", "Mocks"],
            exclude: ["BUILD.bazel"]),
        .testTarget(
            name: "AppStoreAPITests",
            dependencies: ["AppStoreAPI", "AppStoreConnect", "Mocks"],
            exclude: ["BUILD.bazel"]),
    ]
)
