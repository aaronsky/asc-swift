import Foundation
import XCTest

@testable import AppStoreConnect

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class FormattersTests: XCTestCase {
    func testFormatters() throws {
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

    func testFormatters_DecodeError() throws {
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
