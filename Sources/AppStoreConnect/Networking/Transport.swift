import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

let rateLimitHeader = "X-Rate-Limit"

/// Error thrown when the transport resolves a data transfer and encounters an incompatibility.
public enum TransportError: Error, Equatable {
    /// The response that was received was not in a recognized format.
    case unrecognizedResponse
}

/// Interface for the asynchronous communication layer the ``AppStoreConnectClient`` uses.
public protocol Transport: Sendable {
    /// Send the request and receive a ``Response`` asynchronously.
    /// - Parameters:
    ///   - request: A request.
    ///   - decoder: A decoder object capable of decoding an ``ErrorResponse`` object, in case one is received.
    /// - Returns: The response from the App Store Connect API.
    /// - Throws: An error describing the manner in which the request failed to complete.
    func send(request: URLRequest, decoder: JSONDecoder) async throws -> Response<Data>

    /// Download the requested resource and store it on-disk.
    /// - Parameter request: A request.
    /// - Returns: A ``Response`` that describes the location of the downloaded file.
    /// - Throws: An error describing the manner in which the request failed to complete.
    func download(request: URLRequest) async throws -> Response<URL>

    /// Upload the data using the request and receive a ``Response`` asynchronously.
    /// - Parameters:
    ///   - request: A request.
    ///   - data: The data to upload.
    ///   - decoder: A decoder object capable of decoding an ``ErrorResponse`` object, in case one is received.
    /// - Returns: The response from the App Store Connect API.
    /// - Throws: An error describing the manner in which the request failed to complete.
    func upload(request: URLRequest, data: Data, decoder: JSONDecoder) async throws -> Response<Data>
}

extension URLSession: Transport {
    /// Send the request and receive a ``Response`` asynchronously.
    /// - Parameters:
    ///   - request: A request.
    ///   - decoder: A decoder object capable of decoding an ``ErrorResponse`` object, in case one is received.
    /// - Returns: The response from the App Store Connect API.
    /// - Throws: An error describing the manner in which the request failed to complete.
    public func send(request: URLRequest, decoder: JSONDecoder) async throws -> Response<Data> {
        // These depend on swift-corelibs-foundation, which have not implemented the
        // Task-based API for URLSession.
        #if (os(Linux) || os(Windows)) && swift(<6.0)
            return try await withCheckedThrowingContinuation { continuation in
                send(request: request, decoder: decoder, completion: continuation.resume)
            }
        #else
            let (data, urlResponse) = try await data(for: request)

            guard let urlResponse = urlResponse as? HTTPURLResponse else {
                throw TransportError.unrecognizedResponse
            }

            let response = Response(
                data: data,
                response: urlResponse,
                statusCode: urlResponse.statusCode,
                rate: Rate(from: urlResponse.value(forHTTPHeaderField: rateLimitHeader)),
                decoder: decoder
            )

            try response.check()

            return response
        #endif
    }

    /// Use the old URLSessionDataTask API with a completion handler.
    ///
    /// Only used for backwards compatibility on swift-corelibs-foundation platforms. Made internal for testing.
    /// - Parameters:
    ///   - request: A request.
    ///   - decoder: A decoder object capable of decoding an ``ErrorResponse`` object, in case one is received.
    ///   - completion: A completion handler. Executed on an arbitrary queue.
    func send(
        request: URLRequest,
        decoder: JSONDecoder,
        completion: @escaping @Sendable (Result<Response<Data>, any Error>) -> Void
    ) {
        let task = dataTask(with: request) { data, urlResponse, error in
            completion(
                Result {
                    if let error = error {
                        throw error
                    }

                    guard let urlResponse = urlResponse as? HTTPURLResponse else {
                        throw TransportError.unrecognizedResponse
                    }

                    let response = Response(
                        data: data,
                        response: urlResponse,
                        statusCode: urlResponse.statusCode,
                        rate: Rate(from: urlResponse.value(forHTTPHeaderField: rateLimitHeader)),
                        decoder: decoder
                    )

                    try response.check()

                    return response
                }
            )
        }
        task.resume()
    }

