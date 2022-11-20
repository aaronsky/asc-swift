import Crypto
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Interface for the authorization provider used by ``AppStoreConnectClient``.
public protocol Authenticator {
    /// Returns the token to use for authentication with the App Store Connect API.
    /// - Returns: The token to use for authentication.
    /// - Throws: An error if an issue was encountered during token signing.
    mutating func token() throws -> String
}

/// An implementation of an ``Authenticator`` that produces JWTs ([JSON Web Tokens](https://jwt.io/)).
/// Uses [swift-crypto](https://github.com/apple/swift-crypto) to assist signing the Apple-provided
/// PKCS#8 private key.
///
/// - SeeAlso: https://developer.apple.com/documentation/appstoreconnectapi/generating_tokens_for_api_requests
public struct JWT: Authenticator {
    /// The header of the token, which contains the token type, signing algorithm, and an ID for the private key provided by Apple.
    struct Header: Codable {
        /// Token type. Should always be `"JWT"`.
        let type: String = "JWT"
        /// Signing algorithm type. Should always be `"ES256"`, unless Apple changes their requirements.
        let algorithm: String = "ES256"
        /// Your private key ID from App Store Connect.
        var key: String

        private enum CodingKeys: String, CodingKey {
            case type = "typ"
            case key = "kid"
            case algorithm = "alg"
        }
    }

    /// Claims about the authenticating user.
    struct Payload: Codable {
        /// Audience of the token. Should always be `"appstoreconnect-v1"`.
        let audience: String = "appstoreconnect-v1"
        /// Your issuer ID from the API Keys page in App Store Connect. Unique to an App Store Connect team.
        var issuer: String
        /// The token’s creation time, in Unix epoch time.
        var issuedAt: TimeInterval?
        /// The token’s expiration time in Unix epoch time.
        ///
        /// Tokens that expire more than 20 minutes into the future are not valid except for resources listed in
        /// [Determine the Appropriate Token Lifetime](https://developer.apple.com/documentation/appstoreconnectapi/generating_tokens_for_api_requests#3878467).
        var expiry: TimeInterval
        /// A list of operations you want App Store Connect to allow for this token.
        ///
        /// - SeeAlso: https://developer.apple.com/documentation/appstoreconnectapi/generating_tokens_for_api_requests#3878466
        var scope: [String]?

        private enum CodingKeys: String, CodingKey {
            case audience = "aud"
            case issuer = "iss"
            case issuedAt = "iat"
            case expiry = "exp"
            case scope
        }
    }

    /// Signing identity used to generate the signature component of the token.
    public struct PrivateKey {
        /// Private key used to sign the digest of the header and payload.
        var key: P256.Signing.PrivateKey

        /// Creates a private key representation from a URL to a PKCS#8 private key.
        /// - Parameter url: URL to the PKCS#8 private key on disk.
        public init(
            contentsOf url: URL
        ) throws {
            let pemRepresentation = try String(contentsOf: url, encoding: .utf8)
            self.key = try P256.Signing.PrivateKey(pemRepresentation: pemRepresentation)
        }

        /// Sign the digest using the private key and base64 encode the result.
        /// - Returns: The signature component of the JWT.
        /// - Throws: An error if the digest data could not be signed with the private key.
        func sign(_ digest: String) throws -> String {
            let signature = try key.signature(for: Data(digest.utf8))

            return String(base64Encode: signature.rawRepresentation)
        }
    }

    enum DecodingError: Error {
        struct Context {
            var debugDescription: String
            var underlyingError: Error?
        }

        ///
        case dataCorrupted(Context)
    }

    /// The token header.
    var header: Header
    /// ID of the App Store Connect team, issued by Apple.
    var issuer: String
    /// The token’s creation time, in Unix epoch time.
    var issuedAt: TimeInterval?
    /// Lifetime of the token, in seconds.
    ///
    /// Tokens that expire more than 20 minutes into the future are not valid except for resources listed in
    /// [Determine the Appropriate Token Lifetime](https://developer.apple.com/documentation/appstoreconnectapi/generating_tokens_for_api_requests#3878467).
    var expiryDuration: TimeInterval
    /// List of operations on App Store Connect that this token should be limited to.
    var scopes: [String]?
    /// The private key.
    var privateKey: PrivateKey
    /// Dependency on the current date. Useful in testing.
    var date: (() -> Date)?
    /// The last token generated.
    private var cachedToken: String?

