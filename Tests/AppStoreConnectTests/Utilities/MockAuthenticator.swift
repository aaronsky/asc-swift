import AppStoreConnect
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class MockAuthenticator: Authenticator {
    func token() throws -> String {
        return "TEST"
    }
}
