import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Error thrown when the transport resolves a data transfer and has received no data or
/// response object.
public enum TransportError: Error {
    case noResponse
}

/// Interface for the asynchronous communication layer the ``AppStoreConnectClient`` uses.
public protocol Transport {
    typealias Output = (data: Data, response: URLResponse)

    /// Send the request and receive the ``Output`` asynchronously.
    func send(request: URLRequest) async throws -> Output
}

extension URLSession: Transport {
    public func send(request: URLRequest) async throws -> Output {
        // These depend on swift-corelibs-foundation, which have not implemented the
        // Task-based API for URLSession.
        #if os(Linux) || os(Windows)
        return try await withCheckedThrowingContinuation { continuation in
            send(request: request, completion: continuation.resume)
        }
        #else
        guard #available(iOS 15, macOS 12, tvOS 15, watchOS 8, *) else {
            return try await withCheckedThrowingContinuation { continuation in
                send(request: request, completion: continuation.resume)
            }
        }

        return try await data(for: request)
        #endif
    }

    private func send(request: URLRequest, completion: @escaping (Result<Output, Error>) -> Void) {
        let task = dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data, let response = response else {
                completion(.failure(TransportError.noResponse))
                return
            }
            completion(.success((data: data, response: response)))
        }
        task.resume()
    }
}
