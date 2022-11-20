import Foundation
import _Specification

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

private let appStoreConnectBaseURL = URL(string: "https://api.appstoreconnect.apple.com")!

extension URLRequest {
    /// Creates a ``URLRequest`` out of a ``Request``.
    /// - Parameters:
    ///   - request: A request.
    ///   - encoder: An encoder.
    ///   - authenticator: Authorization provider.
    init<Response>(
        request: Request<Response>,
        encoder: JSONEncoder,
        authenticator: inout Authenticator
    ) throws {
        let url = try URL(request: request)
        try self.init(
            url: url,
            method: request.method,
            body: request.body,
            encoder: encoder,
            authenticator: &authenticator
        )
    }

    /// Creates a ``URLRequest`` out of a ``Request``.
    /// - Parameters:
    ///   - url: Request URL.
    ///   - method: Request method.
    ///   - body: Request body.
    ///   - encoder: An encoder.
    ///   - authenticator: Authorization provider.
    init(
        url: URL,
        method: String? = nil,
        body: (any Encodable)? = nil,
        encoder: JSONEncoder,
        authenticator: inout Authenticator
    ) throws {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method

        if let body = body {
            urlRequest.httpBody = try encoder.encode(body)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        let token = try authenticator.token()
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        self = urlRequest
    }
}

extension URL {
    /// Creates a ``URL`` out of a ``Request``.
    /// - Parameters:
    ///   - request: A request.
    fileprivate init<Response>(
        request: Request<Response>
    ) throws {
        let url = appStoreConnectBaseURL.appendingPathComponent(request.url)

        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }

        if let query = request.query, !query.isEmpty {
            components.queryItems = query.map(URLQueryItem.init)
        }

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        self = url
    }
}
