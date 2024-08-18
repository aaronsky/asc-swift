import AppStoreConnect
import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct MockAuthenticator: Authenticator {
    public var api: API = .appStoreConnect

    public init() {}

    public mutating func token() throws -> String {
        return "TEST"
    }
}
