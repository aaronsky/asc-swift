// swift-tools-version: 5.7

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
            targets: ["AppStoreConnect"]
        )
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
                "_Specification",
                .product(name: "Crypto", package: "swift-crypto"),
            ]
        ),
        .target(
            name: "_Specification",
            dependencies: [
                .product(name: "URLQueryEncoder", package: "URLQueryEncoder")
            ],
            exclude: [
                ".create-api.yml",
                "app_store_connect_api_3.2_openapi.json",
            ]
        ),
        .testTarget(
            name: "AppStoreConnectTests",
            dependencies: ["AppStoreConnect"]
        ),
        .binaryTarget(
            name: "create-api",
            url: "https://github.com/CreateAPI/CreateAPI/releases/download/0.2.0/create-api.artifactbundle.zip",
            checksum: "6f8a3ce099f07eb2655ccaf6f66d8c9a09b74bb2307781c4adec36609ddac009"
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
