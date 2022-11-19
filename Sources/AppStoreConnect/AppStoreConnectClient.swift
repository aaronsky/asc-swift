import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Client used to interface with all available App Store Connect APIs. The primary mechanism of this library.
public actor AppStoreConnectClient {
    public typealias StatusCode = Int

    /// The network (or whatever) transport layer. Implemented by URLSession by default.
    var transport: Transport

    var authenticator: Authenticator

    var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .custom(Formatters.encodeISO8601)
        return encoder
    }

    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(Formatters.decodeISO8601)
        return decoder
    }

    public init(
        transport: Transport = URLSession.shared,
        authenticator: Authenticator
    ) {
        self.transport = transport
        self.authenticator = authenticator
    }

    public func send(_ request: Request<Void>) async throws {
        let urlRequest = try URLRequest(request: request, encoder: encoder, authenticator: &authenticator)
        let response = try await transport.send(request: urlRequest, decoder: decoder)
        try response.check()
    }

    public func send<T>(_ request: Request<T>) async throws -> T where T: Decodable {
        let urlRequest = try URLRequest(request: request, encoder: encoder, authenticator: &authenticator)
        let response = try await transport.send(request: urlRequest, decoder: decoder)
        try response.check()

        return try response.decode(using: decoder)
    }

    public func download(_ request: Request<Data>) async throws -> URL {
        let urlRequest = try URLRequest(request: request, encoder: encoder, authenticator: &authenticator)
        let response = try await transport.download(request: urlRequest)
        try response.check()

        return try response.decode()
    }

    public func pages<T>(_ request: Request<T>) -> PagedResponses<T> {
        PagedResponses(request: request, client: self)
    }

    public func send<T>(_ request: Request<T>, pageAfter currentPage: T) async throws -> T? where T: Decodable {
        guard let nextPage = pagedDocumentLinks(currentPage)?.next, let url = URL(string: nextPage) else {
            return nil
        }

        let urlRequest = try URLRequest(url: url, encoder: encoder, authenticator: &authenticator)
        let response = try await transport.send(request: urlRequest, decoder: decoder)
        try response.check()

        return try response.decode(using: decoder)
    }

    private func pagedDocumentLinks<T>(_ object: T) -> PagedDocumentLinks? {
        let mirror = Mirror(reflecting: object)
        return mirror.children.first(where: { $0.value is PagedDocumentLinks })
            .flatMap { $0.value as? PagedDocumentLinks }
    }
}
