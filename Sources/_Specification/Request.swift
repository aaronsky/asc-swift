import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

private let appStoreConnectBaseURL = URL(string: "https://api.appstoreconnect.apple.com")!

/// A request model used to describe a resource's attributes.
public struct Request<Response> {
    /// Path to the resource.
    public var path: String
    /// Base URL that the request should be based on.
    public var baseURL: URL = appStoreConnectBaseURL
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
    ///   - baseURL: Base URL of the resource. A nil value will result in a default of `"https://api.appstoreconnect.apple.com"`.
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
        self.baseURL = baseURL ?? appStoreConnectBaseURL
        self.method = method
        self.query = query
        self.body = body
        self.headers = headers
        self.id = id
    }
}
