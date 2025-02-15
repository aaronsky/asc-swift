import AppStoreConnect
import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

extension AppStoreConnectClient {
    // MARK: - Uploads

    /// Uploads a chunk of data asynchronously given an ``UploadOperation`` model.
    /// - Parameters:
    ///   - operation: Information about the expected size of the chunk and its upload destination.
    ///   - data: The data representation of the uploaded resource.
    ///   - retry: Retry strategy.
    /// - Throws: An error describing the manner in which the upload failed to complete.
    public func upload(
        operation: UploadOperation,
        from data: Data,
        retry strategy: some RetryStrategy = .never
    ) async throws {
        guard let offset = operation.offset, let length = operation.length else {
            throw UploadOperation.Error.chunkBoundsMismatch(offset: operation.offset, length: operation.length)
        }

        let dataChunk = data[offset..<(length + offset)]
        let urlRequest = try URLRequest(
            uploadOperation: operation,
            encoder: encoder,
            authenticator: &authenticator
        )

        _ = try await retry(with: strategy) {
            try await transport.upload(request: urlRequest, data: dataChunk, decoder: decoder)
        }
    }
}

extension UploadOperation {
    /// Describes missing required information about the ``UploadOperation``.
    public enum Error: Swift.Error, Equatable {
        case missingDestination(url: String?, method: String?)
        case chunkBoundsMismatch(offset: Int?, length: Int?)
    }
}

extension URLRequest {
    init(
        uploadOperation: UploadOperation,
        encoder: JSONEncoder,
        authenticator: inout any Authenticator
    ) throws {
        guard let url = uploadOperation.url.flatMap(URL.init), let method = uploadOperation.method else {
            throw UploadOperation.Error.missingDestination(url: uploadOperation.url, method: uploadOperation.method)
        }
        let headers: [(String, String?)] =
            uploadOperation.requestHeaders?
            .compactMap { header in
                guard let name = header.name else { return nil }
                return (name, header.value)
            } ?? []
        try self.init(
            url: url,
            method: method,
            headers: headers,
            body: nil,
            encoder: encoder,
            authenticator: &authenticator
        )
    }
}