    /// Create a JWT authenticator for ``AppStoreConnectClient``.
    /// - Parameters:
    ///   - keyID: Private key ID from App Store Connect.
    ///   - issuerID: ID of the App Store Connect team, issued by Apple.
    ///   - issuedAt: Optional timestamp of when the token was issued by Apple, in Unix epoch time.
    ///   - expiryDuration: Lifetime of the token, in seconds. See also [Determine the Appropriate Token Lifetime](https://developer.apple.com/documentation/appstoreconnectapi/generating_tokens_for_api_requests#3878467).
    ///   - scopes: Optional scopes to restrict access to the App Store Connect API to specific endpoints.
    ///   - privateKey: The private key.
    public init(
        keyID: String,
        issuerID: String,
        issuedAt: TimeInterval? = nil,
        expiryDuration: TimeInterval,
        scopes: [String]? = nil,
        privateKey: PrivateKey
    ) {
        self.init(
            keyID: keyID,
            issuerID: issuerID,
            issuedAt: issuedAt,
            expiryDuration: expiryDuration,
            scopes: scopes,
            privateKey: privateKey,
            date: nil
        )
    }

    /// Create a JWT authenticator for ``AppStoreConnectClient``.
    /// - Parameters:
    ///   - keyID: Private key ID from App Store Connect.
    ///   - issuerID: ID of the App Store Connect team, issued by Apple.
    ///   - issuedAt: Optional timestamp of when the token was issued by Apple, in Unix epoch time.
    ///   - expiryDuration: Lifetime of the token, in seconds. See also [Determine the Appropriate Token Lifetime](https://developer.apple.com/documentation/appstoreconnectapi/generating_tokens_for_api_requests#3878467).
    ///   - scopes: Optional scopes to restrict access to the App Store Connect API to specific endpoints.
    ///   - privateKey: The private key.
    ///   - date: Dependency on the current date. Useful in testing.
    init(
        keyID: String,
        issuerID: String,
        issuedAt: TimeInterval? = nil,
        expiryDuration: TimeInterval,
        scopes: [String]? = nil,
        privateKey: PrivateKey,
        date: (() -> Date)?
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
        if let cachedToken = cachedToken, !JWT.isExpired(cachedToken, date: date) {
            return cachedToken
        }

        let newToken = try encode()
        cachedToken = newToken

        return newToken
    }

    /// Construct a token using the digest of the header and payload and the signature of the digest.
    /// - Returns: The constructed JWT.
    /// - Throws: An error encountered during encoding and signing.
    func encode() throws -> String {
        let digest = try self.digest()
        let signature = try privateKey.sign(digest)

        return "\(digest).\(signature)"
    }

    /// A digest of the concatenated header and payload.
    /// - Returns: A string representation of the header and payload, each encoded as JSON strings then base64 URL encoded, then concatenated together.
    /// - Throws: An error encountered during encoding.
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

    /// Check if the given token is expired based on its encoded expiration timestamp. Does not account for illegitimate expiration durations forbidden by the App Store Connect API.
    /// - Parameter token: A constructed JWT.
    /// - Parameter date: Dependency on the current date. Useful in testing.
    /// - Returns: Whether or not the token has expired past its stated duration.
    static func isExpired(_ token: String, date: (() -> Date)?) -> Bool {
        do {
            let (_, payload) = try decode(from: token)
            let expiryDate = Date(timeIntervalSince1970: payload.expiry)

            return expiryDate >= (date?() ?? Date())
        } catch {
            return true // If the token cannot be decoded, we will always treat it as expired.
        }
    }

    /// Decode the header and payload components of a token, and perform no identity validation.
    ///
    /// This method should not be used for verification and should only be used to perform operations, such
    /// as checking for expiration of a token generated by this same client.
    ///
    /// - Parameter token: A signed JWT.
    /// - Returns: The decoded header and payload components of the token.
    /// - Throws: An error describing some malformation of the token.
    static func decode(from token: String) throws -> (Header, Payload) {
        let parts = token.components(separatedBy: ".")
        guard parts.count == 3 else {
            throw DecodingError.dataCorrupted(
                .init(
                    debugDescription: "Invalid part count: expected 3, found \(parts.count)"
                )
            )
        }

        let decoder = JSONDecoder()

        let headerDecoded = try decoder.decode(Header.self, from: Data(String(base64Decode: parts[0]).utf8))
        let payloadDecoded = try decoder.decode(Payload.self, from: Data(String(base64Decode: parts[1]).utf8))

        return (headerDecoded, payloadDecoded)
    }
}

extension String {
    /// Encode the given data as a base64 URL encoded string.
    /// - Parameter data: The data to string-encode.
    init(
        base64Encode data: Data
    ) {
        self = data.base64EncodedString()
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
    }

    /// Decode the given base64 URL encoded string into an unencoded string.
    /// - Parameter string: The string to decode.
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
