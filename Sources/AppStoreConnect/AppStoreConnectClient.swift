import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

// MARK: -

/// Client used to interface with all available App Store Connect APIs.
///
/// The primary mechanism of this library.
public actor AppStoreConnectClient {
    /// The network (or whatever) transport layer.
    ///
    /// Implemented by ``URLSession`` by default.
    package var transport: any Transport

    /// Authorization provider.
    ///
    /// Used to authenticate with the App Store Connect API. Implemented by ``JWT`` by default.
    package var authenticator: any Authenticator

    package var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .custom(encodeISO8601Date(_:encoder:))
        return encoder
    }

    package var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        return decoder
    }

    /// Creates a session with the specified configuration, transport layer, and token provider.
    ///
    /// - Parameters:
    ///   - transport: Transport layer used for API communication. Uses the shared `URLSession` by default.
    ///   - authenticator: Responsible for generating and managing access tokens. ``JWT`` is the default implementation.
    public init(
        transport: any Transport = URLSession.shared,
        authenticator: any Authenticator
    ) {
        self.transport = transport
        self.authenticator = authenticator
    }

    // MARK: - Requests

    /// Performs the given request asynchronously.
    ///
    /// - Parameters:
    ///   - request: A request.
    ///   - retry: Retry strategy.
    /// - Throws: An error describing the manner in which the request failed to complete.
    public func send(
        _ request: Request<Void>,
        retry strategy: some RetryStrategy = .never
    ) async throws {
        let urlRequest = try URLRequest(request: request, encoder: encoder, authenticator: &authenticator)

        _ = try await retry(with: strategy) {
            try await transport.send(request: urlRequest, decoder: decoder)
        }
    }

    /// Performs the given request asynchronously.
    ///
    /// - Parameters:
    ///   - request: A request.
    ///   - retry: Retry strategy.
    /// - Returns: The response from the App Store Connect API.
    /// - Throws: An error describing the manner in which the request failed to complete.
    public func send<Response>(
        _ request: Request<Response>,
        retry strategy: some RetryStrategy = .never
    ) async throws -> Response where Response: Decodable {
        let urlRequest = try URLRequest(request: request, encoder: encoder, authenticator: &authenticator)

        let response = try await retry(with: strategy) {
            try await transport.send(request: urlRequest, decoder: decoder)
        }

        return try response.decode(using: decoder)
    }

    // MARK: - Pagination

    /// Convenience method for accessing a series of paged resources in a sequence asynchronously.
    ///
    /// - Parameters:
    ///   - request: The initial request of the sequence.
    ///   - retry: Retry strategy.
    /// - Returns: A ``PagedResponses`` sequence which will provide with each page's response asynchronously.
    public nonisolated func pages<Response>(
        _ request: Request<Response>,
        retry strategy: some RetryStrategy = .never
    ) -> PagedResponses<Response> {
        PagedResponses(request: request, client: self, retry: strategy)
    }

    /// Performs the request that was used to fetch the current object to fetch the next page asynchronously.
    ///
    /// - Parameters:
    ///   - request: A request.
    ///   - currentPage: The API object representing the current page.
    ///   - retry: Retry strategy.
    /// - Returns: The response from the App Store Connect API.
    /// - Throws: An error describing the manner in which the request failed to complete.
    public func send<Response>(
        _ request: Request<Response>,
        pageAfter currentPage: Response,
        retry strategy: some RetryStrategy = .never
    ) async throws -> Response? where Response: Decodable {
        guard let nextPage = pagedDocumentLinks(currentPage)?.next else {
            return nil
        }

        let urlRequest = try URLRequest(url: nextPage, encoder: encoder, authenticator: &authenticator)

        let response = try await retry(with: strategy) {
            try await transport.send(request: urlRequest, decoder: decoder)
        }

        return try response.decode(using: decoder)
    }

    /// Performs the given request asynchronously.
    ///
    /// - Parameter object: Some object that may contain a property of the type ``PagedDocumentLinks``.
    /// - Returns: The ``PagedDocumentLinks`` instance, if one exists.
    private nonisolated func pagedDocumentLinks<Entity>(_ object: Entity) -> PagedDocumentLinks? {
        let mirror = Mirror(reflecting: object)
        return mirror.children.first(where: { $0.value is PagedDocumentLinks })
            .flatMap { $0.value as? PagedDocumentLinks }
    }

    // MARK: - Downloads

    /// Downloads a resource asynchronously to a temporary location.
    ///
    /// - Parameters:
    ///   - request: A request.
    ///   - retry: Retry strategy.
    /// - Returns: URL to the location of the resource on-disk.
    /// - Throws: An error describing the manner in which the request failed to complete.
    public func download(
        _ request: Request<Data>,
        retry strategy: some RetryStrategy = .never
    ) async throws -> URL {
        let urlRequest = try URLRequest(request: request, encoder: encoder, authenticator: &authenticator)

        let response = try await retry(with: strategy) {
            try await transport.download(request: urlRequest)
        }

        return try response.decode()
    }
}
