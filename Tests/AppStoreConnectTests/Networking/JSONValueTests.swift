import Foundation
import XCTest

@testable import AppStoreConnect

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class JSONValueTests: XCTestCase {
    func testDecodeArray() throws {
        let json = """
            { "fooKey": [true, 1] }
            """
        let expected = JSONValue.object(["fooKey": .array([.bool(true), .number(1)])])
        try decodingTest(json, expected)
    }

    func testDecodeBool() throws {
        let json = """
            { "fooKey": true }
            """
        let expected = JSONValue.object(["fooKey": .bool(true)])
        try decodingTest(json, expected)
    }

    func testDecodeDouble() throws {
        let json = """
            { "fooKey": 1.2345 }
            """
        let expected = JSONValue.object(["fooKey": .number(1.2345)])
        try decodingTest(json, expected)
    }

    func testDecodeNull() throws {
        let json = """
            { "fooKey": null }
            """
        let expected = JSONValue.object(["fooKey": .null])
        try decodingTest(json, expected)
    }

    func testDecodeString() throws {
        let json = """
            { "fooKey": "fooVal" }
            """
        let expected = JSONValue.object(["fooKey": .string("fooVal")])
        let data = try XCTUnwrap(json.data(using: .utf8))
        let actual = try JSONDecoder().decode(JSONValue.self, from: data)
        XCTAssertEqual(expected, actual)
    }

    private func decodingTest(_ input: String, _ expected: JSONValue) throws {
        let data = try XCTUnwrap(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(JSONValue.self, from: data)
        XCTAssertEqual(expected, actual)
    }

    func testArrayRoundTrip() throws {
        try roundTripTest(.object(["foo": .array([.bool(true), .number(1)])]))
    }

    func testBoolRoundTrip() throws {
        try roundTripTest(.object(["foo": .bool(true)]))
    }

    func testDoubleRoundTrip() throws {
        try roundTripTest(.object(["foo": .number(1.2345)]))
    }

    func testNullRoundTrip() throws {
        try roundTripTest(.object(["foo": .null]))
    }

    func testStringRoundTrip() throws {
        try roundTripTest(.object(["foo": .string("fooVal")]))
    }

    func testComplexObjectRoundTrip() throws {
        try roundTripTest([
            "foo": "fooVal",
            "bar": nil,
            "baz": [
                nil,
                123,
                [
                    "abc": false,
                    "qqq": [:],
                ],

            ],
            "qux": [
                "1": nil,
                "2": "2",
                "3": 33333333.0,
            ],
        ])
    }

    func testLetsNestSomeObjectsLikeCrazyRoundTrip() throws {
        try roundTripTest(.object(["foo": .object(["bar": .object(["baz": .object(["qux": .null])])])]))
    }

    private func roundTripTest(_ expected: JSONValue) throws {
        let actual = try JSONDecoder().decode(JSONValue.self, from: JSONEncoder().encode(expected))
        XCTAssertEqual(expected, actual)
    }

    func testSubscripts() throws {
        let abcs: JSONValue = ["a", "b", "c"]
        let oneTwoThrees: JSONValue = ["1": 1, "2": 2, "3": 3]
        let expected: JSONValue = ["foo": ["bar": false, "baz": abcs, "qux": oneTwoThrees]]

        XCTAssertNil(expected[expected])
        XCTAssertNil(expected[abcs])
        XCTAssertNil(expected[false])
        XCTAssertNil(expected[1])

        XCTAssertNil(abcs["0"])
        XCTAssertNotNil(abcs[0])
        XCTAssertEqual(abcs[1], abcs[.number(1)])

        XCTAssertNil(oneTwoThrees[1])
        XCTAssertNotNil(oneTwoThrees["1"])
        XCTAssertEqual(oneTwoThrees["1"], oneTwoThrees[.string("1")])

        XCTAssertEqual(expected.foo, expected["foo"])
        XCTAssertEqual(expected.foo?.bar, false)
        XCTAssertEqual(expected.foo?.baz, abcs)
        XCTAssertEqual(expected.foo?.qux, oneTwoThrees)

    }
}
