import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Error thrown when the transport resolves a data transfer and encounters an incompatibility.
public enum TransportError: Error {
    case unrecognizedResponse
}

/// Interface for the asynchronous communication layer the ``AppStoreConnectClient`` uses.
public protocol Transport {
    func send(request: URLRequest, decoder: JSONDecoder) async throws -> Response<Data>

    func download(request: URLRequest) async throws -> Response<URL>
}

extension URLSession: Transport {
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

        return try Response(data: data, response: response, statusCode: response.statusCode, decoder: decoder)
        #endif
    }

    private func send(
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
                    return try Response(
                        data: data,
                        response: response,
                        statusCode: response.statusCode,
                        decoder: decoder
                    )
                }
            )
        }
        task.resume()
    }

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

        return Response(data: fileURL, response: response, statusCode: response.statusCode)
        #endif
    }

    private func download(
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
                    return Response(data: fileURL, response: response, statusCode: response.statusCode)
                }
            )
        }
        task.resume()
    }
}
