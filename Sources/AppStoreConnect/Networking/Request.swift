import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct Request<Response> {
    static var baseURL: URL {
        return .init(string: "https://api.appstoreconnect.apple.com")!
    }

    public var method: String
    public var url: String
    public var query: [(String, String?)]?
    internal let body: (any Encodable)?
    public var headers: [String: String]?
    public var id: String?

    public init(
        method: String,
        url: String,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil,
        id: String? = nil
    ) {
        self.method = method
        self.url = url
        self.query = query
        self.headers = headers
        self.body = body
        self.id = id
    }
}

extension Request {
    public static func get(
        _ url: String,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "GET", url: url, query: query, headers: headers)
    }

    public static func post(
        _ url: String,
        query: [(String, String?)]? = nil,
        body: Encodable? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "POST", url: url, query: query, body: body, headers: headers)
    }

    public static func put(
        _ url: String,
        query: [(String, String?)]? = nil,
        body: Encodable? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "PUT", url: url, query: query, body: body, headers: headers)
    }

    public static func patch(
        _ url: String,
        query: [(String, String?)]? = nil,
        body: Encodable? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "PATCH", url: url, query: query, body: body, headers: headers)
    }

    public static func delete(
        _ url: String,
        query: [(String, String?)]? = nil,
        body: Encodable? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "DELETE", url: url, query: query, body: body, headers: headers)
    }

    public static func options(
        _ url: String,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "OPTIONS", url: url, query: query, headers: headers)
    }

    public static func head(
        _ url: String,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "HEAD", url: url, query: query, headers: headers)
    }

    public static func trace(
        _ url: String,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "TRACE", url: url, query: query, headers: headers)
    }
}

extension URLRequest {
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
    fileprivate init<Response>(
        request: Request<Response>
    ) throws {
        let url = Request<Response>.baseURL.appendingPathComponent(request.url)
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
