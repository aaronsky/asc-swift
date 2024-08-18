// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "AppStoreConnect",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        .library(
            name: "AppStoreConnect",
            targets: ["AppStoreConnect", "AppStoreAPI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-crypto.git", .upToNextMajor(from: "3.2.0")),
        .package(url: "https://github.com/CreateAPI/URLQueryEncoder.git", .upToNextMajor(from: "0.2.1")),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0"),
    ],
    targets: [
        .target(
            name: "AppStoreConnect",
            dependencies: [
                .product(name: "Crypto", package: "swift-crypto")
            ]
        ),
        .target(
            name: "AppStoreAPI",
            dependencies: [
                "AppStoreConnect",
                .product(name: "URLQueryEncoder", package: "URLQueryEncoder"),
            ],
            exclude: [
                "app_store_connect_api_3.5_openapi.json",
                "patches.awk",
                "patches.jq",
            ]
        ),
        .testTarget(
            name: "AppStoreConnectTests",
            dependencies: ["AppStoreConnect"]
        ),
        .binaryTarget(
            name: "create-api",
            url: "https://github.com/aaronsky/CreateAPI/releases/download/0.2.0-alpha.2/create-api.artifactbundle.zip",
            checksum: "f0e34391c3c7b980d5e1b31e8b0b45680a74321b7013eeb11ace4c83aae69a75"
                // path: "create-api.artifactbundle.zip"
        ),
        .plugin(
            name: "CreateAPI",
            capability: .command(
                intent: .custom(
                    verb: "generate-openapi",
                    description: "Generates the OpenAPI entities and paths using CreateAPI"
                ),
                permissions: [
                    .writeToPackageDirectory(reason: "To output the generated source code")
                ]
            ),
            dependencies: [
                .target(name: "create-api")
            ]
        ),
    ]
)
