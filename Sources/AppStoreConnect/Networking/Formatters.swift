import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

/// ISO 8601 date formatter with fractional seconds support.
nonisolated(unsafe) let iso8601WithFractionalSecondsFormatter: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)
    return formatter
}()

/// ISO 8601 date formatter with default options.
nonisolated(unsafe) let iso8601Formatter: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    return formatter
}()

/// Helper to encode an ISO 8601 date permissively.
@Sendable
func encodeISO8601Date(_ date: Date, encoder: any Encoder) throws {
    var container = encoder.singleValueContainer()
    let dateString = iso8601WithFractionalSecondsFormatter.string(from: date)
    try container.encode(dateString)
}

/// Helper to decode an ISO 8601 date string permissively.
@Sendable
func decodeISO8601Date(with decoder: any Decoder) throws -> Date {
    let container = try decoder.singleValueContainer()
    let dateString = try container.decode(String.self)
    guard let date = Date(iso8601String: dateString) else {
        throw DecodingError.dataCorrupted(
            DecodingError.Context(
                codingPath: container.codingPath,
                debugDescription: "Expected date string \(dateString) to be ISO8601-formatted."
            )
        )
    }
    return date
}

extension Date {
    /// Helper to decode an ISO 8601 date string permissively.
    init?(
        iso8601String: String
    ) {
        if let date = iso8601WithFractionalSecondsFormatter.date(from: iso8601String) {
            self = date
        } else if let date = iso8601Formatter.date(from: iso8601String) {
            self = date
        } else {
            return nil
        }
    }
}
