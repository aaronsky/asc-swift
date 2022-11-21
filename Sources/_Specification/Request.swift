import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

private let appStoreConnectBaseURL = URL(string: "https://api.appstoreconnect.apple.com")!

/// A request model used to describe a resource's attributes.
public struct Request<Response> {
    /// HTTP method.
    public var method: String
    /// Base URL that the request should be based on.
    public var baseURL: URL = appStoreConnectBaseURL
    /// Path to the resource.
    public var path: String
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
    ///   - method: HTTP method.
    ///   - url: Path to the resource.
    ///   - baseURL: Base URL of the resource. A nil value will result in a default of `"https://api.appstoreconnect.apple.com"`.
    ///   - query: Query string encoded parameters.
    ///   - body: Body of the request.
    ///   - headers: Request headers.
    ///   - id: Operation ID. Unused.
    public init(
        method: String,
        url: String,
        baseURL: URL? = nil,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil,
        id: String? = nil
    ) {
        self.method = method
        self.path = url
        self.baseURL = baseURL ?? appStoreConnectBaseURL
        self.query = query
        self.body = body
        self.headers = headers
        self.id = id
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
        .init(method: "GET", url: path, baseURL: baseURL, query: query, headers: headers)
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
        .init(method: "POST", url: path, baseURL: baseURL, query: query, body: body, headers: headers)
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
        .init(method: "PUT", url: path, baseURL: baseURL, query: query, body: body, headers: headers)
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
        .init(method: "PATCH", url: path, baseURL: baseURL, query: query, body: body, headers: headers)
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
        .init(method: "DELETE", url: path, baseURL: baseURL, query: query, body: body, headers: headers)
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
        .init(method: "OPTIONS", url: path, baseURL: baseURL, query: query, headers: headers)
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
        .init(method: "HEAD", url: path, baseURL: baseURL, query: query, headers: headers)
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
        .init(method: "TRACE", url: path, baseURL: baseURL, query: query, headers: headers)
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
        .init(method: "GET", url: "", baseURL: url, query: query, headers: headers)
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
        .init(method: "POST", url: "", baseURL: url, query: query, body: body, headers: headers)
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
        .init(method: "PUT", url: "", baseURL: url, query: query, body: body, headers: headers)
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
        .init(method: "PATCH", url: "", baseURL: url, query: query, body: body, headers: headers)
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
        .init(method: "DELETE", url: "", baseURL: url, query: query, body: body, headers: headers)
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
        .init(method: "OPTIONS", url: "", baseURL: url, query: query, headers: headers)
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
        .init(method: "HEAD", url: "", baseURL: url, query: query, headers: headers)
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
        .init(method: "TRACE", url: "", baseURL: url, query: query, headers: headers)
    }
}
