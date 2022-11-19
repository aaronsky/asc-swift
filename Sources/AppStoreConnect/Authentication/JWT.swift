import Crypto
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct JWT {
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
        var expiry: TimeInterval

        private enum CodingKeys: String, CodingKey {
            case audience = "aud"
            case issuer = "iss"
            case expiry = "exp"
        }
    }

    struct PrivateKey {
        var data: Data

        init(
            contentsOf data: Data
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
    var expiryDuration: TimeInterval

    public init(
        keyID: String,
        issuerID: String,
        expiryDuration: TimeInterval
    ) {
        self.header = Header(key: keyID)
        self.issuer = issuerID
        self.expiryDuration = expiryDuration
    }

    func encode(secret: PrivateKey, date: () -> Date = Date.init) throws -> String {
        let payload = Payload(
            issuer: issuer,
            expiry: date().addingTimeInterval(expiryDuration).timeIntervalSince1970
        )

        let encoder = JSONEncoder()
        let headerEncoded = try String(base64Encode: encoder.encode(header))
        let payloadEncoded = try String(base64Encode: encoder.encode(payload))
        let digest = "\(headerEncoded).\(payloadEncoded)"

        let signature = try secret.sign(digest)

        return "\(digest).\(signature)"
    }

    static func isExpired(_ token: String) -> Bool {
        true
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
