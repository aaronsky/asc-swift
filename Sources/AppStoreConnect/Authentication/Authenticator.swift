import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public protocol Authenticator {
    mutating func token() throws -> String
}

public final class JWTAuthenticator: Authenticator {
    private var jwt: JWT
    private var privateKey: Data

    private var cachedToken: String?
    public func token() throws -> String {
        if let cachedToken = cachedToken, !JWT.isExpired(cachedToken) {
            return cachedToken
        }
        let newToken = try jwt.encode(secret: .init(contentsOf: privateKey))
        cachedToken = newToken
        return newToken
    }

    public init(
        keyID: String,
        issuerID: String,
        expiryDuration: TimeInterval,
        privateKey: Data
    ) {
        jwt = JWT(
            keyID: keyID,
            issuerID: issuerID,
            expiryDuration: expiryDuration
        )
        self.privateKey = privateKey
    }
}
