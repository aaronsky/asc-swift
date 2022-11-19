import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Client used to interface with all available App Store Connect APIs. The primary mechanism of this library.
public actor AppStoreConnectClient {
    /// Configuration for general interaction with the App Store Connect API.
    var configuration: Configuration

    /// The network (or whatever) transport layer. Implemented by URLSession by default.
    var transport: Transport

    nonisolated var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .custom(Formatters.encodeISO8601)
        return encoder
    }

    nonisolated var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(Formatters.decodeISO8601)
        return decoder
    }

    /// Creates a session with the specified configuration, and transport layer.
    /// - Parameters:
    ///   - configuration: Configures supported API versions and the access token. Uses the latest supported API versions by default.
    ///   - transport: Transport layer used for API communication. Uses the shared URLSession by default.
    public init(
        configuration: Configuration = .init(),
        transport: Transport = URLSession.shared
    ) {
        self.configuration = configuration
        self.transport = transport
    }
}
