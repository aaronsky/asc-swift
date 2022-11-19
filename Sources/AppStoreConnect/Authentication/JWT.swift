import Crypto
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public protocol Authenticator {
    mutating func token() throws -> String
}

public struct JWT: Authenticator {
    struct Header: Codable {
        let type: String = "JWT"
        let algorithm: String = "ES256"
        var key: String

        private enum CodingKeys: String, CodingKey {
            case type = "typ"
            case key = "kid"
            case algorithm = "alg"
        }
    }

    struct Payload: Codable {
        let audience: String = "appstoreconnect-v1"
        var issuer: String
        var issuedAt: TimeInterval?
        var expiry: TimeInterval
        var scope: [String]?

        private enum CodingKeys: String, CodingKey {
            case audience = "aud"
            case issuer = "iss"
            case issuedAt = "iat"
            case expiry = "exp"
            case scope
        }
    }

    struct PrivateKey {
        var data: Data

        init(
            _ data: Data
        ) {
            self.data = data
        }

        func sign(_ digest: String) throws -> String {
            let signature = HMAC<SHA256>
                .authenticationCode(
                    for: Data(digest.utf8),
                    using: SymmetricKey(data: data)
                )
            return String(base64Encode: Data(signature))
        }
    }

    var header: Header
    var issuer: String
    var issuedAt: TimeInterval?
    var expiryDuration: TimeInterval
    var scopes: [String]?
    var privateKey: PrivateKey

    private var cachedToken: String?

    public init(
        keyID: String,
        issuerID: String,
        issuedAt: TimeInterval? = nil,
        expiryDuration: TimeInterval,
        scopes: [String]? = nil,
        privateKey: Data
    ) {
        self.header = Header(key: keyID)
        self.issuer = issuerID
        self.issuedAt = issuedAt
        self.expiryDuration = expiryDuration
        self.scopes = scopes
        self.privateKey = PrivateKey(privateKey)
    }

    public mutating func token() throws -> String {
        try token(now: Date.init)
    }

    public mutating func token(now: () -> Date) throws -> String {
        if let cachedToken = cachedToken, !JWT.isExpired(cachedToken) {
            return cachedToken
        }

        let newToken = try encode(now: now)
        cachedToken = newToken
        print(newToken)

        return newToken
    }

    func encode(now: () -> Date) throws -> String {
        let digest = try self.digest(now: now)
        let signature = try privateKey.sign(digest)

        return "\(digest).\(signature)"
    }

    func digest(now: () -> Date) throws -> String {
        let payload = Payload(
            issuer: issuer,
            issuedAt: issuedAt,
            expiry: now().addingTimeInterval(expiryDuration).timeIntervalSince1970,
            scope: scopes
        )

        let encoder = JSONEncoder()
        let headerEncoded = try String(base64Encode: encoder.encode(header))
        let payloadEncoded = try String(base64Encode: encoder.encode(payload))
        let digest = "\(headerEncoded).\(payloadEncoded)"

        return digest
    }

    static func isExpired(_ token: String) -> Bool {
        true  // TODO: stub
    }
}

extension String {
    init(
        base64Encode data: Data
    ) {
        self = data.base64EncodedString()
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
    }

    init(
        base64Decode string: String
    ) {
        var base64 =
            string
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        if base64.count % 4 != 0 {
            base64.append(String(repeating: "=", count: 4 - base64.count % 4))
        }

        self = base64
    }
}
