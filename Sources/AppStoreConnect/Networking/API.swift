import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

/// APIs this client is compatible with. Used by ``AppStoreConnectClient`` and
/// ``Authenticator``s to control the base URL and token payload for requests.
public struct API {
    /// App Store Connect API. Default in most contexts.
    ///
    /// <https://developer.apple.com/documentation/appstoreconnectapi>
    public static let appStoreConnect = Self(
        audience: "appstoreconnect-v1",
        baseURL: URL(string: "https://api.appstoreconnect.apple.com")!
    )

    let audience: String
    let baseURL: URL

    /// An API with information about how it can be reached.
    /// - Parameters:
    ///   - audience: Audience string used with JWT payloads.
    ///   - baseURL: Base URL of requests.
    public init(
        audience: String,
        baseURL: URL
    ) {
        self.audience = audience
        self.baseURL = baseURL
    }
}
