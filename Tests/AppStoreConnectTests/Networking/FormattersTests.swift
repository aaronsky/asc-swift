import Foundation
import XCTest

@testable import AppStoreConnect

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class FormattersTests: XCTestCase {
    func testFormatters() {
        // yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX
        XCTAssertNotNil(iso8601WithFractionalSecondsFormatter.date(from: "2022-11-19T12:00:01.111Z"))
        // yyyy-MM-dd'T'HH:mm:ssZZZZZ
        XCTAssertNotNil(iso8601Formatter.date(from: "2022-11-19T12:00:01 -04:00"))
        // yyyy-MM-dd'T'HH:mm:ssXXXXX
        XCTAssertNotNil(iso8601Formatter.date(from: "2022-11-19T12:00:01Z"))
    }

    func testFormattersCodable() throws {
        struct Foo: Codable, Equatable {
            var date: Date
        }

        let expected = Foo(date: Date(timeIntervalSince1970: 1584216283.567))

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .custom(encodeISO8601Date(_:encoder:))
        let data = try encoder.encode(expected)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        let actual = try decoder.decode(Foo.self, from: data)

        XCTAssertEqual(expected, actual)
    }

    func testFormattersCodableError() throws {
        struct Foo: Codable, Equatable {
            var date: Date
        }

        let data = """
            {"date":"invalid"}
            """
            .data(using: .utf8)!

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        XCTAssertThrowsError(try decoder.decode(Foo.self, from: data))
    }
}
