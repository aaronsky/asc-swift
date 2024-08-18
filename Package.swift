// swift-tools-version: 5.10

import PackageDescription

let swift6UpcomingFeatures: [SwiftSetting] = [
    .enableUpcomingFeature("BareSlashRegexLiterals"),
    .enableUpcomingFeature("ConciseMagicFile"),
    .enableUpcomingFeature("DeprecateApplicationMain"),
    .enableUpcomingFeature("DisableOutwardActorInference"),
    .enableUpcomingFeature("DynamicActorIsolation"),
    .enableUpcomingFeature("ForwardTrailingClosures"),
    .enableUpcomingFeature("GlobalActorIsolatedTypesUsability"),
    .enableUpcomingFeature("GlobalConcurrency"),
    .enableUpcomingFeature("ImplicitOpenExistentials"),
    .enableUpcomingFeature("ImportObjcForwardDeclarations"),
    .enableUpcomingFeature("InferSendableFromCaptures"),
    .enableUpcomingFeature("IsolatedDefaultValues"),
    .enableUpcomingFeature("NonfrozenEnumExhaustivity"),
    .enableUpcomingFeature("RegionBasedIsolation"),
    .enableUpcomingFeature("StrictConcurrency"),
]

let swift7UpcomingFeatures: [SwiftSetting] = [
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("InternalImportsByDefault"),
]

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
            ],
            swiftSettings: swift6UpcomingFeatures + swift7UpcomingFeatures
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
            ],
            swiftSettings: swift6UpcomingFeatures + swift7UpcomingFeatures
        ),
        .target(
            name: "EnterpriseAPI",
            dependencies: [
                "AppStoreConnect",
                .product(name: "URLQueryEncoder", package: "URLQueryEncoder"),
            ],
            exclude: [
                "enterprise_api_1.0_openapi.json"
            ],
            swiftSettings: swift6UpcomingFeatures + swift7UpcomingFeatures
        ),
        .target(
            name: "Mocks",
            path: "Tests/Mocks"
        ),
        .testTarget(
            name: "AppStoreConnectTests",
            dependencies: ["AppStoreConnect", "Mocks"],
            swiftSettings: swift6UpcomingFeatures + swift7UpcomingFeatures
        ),
        .testTarget(
            name: "AppStoreAPITests",
            dependencies: ["AppStoreAPI", "AppStoreConnect", "Mocks"],
            swiftSettings: swift6UpcomingFeatures + swift7UpcomingFeatures
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
    ]
)
