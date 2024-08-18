// swift-tools-version: 6.0

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
            targets: ["AppStoreConnect", "AppStoreAPI"]
        ),
        .library(
            name: "EnterpriseProgram",
            targets: ["AppStoreConnect", "EnterpriseAPI"]
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
        .target(
            name: "EnterpriseAPI",
            dependencies: [
                "AppStoreConnect",
                .product(name: "URLQueryEncoder", package: "URLQueryEncoder"),
            ],
            exclude: [
                "enterprise_api_1.0_openapi.json"
            ]
        ),
        .target(
            name: "Mocks",
            dependencies: ["AppStoreConnect"],
            path: "Tests/Mocks"
        ),
        .testTarget(
            name: "AppStoreConnectTests",
            dependencies: ["AppStoreConnect", "Mocks"]
        ),
        .testTarget(
            name: "AppStoreAPITests",
            dependencies: ["AppStoreAPI", "AppStoreConnect", "Mocks"]
        ),
        .binaryTarget(
            name: "create-api",
            url: "https://github.com/aaronsky/CreateAPI/releases/download/0.2.0-alpha.3/create-api.artifactbundle.zip",
            checksum: "87cca616f8e80c08773e5da7f1267abeecbca44162ac67f7dd3f853464a0ed1e"
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
    ],
    swiftLanguageModes: [.v6]
)
