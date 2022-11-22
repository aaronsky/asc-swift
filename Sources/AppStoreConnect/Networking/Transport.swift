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
public protocol Transport {
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
        #if os(Linux) || os(Windows)
        return try await withCheckedThrowingContinuation { continuation in
            send(request: request, decoder: decoder, completion: continuation.resume)
        }
        #else
        let (data, response) = try await data(for: request)

        guard let response = response as? HTTPURLResponse else {
            throw TransportError.unrecognizedResponse
        }

        return Response(
            data: data,
            response: response,
            statusCode: response.statusCode,
            rate: Response.Rate(from: response.value(forHTTPHeaderField: rateLimitHeader)),
            decoder: decoder
        )
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
        completion: @escaping (Result<Response<Data>, Error>) -> Void
    ) {
        let task = dataTask(with: request) { data, response, error in
            completion(
                Result {
                    if let error = error {
                        throw error
                    }
                    guard let response = response as? HTTPURLResponse else {
                        throw TransportError.unrecognizedResponse
                    }
                    return Response(
                        data: data,
                        response: response,
                        statusCode: response.statusCode,
                        rate: Response.Rate(from: response.value(forHTTPHeaderField: rateLimitHeader)),
                        decoder: decoder
                    )
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
        #if os(Linux) || os(Windows)
        return try await withCheckedThrowingContinuation { continuation in
            download(request: request, completion: continuation.resume)
        }
        #else
        let (fileURL, response) = try await download(for: request)

        guard let response = response as? HTTPURLResponse else {
            throw TransportError.unrecognizedResponse
        }

        return Response(
            fileURL: fileURL,
            response: response,
            statusCode: response.statusCode,
            rate: Response.Rate(from: response.value(forHTTPHeaderField: rateLimitHeader))
        )
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
        completion: @escaping (Result<Response<URL>, Error>) -> Void
    ) {
        let task = downloadTask(with: request) { fileURL, response, error in
            completion(
                Result {
                    if let error = error {
                        throw error
                    }
                    guard let response = response as? HTTPURLResponse else {
                        throw TransportError.unrecognizedResponse
                    }
                    return Response(
                        fileURL: fileURL,
                        response: response,
                        statusCode: response.statusCode,
                        rate: Response.Rate(from: response.value(forHTTPHeaderField: rateLimitHeader))
                    )
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
        #if os(Linux) || os(Windows)
        return try await withCheckedThrowingContinuation { continuation in
            upload(request: request, data: data, decoder: decoder, completion: continuation.resume)
        }
        #else
        let (responseData, response) = try await upload(for: request, from: data)

        guard let response = response as? HTTPURLResponse else {
            throw TransportError.unrecognizedResponse
        }

        return Response(
            data: responseData,
            response: response,
            statusCode: response.statusCode,
            rate: Response.Rate(from: response.value(forHTTPHeaderField: rateLimitHeader)),
            decoder: decoder
        )
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
        completion: @escaping (Result<Response<Data>, Error>) -> Void
    ) {
        let task = uploadTask(with: request, from: data) { responseData, response, error in
            completion(
                Result {
                    if let error = error {
                        throw error
                    }
                    guard let response = response as? HTTPURLResponse else {
                        throw TransportError.unrecognizedResponse
                    }
                    return Response(
                        data: responseData,
                        response: response,
                        statusCode: response.statusCode,
                        rate: Response.Rate(from: response.value(forHTTPHeaderField: rateLimitHeader)),
                        decoder: decoder
                    )
                }
            )
        }
        task.resume()
    }
}
