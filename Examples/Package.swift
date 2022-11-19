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
        .executable(name: "simple", targets: ["simple"])
    ],
    dependencies: [
        .package(name: "AppStoreConnect", path: "../")
    ],
    targets: [
        .executableTarget(
            name: "simple",
            dependencies: [
                "ExamplesCore",
                .product(name: "AppStoreConnect", package: "AppStoreConnect"),
            ],
            path: "simple"
        ),
        .target(
            name: "ExamplesCore",
            dependencies: [
                .product(name: "AppStoreConnect", package: "AppStoreConnect")
            ],
            path: "ExamplesCore"
        ),
    ]
)
