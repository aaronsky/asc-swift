# Getting Started

Initialize a client and get started with sending resources by listing all apps published by your App Store team. 

## Overview

This article is an overview of how to set up an App Store Connect client to interact with the API.

### Get Your Access Token

The App Store Connect API requires authentication with every request. In order to authenticate, you must first create a private key on your App Store Connect team page, and note the key ID and issuer ID. Apple outlines this process thoroughly in their documentation via [Generating Tokens for API Requests](https://developer.apple.com/documentation/appstoreconnectapi/generating_tokens_for_api_requests). Keep in mind that securely storing tokens used with this package is the responsibility of the developer. 

### Create a Client

Creating a client object is as simple as calling the default initializer with the requisite authentication data. 

```swift
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

### Send a Request

To send a request, use one of the `send` methods on the client. 

```swift
let apps = try await client.send(Resources.v1.apps.get())
```
