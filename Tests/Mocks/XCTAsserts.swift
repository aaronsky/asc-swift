import Foundation
import XCTest

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

// swift-format-ignore: AlwaysUseLowerCamelCase
public func XCTAssertThrowsError<T>(
    _ expression: @autoclosure @Sendable () async throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line,
    _ errorHandler: @Sendable (_ error: any Error) -> Void = { _ in }
) async {
    do {
        _ = try await expression()
        XCTFail(message(), file: file, line: line)
    } catch {
        errorHandler(error)
    }
}
