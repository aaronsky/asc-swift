# ``AppStoreConnect``

A Swift library for accessing Apple's App Store Connect API and Enterprise Program API.

## Overview

This target is the client, networking layer, authentication layer, and queueing system for requests to the App Store Connect API and Enterprise Program API. The `AppStoreAPI` and `EnterpriseAPI` targets are the API layers.

## Topics

### Essentials

- <doc:GettingStarted>
- ``AppStoreConnectClient``

### Authentication

- ``JWT``

### Error Handling

- ``RetryStrategy``
- ``Rate``
- ``ErrorResponse``

### Paging Large Data Sets

- ``AppStoreConnectClient/pages(_:retry:)``
- ``PagedResponses``
- ``PagedDocumentLinks``

### Internals

- ``Authenticator``
- ``Transport``
- ``Request``
- ``Response``
- ``TransportError``
