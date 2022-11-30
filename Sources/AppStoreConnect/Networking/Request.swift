import Foundation
import _Specification

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
    init<Response>(
        request: Request<Response>,
        encoder: JSONEncoder,
        authenticator: inout any Authenticator
    ) throws {
        let url = try URL(request: request)
        try self.init(
            url: url,
            method: request.method,
            headers: request.headers?.map { ($0.key, $0.value) } ?? [],
            body: request.body,
            encoder: encoder,
            authenticator: &authenticator
        )
    }

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

    /// Creates a ``URLRequest`` out of a ``Request``.
    /// - Parameters:
    ///   - url: Request URL.
    ///   - method: Request method.
    ///   - headers: Request headers.
    ///   - body: Request body.
    ///   - encoder: An encoder.
    ///   - authenticator: Authorization provider.
    /// - Throws: An error if there is a problem retrieving an authentication token.
    init(
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
    /// - Parameter request: A request.
    /// - Throws: An error if the URL could not be constructed out of the path
    ///           or queries declared in the request.
    init<Response>(
        request: Request<Response>
    ) throws {
        let url = request.baseURL.appendingPathComponent(request.path)

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

extension Request {
    /// Construct a "GET" request.
    ///
    /// - Parameters:
    ///   - path: Path to the resource.
    ///   - baseURL: Base URL of the resource.
    ///   - query: Query string encoded parameters.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func get(
        _ path: String,
        baseURL: URL? = nil,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: path, baseURL: baseURL, method: "GET", query: query, headers: headers)
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
        baseURL: URL? = nil,
        query: [(String, String?)]? = nil,
        body: Encodable? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: path, baseURL: baseURL, method: "POST", query: query, body: body, headers: headers)
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
        baseURL: URL? = nil,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: path, baseURL: baseURL, method: "PUT", query: query, body: body, headers: headers)
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
        baseURL: URL? = nil,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: path, baseURL: baseURL, method: "PATCH", query: query, body: body, headers: headers)
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
        baseURL: URL? = nil,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: path, baseURL: baseURL, method: "DELETE", query: query, body: body, headers: headers)
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
        baseURL: URL? = nil,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(path: path, baseURL: baseURL, method: "OPTIONS", query: query, headers: headers)
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
        .init(path: path, baseURL: baseURL, method: "HEAD", query: query, headers: headers)
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
        .init(path: path, baseURL: baseURL, method: "TRACE", query: query, headers: headers)
    }
}

extension Request {
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
        body: Encodable? = nil,
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
