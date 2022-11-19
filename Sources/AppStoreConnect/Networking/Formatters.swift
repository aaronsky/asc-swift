import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

enum Formatters {
    static let iso8601WithFractionalSeconds: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withFractionalSeconds)
        return formatter
    }()
    static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        return formatter
    }()
    @Sendable
    static func encodeISO8601(date: Date, encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let dateString = iso8601WithFractionalSeconds.string(from: date)
        try container.encode(dateString)
    }

    @Sendable
    static func decodeISO8601(decoder: Decoder) throws -> Date {
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
}

extension Date {
    init?(
        iso8601String: String
    ) {
        if let date = Formatters.iso8601WithFractionalSeconds.date(from: iso8601String) {
            self = date
        } else if let date = Formatters.iso8601.date(from: iso8601String) {
            self = date
        } else if let date = Formatters.iso8601.date(from: iso8601String) {
            self = date
        } else {
            return nil
        }
    }
}
