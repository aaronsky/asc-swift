# ``AppStoreConnect``

A Swift library for accessing Apple's App Store Connect API.

## Overview

The entire [publicly documented API surface](https://developer.apple.com/documentation/appstoreconnectapi) is supported by this package.

## Topics

### Essentials

- <doc:GettingStarted>
- ``AppStoreConnectClient``

### Authentication

- ``JWT``

#### Pagination

- ``AppStoreConnectClient/pages(_:)``
- ``PagedResponses``

### Uploading Files

- <doc:UploadingFiles>
- ``AppStoreConnectClient/upload(operation:from:)``

### Internals

- ``Authenticator``
- ``Transport``
- ``Response``
- ``TransportError``
