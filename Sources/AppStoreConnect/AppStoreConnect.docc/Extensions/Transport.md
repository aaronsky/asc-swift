# ``AppStoreConnect/Transport``

Implementors of the ``Transport`` protocol provide the data transport layer to the client. 

## Overview

### Conformance notes

``AppStoreConnect`` provides a default, reasonably cross-platform implementation of ``Transport`` on ``Foundation/URLSession``. If you require support for other transport layers, such as [swift-nio](https://github.com/apple/swift-nio), it will be required to implement ``Transport`` yourself on your own types. Conforming to ``Transport`` implies a handful of responsibilities so that client behavior is consistent:

- The ``Response`` returned by each method should have ``Response/check()`` called before returning.
- If the response from the API is malformed prior to decoding, such as in a situation where the response is not HTTP, consider throwing ``TransportError/unrecognizedResponse``.
- The client does not do any additional caching, nor does it intentionally check against the `Last-Modified` HTTP header coming from the APIs. If you wish to introduce a caching mechanism for responses, it should be done in the ``Transport`` layer.
