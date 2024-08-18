# App Store Connect

[![Test Status](https://github.com/aaronsky/asc-swift/workflows/CI/badge.svg)](https://github.com/aaronsky/asc-swift/actions?query=workflow%253A%2522CI%2522)

A Swift library for accessing Apple's [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi) and [Enterprise Program API](https://developer.apple.com/documentation/enterpriseprogramapi).

```swift
import AppStoreConnect
import AppStoreAPI

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

This project uses the Swift Package Manager. It supports Swift 5.10 and higher, and has minimum requirements of iOS 15, macOS 12, tvOS 15, and watchOS 8. It also strives to be fully supported for deployment on all other platforms outlined by Swift.org [Platform Support page](https://www.swift.org/platform-support/#deployment-only), such as the various Linux flavors and Windows. App Store Connect API version 3.5 and Enterprise Program 1.0 are supported.

The package defines two products: `AppStoreConnect` and `EnterpriseProgram`. Each product provides the `AppStoreConnect` module, which contains the client and authentication logic, and either the `AppStoreAPI` or `EnterpriseAPI` modules, respectively.

To use `AppStoreConnect` in your project, add the following line to the dependencies in your `Package.swift` file:

```swift
.package(url: "https://github.com/aaronsky/asc-swift", from: "0.7.0"),
```

Then, include `"AppStoreConnect"` as a dependency of your target:

```swift
.target(name: "<target>", dependencies: [
    .product(name: "AppStoreConnect", package: "AppStoreConnect"),
]),
```

Finally, add `import AppStoreConnect` to your code to import the client, and `import AppStoreAPI` to import the API bindings.

To use the Enterprise Program API, add the `"EnterpriseProgram"` product as a target dependency instead of `"AppStoreConnect"`. It is also supported to include both products as dependencies of the same target.

## Usage

### Authentication

Neither the App Store Connect API nor Enterprise Program API have any methods that allow for unauthorized requests. To make it easy to authenticate with App Store Connect, this library offers the aforementioned `JWT` type to handle signing and rotating JSON Web Tokens automatically when they expire. For example:

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
```

`JWT` instances are bound to the API they are intended for, as credentials are not portable between teams. The designated default is the App Store Connect API. To use the Enterprise Program API, provide `api: .enterpriseProgram` as the first argument to the `JWT` initializer.

You can learn more about creating the necessary credentials for the App Store Connect API at Apple's documentation page via [Creating API Keys for App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi/creating_api_keys_for_app_store_connect_api), or the corresponding Enterprise Program API documentation [here](https://developer.apple.com/documentation/enterpriseprogramapi/creating-api-keys-for-enterprise-program-api). All App Store Connect and Enterprise Program APIs are scoped to the credentials of the pre-configured key, so you can't use this API to make queries against the entire App Store.

### Handling Errors and Rate Limiting

In many cases where the API would respond with an error, the API will include an `ErrorResponse` object describing the failure in detail. This object also contains properties that can be used to diagnose the root cause of issues if they are due to malformed requests. If the API responds with an error, `AppStoreConnectClient` will throw `Response.Error.requestFailure` for your consideration. This error contains the `ErrorResponse` returned from the API, the HTTP status code, and the underlying response.

Additionally, Apple imposes a rate limit on all API clients. If the API produces a rate limit error, `AppStoreConnectClient` will throw `Response.Error.rateLimitExceeded` for your convenience. This error contains the `ErrorResponse` returned from the API, a `Response.Rate` containing call limit and remaining call information, and the underlying response.

For example:

```swift
do {
    let apps = try await client.send(Resources.v1.apps.get())
} catch Response.Error.requestFailure(let error, let statusCode, let response) {
    print("Received an error: \(error)")
} catch Response.Error.rateLimitExceeded(let error, let rate, let response) {
    print("Client has exceeded the rate limit")
} catch {
    print("An unexpected error occurred: \(error.localizedDescription)")
}
```

You can learn more about how to handle errors from the App Store Connect API at Apple's documentation page via [Interpreting and Handling Errors](https://developer.apple.com/documentation/appstoreconnectapi/interpreting_and_handling_errors). You can learn more about rate limiting at Apple's documentation page via [Identifying Rate Limits](https://developer.apple.com/documentation/appstoreconnectapi/identifying_rate_limits). Corresponding documentation for the Enterprise Program API can be found [here](https://developer.apple.com/documentation/enterpriseprogramapi/interpreting-and-handling-errors) and [here](https://developer.apple.com/documentation/enterpriseprogramapi/identifying-rate-limits), respectively.

### Paging Large Data Sets

All requests for resource collections (apps, builds, beta groups, etc.) support pagination. Responses for paginated resources will contain a `links` property of type `PagedDocumentLinks`, with "reference" URLs for `first`, `next`, and `self`. You can also find more information about the per-page limit and total count of resources in the response's `meta` field of type `PagingInformation`. You typically shouldn't require any of this information for typical pagination.

The most common application for pagination is paging forward from the first "page". For example:

```swift
for try await appsPage in client.pages(Resources.v1.apps.get()) {
    print(appsPage)
}
```

You can also page forward manually using the `send(_:pageAfter:)` method on `AppStoreConnectClient`.

### Uploading Assets

App Store Connect employs a three-step process to upload assets such as previews, screenshots, and routing coverage files as app metadata. The process can be described from a high level as:

1. Make a reservation for the asset
2. Upload the asset in chunks defined by the API
3. Commit the reservation

The process has several fault points and is outlined in detail on Apple's documentation page, [Uploading Assets to App Store Connect](https://developer.apple.com/documentation/appstoreconnectapi/uploading_assets_to_app_store_connect). This library includes two examples of how to upload assets, [`upload_preview`](./Examples/upload_preview/UploadPreview.swift) and [`upload_screenshot`](./Examples/upload_screenshot/UploadScreenshot.swift), as well as [one detailed article](./Sources/AppStoreConnect/AppStoreConnect.docc/Articles/UploadingFiles.md).

## Contributing

This project's primary goal is to cover the entire API surface exposed by the official App Store Connect API and Enterprise Program API. Otherwise, it's being developed to aid in internal application development by the authors. Therefore, until the package's version stabilizes with v1, there isn't a strong roadmap beyond those stated goals. However, contributions are always welcome. If you want to get involved or you just want to offer feedback, please see [`CONTRIBUTING.md`](https://github.com/aaronsky/asc-swift/blob/main/.github/CONTRIBUTING.md) for details.

## License

This library is released under the BSD-2 license.

See [LICENSE](https://github.com/aaronsky/asc-swift/blob/master/LICENSE) for the full text.

## Credits

The technical direction of this library was driven by prior work on [asc-go](https://github.com/cidertool/asc-go) and [appstoreconnect](https://github.com/aaronsky/appstoreconnect), as well as a fully-fledged example produced by [@AvdLee](https://github.com/AvdLee) et al. in [appstoreconnect-swift-sdk](https://github.com/AvdLee/appstoreconnect-swift-sdk). Client design was driven by prior work on [buildkite-swift](https://github.com/aaronsky/buildkite-swift) and [wanikani-swift](https://github.com/aaronsky/wanikani-swift). App Store Connect, the App Store Connect API, and the Enterprise Program API are property of Apple.
