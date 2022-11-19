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

    public struct PrivateKey {
        var key: P256.Signing.PrivateKey

        public init(
            contentsOf url: URL
        ) throws {
            let pemRepresentation = try String(contentsOf: url, encoding: .utf8)
            self.key = try P256.Signing.PrivateKey(pemRepresentation: pemRepresentation)
        }

        func sign(_ digest: String) throws -> String {
            let signature = try key.signature(for: Data(digest.utf8))

            return String(base64Encode: signature.rawRepresentation)
        }
    }

    var header: Header
    var issuer: String
    var issuedAt: TimeInterval?
    var expiryDuration: TimeInterval
    var scopes: [String]?
    var privateKey: PrivateKey
    var date: (() -> Date)?

    private var cachedToken: String?

    public init(
        keyID: String,
        issuerID: String,
        issuedAt: TimeInterval? = nil,
        expiryDuration: TimeInterval,
        scopes: [String]? = nil,
        privateKey: PrivateKey,
        date: (() -> Date)? = nil
    ) {
        self.header = Header(key: keyID)
        self.issuer = issuerID
        self.issuedAt = issuedAt
        self.expiryDuration = expiryDuration
        self.scopes = scopes
        self.privateKey = privateKey
        self.date = date
    }

    public mutating func token() throws -> String {
        if let cachedToken = cachedToken, !JWT.isExpired(cachedToken) {
            return cachedToken
        }

        let newToken = try encode()
        cachedToken = newToken

        return newToken
    }

    func encode() throws -> String {
        let digest = try self.digest()
        let signature = try privateKey.sign(digest)

        return "\(digest).\(signature)"
    }

    func digest() throws -> String {
        let now = date?() ?? Date()
        let payload = Payload(
            issuer: issuer,
            issuedAt: issuedAt,
            expiry: now.addingTimeInterval(expiryDuration).timeIntervalSince1970,
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
