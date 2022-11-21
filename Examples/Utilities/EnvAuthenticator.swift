import AppStoreConnect
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// An `Authenticator` that wraps ``Environment`` to configure the `JWT`.
///
/// To use this authenticator, ensure the following environment variables are set either at launch or in a .env file:
///
/// - **ASC_KEY_ID**: The ID for the private key from App Store Connect
/// - **ASC_ISSUER_ID**: The issuer ID from Apple assigned to your App Store Connect team.
/// - **ASC_PRIVATE_KEY_PATH**: A path to the private key file
///
/// Each of these can be overridden as input to the authenticator, if you need it.
public struct EnvAuthenticator: Authenticator {
    /// Error to throw when a mandatory environment variable is missing.
    public enum Error: Swift.Error {
        case missingEnvironmentVariable(String)
    }

    var jwt: JWT

    /// Creates an ``EnvAuthenticator`` using predefined environment names for its internal inputs.
    ///
    /// - Parameters:
    ///   - environmentFile: Path to an environment file. Defaults to a `.env` file in the current directory.
    ///   - keyIDVariableName: The environment variable name to refer to the API private key ID.
    ///   - issuerIDVariableName: The environment variable name to refer to the API issuer ID.
    ///   - privateKeyPathVariableName: The environment variable name to refer to the location of the API private key file.
    ///   - expiryDuration: The time from creation until the token should expire.
    /// - Throws: ``Error`` if there is a missing environment variable, or ``Environment/FileParserError`` if the environment file is malformed.
    public init(
        from environmentFile: URL? = nil,
        keyIDVariableName: String = "ASC_KEY_ID",
        issuerIDVariableName: String = "ASC_ISSUER_ID",
        privateKeyPathVariableName: String = "ASC_PRIVATE_KEY_PATH",
        expiryDuration: TimeInterval = 20 * 60
    ) throws {
        let env = try Environment(contentsOf: environmentFile)

        guard let keyID = env[keyIDVariableName] else {
            throw Error.missingEnvironmentVariable(keyIDVariableName)
        }
        guard let issuerID = env[issuerIDVariableName] else {
            throw Error.missingEnvironmentVariable(issuerIDVariableName)
        }
        guard let privateKeyPath = env[privateKeyPathVariableName] else {
            throw Error.missingEnvironmentVariable(privateKeyPathVariableName)
        }

        let privateKey = try JWT.PrivateKey(contentsOf: URL(fileURLWithPath: privateKeyPath))

        self.jwt = JWT(
            keyID: keyID,
            issuerID: issuerID,
            expiryDuration: 20 * 60,
            privateKey: privateKey
        )
    }

    /// Returns the token to use for authentication with the App Store Connect API.
    /// - Returns: The token to use for authentication.
    /// - Throws: An error if an issue was encountered during token signing.
    public mutating func token() throws -> String {
        try jwt.token()
    }
}
