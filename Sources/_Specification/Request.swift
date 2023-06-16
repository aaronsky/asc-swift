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
    ///   - path: Path to the resource.
    ///   - method: HTTP method.
    ///   - baseURL: Base URL of the resource. A nil value will result in a default of `"https://api.appstoreconnect.apple.com"`.
    ///   - query: Query string encoded parameters.
    ///   - body: Body of the request.
    ///   - headers: Request headers.
    ///   - id: Operation ID. Unused.
    public init(
        path: String,
        method: String,
        baseURL: URL? = nil,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil,
        id: String? = nil
    ) {
        self.path = path
        self.method = method
        self.baseURL = baseURL ?? appStoreConnectBaseURL
        self.query = query
        self.body = body
        self.headers = headers
        self.id = id
    }
}
