import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

extension URLRequest {
    /// Creates a ``URLRequest`` out of a ``Request``.
    /// - Parameters:
    ///   - request: A request.
    ///   - encoder: An encoder.
    ///   - authenticator: Authorization provider.
    /// - Throws: An error if the URL constructed from the request is invalid
    ///           or if there is a problem retrieving an authentication token.
    public init<Response>(
        request: Request<Response>,
        encoder: JSONEncoder,
        authenticator: inout any Authenticator
    ) throws {
        let url = try URL(request: request, api: authenticator.api)
        try self.init(
            url: url,
            method: request.method,
            headers: request.headers?.map { ($0.key, $0.value) } ?? [],
            body: request.body,
            encoder: encoder,
            authenticator: &authenticator
        )
    }

    /// Creates a ``URLRequest`` out of a ``Request``.
    /// - Parameters:
    ///   - url: Request URL.
    ///   - method: Request method.
    ///   - headers: Request headers.
    ///   - body: Request body.
    ///   - encoder: An encoder.
    ///   - authenticator: Authorization provider.
    /// - Throws: An error if there is a problem retrieving an authentication token.
    public init(
        url: URL,
        method: String? = nil,
        headers: [(String, String?)] = [],
        body: (any Encodable)? = nil,
        encoder: JSONEncoder,
        authenticator: inout any Authenticator
    ) throws {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method

        for header in headers {
            urlRequest.setValue(header.1, forHTTPHeaderField: header.0)
        }

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
    ///   - api: API this request is designed around.
    /// - Throws: An error if the URL could not be constructed out of the path
    ///           or queries declared in the request.
    init<Response>(
        request: Request<Response>,
        api: API
    ) throws {
        let baseURL = request.baseURL ?? api.baseURL
        let url = baseURL.appendingPathComponent(request.path)

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

/// A request model used to describe a resource's attributes.
public struct Request<Response> {
    /// Path to the resource.
    public var path: String
    /// Base URL that the request should be based on.
    public var baseURL: URL?
    /// HTTP method.
    public var method: String
    /// Query string encoded parameters.
    public var query: [(String, String?)]?
    /// Body of the request.
    public var body: (any Encodable)?
    /// Request headers.
    public var headers: [String: String]?
    /// Operation ID.
    ///
    /// Not used by the library, but required by the generated paths.
    public var id: String?

    /// Create a Request model.
    ///
    /// - Parameters:
    ///   - path: Path to the resource.
    ///   - method: HTTP method.
    ///   - query: Query string encoded parameters.
    ///   - body: Body of the request.
    ///   - headers: Request headers.
    ///   - id: Operation ID. Unused.
    public init(
        path: String,
        baseURL: URL? = nil,
        method: String,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil,
        id: String? = nil
    ) {
        self.path = path
        self.baseURL = baseURL
        self.method = method
        self.query = query
        self.body = body
        self.headers = headers
        self.id = id
    }

    /// Construct a "GET" request.
    ///
    /// - Parameters:
    ///   - path: Path to the resource.
    ///   - query: Query string encoded parameters.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func get(
        _ path: String,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: path, method: "GET", query: query, headers: headers)
    }

    /// Construct a "POST" request.
    ///
    /// - Parameters:
    ///   - path: Path to the resource.
    ///   - baseURL: Base URL of the resource.
    ///   - query: Query string encoded parameters.
    ///   - body: Body of the request.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func post(
        _ path: String,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: path, method: "POST", query: query, body: body, headers: headers)
    }

    /// Construct a "PUT" request.
    ///
    /// - Parameters:
    ///   - path: Path to the resource.
    ///   - baseURL: Base URL of the resource.
    ///   - query: Query string encoded parameters.
    ///   - body: Body of the request.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func put(
        _ path: String,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: path, method: "PUT", query: query, body: body, headers: headers)
    }

    /// Construct a "PATCH" request.
    ///
    /// - Parameters:
    ///   - path: Path to the resource.
    ///   - baseURL: Base URL of the resource.
    ///   - query: Query string encoded parameters.
    ///   - body: Body of the request.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func patch(
        _ path: String,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: path, method: "PATCH", query: query, body: body, headers: headers)
    }

    /// Construct a "DELETE" request.
    ///
    /// - Parameters:
    ///   - path: Path to the resource.
    ///   - baseURL: Base URL of the resource.
    ///   - query: Query string encoded parameters.
    ///   - body: Body of the request.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func delete(
        _ path: String,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: path, method: "DELETE", query: query, body: body, headers: headers)
    }

    /// Construct a "OPTIONS" request.
    ///
    /// - Parameters:
    ///   - path: Path to the resource.
    ///   - baseURL: Base URL of the resource.
    ///   - query: Query string encoded parameters.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func options(
        _ path: String,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: path, method: "OPTIONS", query: query, headers: headers)
    }

    /// Construct a "HEAD" request.
    ///
    /// - Parameters:
    ///   - path: Path to the resource.
    ///   - baseURL: Base URL of the resource.
    ///   - query: Query string encoded parameters.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func head(
        _ path: String,
        baseURL: URL? = nil,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: path, method: "HEAD", query: query, headers: headers)
    }

    /// Construct a "TRACE" request.
    ///
    /// - Parameters:
    ///   - path: Path to the resource.
    ///   - baseURL: Base URL of the resource.
    ///   - query: Query string encoded parameters.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func trace(
        _ path: String,
        baseURL: URL? = nil,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: path, method: "TRACE", query: query, headers: headers)
    }

    /// Construct a "GET" request.
    ///
    /// - Parameters:
    ///   - url: Fully qualified URL to the resource.
    ///   - query: Query string encoded parameters.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func get(
        _ url: URL,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: "", baseURL: url, method: "GET", query: query, headers: headers)
    }

    /// Construct a "POST" request.
    ///
    /// - Parameters:
    ///   - url: Fully qualified URL to the resource.
    ///   - query: Query string encoded parameters.
    ///   - body: Body of the request.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func post(
        _ url: URL,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: "", baseURL: url, method: "POST", query: query, body: body, headers: headers)
    }

    /// Construct a "PUT" request.
    ///
    /// - Parameters:
    ///   - url: Fully qualified URL to the resource.
    ///   - query: Query string encoded parameters.
    ///   - body: Body of the request.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func put(
        _ url: URL,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: "", baseURL: url, method: "PUT", query: query, body: body, headers: headers)
    }

    /// Construct a "PATCH" request.
    ///
    /// - Parameters:
    ///   - url: Fully qualified URL to the resource.
    ///   - query: Query string encoded parameters.
    ///   - body: Body of the request.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func patch(
        _ url: URL,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: "", baseURL: url, method: "PATCH", query: query, body: body, headers: headers)
    }

    /// Construct a "DELETE" request.
    ///
    /// - Parameters:
    ///   - url: Fully qualified URL to the resource.
    ///   - query: Query string encoded parameters.
    ///   - body: Body of the request.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func delete(
        _ url: URL,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: "", baseURL: url, method: "DELETE", query: query, body: body, headers: headers)
    }

    /// Construct a "OPTIONS" request.
    ///
    /// - Parameters:
    ///   - url: Fully qualified URL to the resource.
    ///   - query: Query string encoded parameters.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func options(
        _ url: URL,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: "", baseURL: url, method: "OPTIONS", query: query, headers: headers)
    }

    /// Construct a "HEAD" request.
    ///
    /// - Parameters:
    ///   - url: Fully qualified URL to the resource.
    ///   - query: Query string encoded parameters.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func head(
        _ url: URL,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: "", baseURL: url, method: "HEAD", query: query, headers: headers)
    }

    /// Construct a "TRACE" request.
    ///
    /// - Parameters:
    ///   - url: Fully qualified URL to the resource.
    ///   - query: Query string encoded parameters.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func trace(
        _ url: URL,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: "", baseURL: url, method: "TRACE", query: query, headers: headers)
    }
}
