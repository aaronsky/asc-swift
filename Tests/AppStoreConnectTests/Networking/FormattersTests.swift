import Foundation
import XCTest

@testable import AppStoreConnect

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class FormattersTests: XCTestCase {
    func testFormatters() {
        XCTAssertNotNil(Formatters.iso8601WithFractionalSeconds.date(from: "2022-11-19T12:00:01.111Z")) // yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX
        XCTAssertNotNil(Formatters.iso8601.date(from: "2022-11-19T12:00:01 -04:00"))                    // yyyy-MM-dd'T'HH:mm:ssZZZZZ
        XCTAssertNotNil(Formatters.iso8601.date(from: "2022-11-19T12:00:01Z"))                          // yyyy-MM-dd'T'HH:mm:ssXXXXX
    }

    func testFormattersCodable() throws {
        struct Foo: Codable, Equatable {
            var date: Date
        }

        let expected = Foo(date: Date(timeIntervalSince1970: 1584216283.567))

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .custom(Formatters.encodeISO8601)
        let data = try encoder.encode(expected)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(Formatters.decodeISO8601)
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
        decoder.dateDecodingStrategy = .custom(Formatters.decodeISO8601)
        XCTAssertThrowsError(try decoder.decode(Foo.self, from: data))
    }
}
