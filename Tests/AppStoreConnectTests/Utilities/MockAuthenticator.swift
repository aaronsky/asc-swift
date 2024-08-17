import AppStoreConnect
import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

final class MockAuthenticator: Authenticator {
    var api: API = .appStoreConnect

    func token() throws -> String {
        return "TEST"
    }
}
