// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Examples",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        .executable(name: "invite_beta_tester", targets: ["invite_beta_tester"]),
        .executable(name: "invite_user", targets: ["invite_user"]),
        .executable(name: "list_builds", targets: ["list_builds"]),
        .executable(name: "register_device", targets: ["register_device"]),
        .executable(name: "sales_finance_reports", targets: ["sales_finance_reports"]),
        .executable(name: "upload_preview", targets: ["upload_preview"]),
        .executable(name: "upload_screenshot", targets: ["upload_screenshot"]),
    ],
    dependencies: [
        .package(name: "AppStoreConnect", path: "../"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.3.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", .upToNextMajor(from: "3.2.0")),
    ],
    targets: [
        .executableTarget(
            name: "invite_beta_tester",
            dependencies: [
                "Utilities",
                .product(name: "AppStoreConnect", package: "AppStoreConnect"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "invite_beta_tester"
        ),
        .executableTarget(
            name: "invite_user",
            dependencies: [
                "Utilities",
                .product(name: "AppStoreConnect", package: "AppStoreConnect"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "invite_user"
        ),
        .executableTarget(
            name: "list_builds",
            dependencies: [
                "Utilities",
                .product(name: "AppStoreConnect", package: "AppStoreConnect"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "list_builds"
        ),
        .executableTarget(
            name: "register_device",
            dependencies: [
                "Utilities",
                .product(name: "AppStoreConnect", package: "AppStoreConnect"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "register_device"
        ),
        .executableTarget(
            name: "sales_finance_reports",
            dependencies: [
                "Utilities",
                .product(name: "AppStoreConnect", package: "AppStoreConnect"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "sales_finance_reports"
        ),
        .executableTarget(
            name: "upload_preview",
            dependencies: [
                "Utilities",
                .product(name: "AppStoreConnect", package: "AppStoreConnect"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Crypto", package: "swift-crypto"),
            ],
            path: "upload_preview"
        ),
        .executableTarget(
            name: "upload_screenshot",
            dependencies: [
                "Utilities",
                .product(name: "AppStoreConnect", package: "AppStoreConnect"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Crypto", package: "swift-crypto"),
            ],
            path: "upload_screenshot"
        ),
        .target(
            name: "Utilities",
            dependencies: [
                .product(name: "AppStoreConnect", package: "AppStoreConnect")
            ],
            path: "Utilities"
        ),
    ]
)
