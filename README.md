# App Store Connect

[![Test Status](https://github.com/aaronsky/asc-swift/workflows/CI/badge.svg)](https://github.com/aaronsky/asc-swift/actions?query=workflow%253A%2522CI%2522)

A Swift library for accessing Apple's [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi).

```swift
import AppStoreConnect

let privateKey = try JWT.PrivateKey(contentsOf: URL(filePath: "..."))
let client = AppStoreConnectClient(
    authenticator: JWT(
        keyID: "...",
        issuerID: "...",
        expiryDuration: 20 * 60, // 20 minutes
        privateKey: privateKey
    )
)

let apps = try await client.send(Resources.v1.apps.get())
print(apps)
```

## Installation

This library uses the Swift Package Manager. It supports Swift 5.7 and higher, and has minimum requirements of iOS 15, macOS 12, tvOS 15, and watchOS 8. It also strives to be fully supported for deployment on all other platforms outlined by Swift.org [Platform Support page](https://www.swift.org/platform-support/#deployment-only), such as the various Linux flavors and Windows.

To add AppStoreConnect to your project, add a package dependency in Xcode as you normally would, or add it to the `dependencies` value of your `Package.swift` manifest:

```swift
dependencies: [
    .package(url: "https://github.com/mergesort/Boutique.git", .upToNextMajor(from: "1.0.0"))
]
```

## Usage

### Authentication

### Rate Limiting

### Pagination

## Contributing

This project's primary goal is to cover the entire API surface exposed by the official App Store Connect API. Otherwise, it's being developed to aid in internal application development by the authors. Therefore, until the package's version stabilizes with v1, there isn't a strong roadmap beyond those stated goals. However, contributions are always welcome. If you want to get involved or you just want to offer feedback, please see [`CONTRIBUTING.md`](https://github.com/aaronsky/asc-swift/blob/main/.github/CONTRIBUTING.md) for details.

## License

This library is released under the BSD-2 license.

See [LICENSE](https://github.com/aaronsky/buildkite-swift/blob/master/LICENSE) for the full text.

## Credits

The technical direction of this library was driven by prior work on [asc-go](https://github.com/cidertool/asc-go) and [appstoreconnect](https://github.com/aaronsky/appstoreconnect), as well as a fully-fledged example produced by [@AvdLee](https://github.com/AvdLee) et al. in [appstoreconnect-swift-sdk](https://github.com/AvdLee/appstoreconnect-swift-sdk). Client design was driven by prior work on [buildkite-swift](https://github.com/aaronsky/buildkite-swift) and [wanikani-swift](https://github.com/aaronsky/wanikani-swift). App Store Connect and the App Store Connect API are property of Apple.
