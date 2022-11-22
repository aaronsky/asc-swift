# ``AppStoreConnect``

A Swift library for accessing Apple's App Store Connect API.

## Overview

The entire [publicly documented API surface](https://developer.apple.com/documentation/appstoreconnectapi) is supported by this package.

[App Store Connect API Release Notes](https://developer.apple.com/documentation/appstoreconnectapi/app_store_connect_api_release_notes)

## Topics

### Essentials

- <doc:GettingStarted>
- ``AppStoreConnectClient``
- ``Resources``

### Authentication

- ``JWT``

### Error Handling

- ``ErrorResponse``
- ``ErrorSourceParameter``
- ``ErrorSourcePointer``

### Paging Large Data Sets

- ``AppStoreConnectClient/pages(_:)``
- ``PagedResponses``
- ``PagedDocumentLinks``
- ``PagingInformation``
- ``ResourceLinks``
- ``DocumentLinks``

### Uploading Files

- <doc:UploadingFiles>
- ``AppStoreConnectClient/upload(operation:from:)``
- ``UploadOperation``
- ``HTTPHeader``
- ``AppMediaAssetState``
- ``AppMediaStateError``

### Internals

- ``Authenticator``
- ``Transport``
- ``Request``
- ``Response``
- ``TransportError``
