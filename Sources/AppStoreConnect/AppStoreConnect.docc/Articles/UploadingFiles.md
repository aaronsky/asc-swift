# Uploading Files

Upload screenshots, app previews, attachments for App Review, and routing app coverage files to App Store Connect.

## Overview

In this document, the process of uploading an app screenshot to App Store Connect will be explained. The workflow is the same for uploading other types of assets. 

Uploading assets to the App Store Connect API can be complex, despite being rigorously procedural. Anything that is not answered by this document may be answered and applicable to Apple's own documentation page via [Uploading Assets to App Store Connect](https://developer.apple.com/documentation/appstoreconnectapi/uploading_assets_to_app_store_connect). This document also presumes that you have an authenticated ``AppStoreConnectClient`` instance at the ready. 

### Uploading a Screenshot

To start, the file you want to upload should be loaded as `Data`. You should be able to reference the file's base name, as well as its MD5 checksum. To construct an MD5 checksum, see the documentation in [CryptoKit](https://developer.apple.com/documentation/cryptokit)/[swift-crypto](https://github.com/apple/swift-crypto) for the MD5 algorithm. For example:

```swift
let url = URL(filePath: "path/to/screenshot.png")
let basename = url.lastPathComponent
let screenshotData = try Data(contentsOf: url)
let checksum = "..."
```

First, request the App Screenshot Set the screenshot should be created on.

```swift
let screenshotSetID = "..."
let screenshotSet = try await client.send(
    Resources.v1.appScreenshotSets.id(screenshotSetID).get()
)
```

Use the details of this screenshot set to reserve a new screenshot asset. The response will contain details about how to go about uploading the screenshot data.

```swift
let reserveScreenshot = try await client.send(
    Resources.v1.appScreenshots.post(
        .init(
            data: .init(
                attributes: .init(
                    fileSize: screenshotData.count,
                    fileName: basename
                ),
                relationships: .init(appScreenshotSet: .init(data: .init(id: screenshotSet.data.id)))
            )
        )
    )
)
```

Using the screenshot response from the last step, unwrap the ``AppScreenshot/Attributes-swift.struct/uploadOperations`` array. While iterating on the array, provide the screenshot data and each operation in sequential order to ``AppStoreConnectClient/upload(operation:from:)``. 

```swift
guard let uploadOperations = reserveScreenshot.data.attributes?.uploadOperations else { return }

for operation in uploadOperations {
    try await client.upload(operation: operation, from: screenshotData)
}
```

Finally, commit the asset by updating its resource that it has been fully uploaded. Providing a checksum will help ensure file integrity on the App Store Connect backend.

```swift
let committedScreenshot = try await client.send(
    Resources.v1.appScreenshots.id(reserveScreenshot.data.id).patch(
        .init(
            data: .init(
                id: reserveScreenshot.data.id, 
                attributes: .init(
                    sourceFileChecksum: checksum, 
                    isUploaded: true
                )
            )
        )
    )
)
```

Committing the asset will cause App Store Connect to asynchronously process the asset. It may take several minutes to complete processing. You can perform ``Resources/V1-swift.struct/AppScreenshots-swift.struct/WithID/get(fieldsAppScreenshots:include:)`` to check its processing status and catch errors, which will be stored in ``AppScreenshot/Attributes-swift.struct/assetDeliveryState``. If your asset's state is set to ``AppMediaAssetState/State-swift.enum/failed``, you will need to restart this workflow to create a new screenshot with the errors addressed.

- ``AppStoreConnectClient/upload(operation:from:)``
- ``UploadOperation``
- ``AppMediaAssetState``
