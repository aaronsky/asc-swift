import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// A request model used to describe a resource's attributes.
public struct Request<Response> {
    /// HTTP method.
    public var method: String
    /// URL path to the resource. Base URL (hostname, scheme and port) must be provided separately.
    public var url: String
    /// Query string encoded parameters.
    public var query: [(String, String?)]?
    /// Body of the request
    public var body: (any Encodable)?
    /// Request headers.
    public var headers: [String: String]?
    /// Operation ID. Not used by the library, but required by the generated paths.
    public var id: String?

    /// Create a Request model
    /// - Parameters:
    ///   - method: HTTP method.
    ///   - url: Path to the resource. No base URL should be provided to this initializer.
    ///   - query: Query string encoded parameters.
    ///   - body: Body of the request.
    ///   - headers: Request headers.
    ///   - id: Operation ID. Unused.
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
        self.body = body
        self.headers = headers
        self.id = id
    }
}

extension Request {
    /// Construct a "GET" request.
    /// - Parameters:
    ///   - url: Path to the resource. No base URL should be provided to this method.
    ///   - query: Query string encoded parameters.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func get(
        _ url: String,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "GET", url: url, query: query, headers: headers)
    }

    /// Construct a "POST" request.
    /// - Parameters:
    ///   - url: Path to the resource. No base URL should be provided to this method.
    ///   - query: Query string encoded parameters.
    ///   - body: Body of the request.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func post(
        _ url: String,
        query: [(String, String?)]? = nil,
        body: Encodable? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "POST", url: url, query: query, body: body, headers: headers)
    }

    /// Construct a "PUT" request.
    /// - Parameters:
    ///   - url: Path to the resource. No base URL should be provided to this method.
    ///   - query: Query string encoded parameters.
    ///   - body: Body of the request.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func put(
        _ url: String,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "PUT", url: url, query: query, body: body, headers: headers)
    }

    /// Construct a "PATCH" request.
    /// - Parameters:
    ///   - url: Path to the resource. No base URL should be provided to this method.
    ///   - query: Query string encoded parameters.
    ///   - body: Body of the request.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func patch(
        _ url: String,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "PATCH", url: url, query: query, body: body, headers: headers)
    }

    /// Construct a "DELETE" request.
    /// - Parameters:
    ///   - url: Path to the resource. No base URL should be provided to this method.
    ///   - query: Query string encoded parameters.
    ///   - body: Body of the request.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func delete(
        _ url: String,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "DELETE", url: url, query: query, body: body, headers: headers)
    }

    /// Construct a "OPTIONS" request.
    /// - Parameters:
    ///   - url: Path to the resource. No base URL should be provided to this method.
    ///   - query: Query string encoded parameters.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func options(
        _ url: String,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "OPTIONS", url: url, query: query, headers: headers)
    }

    /// Construct a "HEAD" request.
    /// - Parameters:
    ///   - url: Path to the resource. No base URL should be provided to this method.
    ///   - query: Query string encoded parameters.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func head(
        _ url: String,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "HEAD", url: url, query: query, headers: headers)
    }

    /// Construct a "TRACE" request.
    /// - Parameters:
    ///   - url: Path to the resource. No base URL should be provided to this method.
    ///   - query: Query string encoded parameters.
    ///   - headers: Request headers.
    /// - Returns: The request.
    public static func trace(
        _ url: String,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "TRACE", url: url, query: query, headers: headers)
    }
}