    /// Download the requested resource and store it on-disk.
    /// - Parameter request: A request.
    /// - Returns: A ``Response`` that describes the location of the downloaded file.
    /// - Throws: An error describing the manner in which the request failed to complete.
    public func download(request: URLRequest) async throws -> Response<URL> {
        // These depend on swift-corelibs-foundation, which have not implemented the
        // Task-based API for URLSession.
        #if (os(Linux) || os(Windows)) && swift(<6.0)
            return try await withCheckedThrowingContinuation { continuation in
                download(request: request, completion: continuation.resume)
            }
        #else
            let (fileURL, urlResponse) = try await download(for: request)

            guard let urlResponse = urlResponse as? HTTPURLResponse else {
                throw TransportError.unrecognizedResponse
            }

            let response = Response(
                fileURL: fileURL,
                response: urlResponse,
                statusCode: urlResponse.statusCode,
                rate: Rate(from: urlResponse.value(forHTTPHeaderField: rateLimitHeader))
            )

            try response.check()

            return response
        #endif
    }

    /// Use the old URLSessionDownloadTask API with a completion handler.
    ///
    /// Only used for backwards compatibility on swift-corelibs-foundation platforms. Made internal for testing.
    /// - Parameters:
    ///   - request: A request.
    ///   - completion: A completion handler. Executed on an arbitrary queue.
    func download(
        request: URLRequest,
        completion: @escaping @Sendable (Result<Response<URL>, any Error>) -> Void
    ) {
        let task = downloadTask(with: request) { fileURL, urlResponse, error in
            completion(
                Result {
                    if let error = error {
                        throw error
                    }

                    guard let urlResponse = urlResponse as? HTTPURLResponse else {
                        throw TransportError.unrecognizedResponse
                    }

                    let response = Response(
                        fileURL: fileURL,
                        response: urlResponse,
                        statusCode: urlResponse.statusCode,
                        rate: Rate(from: urlResponse.value(forHTTPHeaderField: rateLimitHeader))
                    )

                    try response.check()

                    return response
                }
            )
        }
        task.resume()
    }

    /// Upload the data using the request and receive a ``Response`` asynchronously.
    /// - Parameters:
    ///   - request: A request.
    ///   - data: The data to upload.
    ///   - decoder: A decoder object capable of decoding an ``ErrorResponse`` object, in case one is received.
    /// - Returns: The response from the App Store Connect API.
    /// - Throws: An error describing the manner in which the request failed to complete.
    public func upload(request: URLRequest, data: Data, decoder: JSONDecoder) async throws -> Response<Data> {
        // These depend on swift-corelibs-foundation, which have not implemented the
        // Task-based API for URLSession.
        #if (os(Linux) || os(Windows)) && swift(<6.0)
            return try await withCheckedThrowingContinuation { continuation in
                upload(request: request, data: data, decoder: decoder, completion: continuation.resume)
            }
        #else
            let (responseData, urlResponse) = try await upload(for: request, from: data)

            guard let urlResponse = urlResponse as? HTTPURLResponse else {
                throw TransportError.unrecognizedResponse
            }

            let response = Response(
                data: responseData,
                response: urlResponse,
                statusCode: urlResponse.statusCode,
                rate: Rate(from: urlResponse.value(forHTTPHeaderField: rateLimitHeader)),
                decoder: decoder
            )

            try response.check()

            return response
        #endif
    }

    /// Use the old URLSessionUploadTask API with a completion handler.
    ///
    /// Only used for backwards compatibility on swift-corelibs-foundation platforms. Made internal for testing.
    /// - Parameters:
    ///   - request: A request.
    ///   - data: The data to upload.
    ///   - decoder: A decoder object capable of decoding an ``ErrorResponse`` object, in case one is received.
    ///   - completion: A completion handler. Executed on an arbitrary queue.
    func upload(
        request: URLRequest,
        data: Data,
        decoder: JSONDecoder,
        completion: @escaping @Sendable (Result<Response<Data>, any Error>) -> Void
    ) {
        let task = uploadTask(with: request, from: data) { responseData, urlResponse, error in
            completion(
                Result {
                    if let error = error {
                        throw error
                    }

                    guard let urlResponse = urlResponse as? HTTPURLResponse else {
                        throw TransportError.unrecognizedResponse
                    }

                    let response = Response(
                        data: responseData,
                        response: urlResponse,
                        statusCode: urlResponse.statusCode,
                        rate: Rate(from: urlResponse.value(forHTTPHeaderField: rateLimitHeader)),
                        decoder: decoder
                    )

                    try response.check()

                    return response
                }
            )
        }
        task.resume()
    }
}
