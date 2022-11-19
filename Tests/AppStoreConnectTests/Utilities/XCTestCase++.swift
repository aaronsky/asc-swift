import Foundation
import XCTest

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

// swift-format-ignore: AlwaysUseLowerCamelCase
func XCTAssertThrowsError<T, E: Equatable & Error>(
    _ expression: @autoclosure () throws -> T,
    error: @autoclosure () -> E,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) {
    try XCTAssertThrowsError(
        expression(),
        message(),
        file: file,
        line: line
    ) { thrown in
        XCTAssertEqual(thrown as? E, error(), file: file, line: line)
    }
}

// swift-format-ignore: AlwaysUseLowerCamelCase
func XCTAssertThrowsError<T>(
    _ expression: @autoclosure () async throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line,
    _ errorHandler: (_ error: Error) -> Void = { _ in }
) async {
    do {
        _ = try await expression()
        XCTFail(message(), file: file, line: line)
    } catch {
        errorHandler(error)
    }
}

// swift-format-ignore: AlwaysUseLowerCamelCase
func XCTAssertThrowsError<T, E: Equatable & Error>(
    _ expression: @autoclosure () async throws -> T,
    error: @autoclosure () -> E,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) async {
    try await XCTAssertThrowsError(
        await expression(),
        message(),
        file: file,
        line: line
    ) { thrown in
        XCTAssertEqual(thrown as? E, error(), file: file, line: line)
    }
}
