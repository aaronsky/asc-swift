# ``AppStoreConnect/Authenticator``

The ``Authenticator`` protocol provides rolling token and API-relevance information to the ``AppStoreConnectClient``.

### Conformance notes

A core assumption of a custom ``Authenticator`` implementation is that each instance is only compatible with one API – either the App Store Connect API or Enterprise Program API. It is not recommended to create a single authenticator that can arbitrarily switch between the two whenever a token is requested, as this can interfere with a client's caching mechanism. 
