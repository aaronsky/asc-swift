import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

/// Helper to encode an ISO 8601 date permissively.
@Sendable
func encodeISO8601Date(_ date: Date, encoder: any Encoder) throws {
    var container = encoder.singleValueContainer()
    #if swift(>=6.0)
        let dateString = date.formatted(
            .iso8601
                .year()
                .month()
                .day()
                .dateSeparator(.dash)
                .time(includingFractionalSeconds: true)
                .timeSeparator(.colon)
                .dateTimeSeparator(.standard)
        )
    #else
        let dateString = iso8601WithFractionalSecondsFormatter.string(from: date)
    #endif
    try container.encode(dateString)
}

/// Helper to decode an ISO 8601 date string permissively.
@Sendable
func decodeISO8601Date(with decoder: any Decoder) throws -> Date {
    let container = try decoder.singleValueContainer()
    let dateString = try container.decode(String.self)

    #if swift(>=6.0)
        if let date = try? Date(
            dateString,
            strategy: .iso8601
                .year()
                .month()
                .day()
                .dateSeparator(.dash)
                .time(includingFractionalSeconds: true)
                .timeSeparator(.colon)
                .dateTimeSeparator(.standard)
        ) {
            return date
        } else if let date = try? Date(dateString, strategy: .iso8601) {
            return date
        } else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Expected date string \(dateString) to be ISO8601-formatted."
                )
            )
        }
    #else
        guard
            let date = Date(
                iso8601String: dateString,
                formatter: iso8601Formatter,
                withFractionalSeconds: iso8601WithFractionalSecondsFormatter
            )
        else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Expected date string \(dateString) to be ISO8601-formatted."
                )
            )
        }
        return date
    #endif
}

#if swift(<6.0)
    /// ISO 8601 date formatter with default options.
    let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        return formatter
    }()

    /// ISO 8601 date formatter with fractional seconds support.
    let iso8601WithFractionalSecondsFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withFractionalSeconds)
        return formatter
    }()

    extension Date {
        /// Helper to decode an ISO 8601 date string permissively.
        init?(
            iso8601String: String,
            formatter: ISO8601DateFormatter,
            withFractionalSeconds fractionalSecondsFormatter: ISO8601DateFormatter
        ) {
            if let date = fractionalSecondsFormatter.date(from: iso8601String) {
                self = date
            } else if let date = formatter.date(from: iso8601String) {
                self = date
            } else {
                return nil
            }
        }
    }
#endif
