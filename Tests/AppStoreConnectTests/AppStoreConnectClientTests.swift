import Foundation
import Mocks
import XCTest

@testable import AppStoreConnect

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class AppStoreConnectClientTests: XCTestCase {
    private struct TestData: Sendable {
        enum Case {
            case success
            case successPaginated
            case successNoContent
            case successDownload
            case badResponse
            case unsuccessfulResponse
            case noData
            case serverError
        }

        var context: MockContext
        var resources = MockResources()

        init(
            testCase: Case
        ) throws {
            switch testCase {
            case .success:
                context = try MockContext(content: resources.content)
            case .successPaginated:
                context = try MockContext(
                    content: resources.pagedContentFirst,
                    resources.pagedContentNext,
                    resources.pagedContentLast
                )
            case .successNoContent:
                context = MockContext()
            case .successDownload:
                context = MockContext(responses: [
                    .fileURL(MockData.mockingSuccessDownload(to: resources.downloadURL))
                ])
            case .badResponse:
                context = MockContext(responses: [
                    .data(MockData.mockingIncompatibleResponse())
                ])
            case .unsuccessfulResponse:
                context = MockContext(responses: [
                    .data(MockData.mockingUnsuccessfulResponse())
                ])
            case .noData:
                context = MockContext(responses: [])
            case .serverError:
                context = MockContext(responses: [
                    .data(MockData.mockingServerErrorResponse()),
                    .data(MockData.mockingServerErrorResponse()),
                    .data(MockData.mockingServerErrorResponse()),
                ])
            }
        }
    }

    func testRequest() async throws {
        let testData = try TestData(testCase: .success)
        let response: MockResources.Content = try await testData.context.client.send(testData.context.request())
        XCTAssertEqual(testData.resources.content, response)
    }

    func testRequestWithPagedResponses() async throws {
        let testData = try TestData(testCase: .successPaginated)

        var page = 0
        let pages = [
            testData.resources.pagedContentFirst,
            testData.resources.pagedContentNext,
            testData.resources.pagedContentLast,
        ]
        for try await response: MockResources.PagedContent in await testData.context.client.pages(
            testData.context.request()
        ) {
            defer { page += 1 }
            XCTAssertEqual(response, pages[page])
        }

        XCTAssertEqual(page, 3)
    }

    func testRequestWithManualPagination() async throws {
        let testData = try TestData(testCase: .successPaginated)
        var response: MockResources.PagedContent? = try await testData.context.client.send(testData.context.request())
        XCTAssertEqual(testData.resources.pagedContentFirst, response)
        response = try await testData.context.client.send(testData.context.request(), pageAfter: XCTUnwrap(response))
        XCTAssertEqual(testData.resources.pagedContentNext, response)
        response = try await testData.context.client.send(testData.context.request(), pageAfter: XCTUnwrap(response))
        XCTAssertEqual(testData.resources.pagedContentLast, response)
        response = try await testData.context.client.send(testData.context.request(), pageAfter: XCTUnwrap(response))
        XCTAssertNil(response)
    }

    func testNoContentResponse() async throws {
        let testData = try TestData(testCase: .successNoContent)
        _ = try await testData.context.client.send(testData.context.request())
    }

    func testBadResponse() async throws {
        let testData = try TestData(testCase: .badResponse)
        try await XCTAssertThrowsError(
            await testData.context.client.send(testData.context.request())
        )
    }

    func testUnsuccessfulResponse() async throws {
        let testData = try TestData(testCase: .unsuccessfulResponse)
        try await XCTAssertThrowsError(
            await testData.context.client.send(testData.context.request())
        )
    }

    func testRequestDownload() async throws {
        let testData = try TestData(testCase: .successDownload)
        let response: URL = try await testData.context.client.download(testData.context.request())
        XCTAssertEqual(testData.resources.downloadURL, response)
    }

    func testRequestWithFixedRetry() async throws {
        let testData = try TestData(testCase: .serverError)
        try await XCTAssertThrowsError(
            await testData.context.client.send(
                testData.context.request(),
                retry: .fixedInterval(.zero, limit: 3, clock: ImmediateClock())
            )
        )
    }

    func testRequestWithExponentialBackoffRetry() async throws {
        let testData = try TestData(testCase: .serverError)
        try await XCTAssertThrowsError(
            await testData.context.client.send(
                testData.context.request(),
                retry: .exponentialBackoff(interval: .zero, limit: 3, exponentialBase: 2, clock: ImmediateClock())
            )
        )
    }

    func testRequestWithCustomRetry() async throws {
        struct MockRetryStrategy: RetryStrategy {
            var limit: Int

            func waitAndContinue(for error: any Error, iteration: Int) async throws -> Bool {
                guard iteration < limit else { return false }

                return true
            }
        }

        let testData = try TestData(testCase: .serverError)
        try await XCTAssertThrowsError(
            await testData.context.client.send(
                testData.context.request(),
                retry: MockRetryStrategy(limit: 3)
            )
        )
    }
}

/// Adapted from https://github.com/pointfreeco/swift-clocks/blob/2c747763e02f8d39ed1b868e1725e65d8e06950d/Sources/Clocks/ImmediateClock.swift
fileprivate final class ImmediateClock<Duration>: Clock, @unchecked Sendable where Duration: DurationProtocol & Hashable {
    struct Instant: InstantProtocol {
        private let offset: Duration

        init(offset: Duration = .zero) {
            self.offset = offset
        }

        func advanced(by duration: Duration) -> Self {
            .init(offset: self.offset + duration)
        }

        func duration(to other: Self) -> Duration {
            other.offset - self.offset
        }

        static func < (lhs: Self, rhs: Self) -> Bool {
            lhs.offset < rhs.offset
        }
    }

    private(set) var now: Instant
    private(set) var minimumResolution: Duration = .zero

    public init(now: Instant = .init()) {
        self.now = now
    }

    public func sleep(until deadline: Instant, tolerance: Duration?) async throws {
        try Task.checkCancellation()
        self.now = deadline
        await Task.yield()
    }
}

extension ImmediateClock where Duration == Swift.Duration {
    fileprivate convenience init() {
        self.init(now: .init())
    }
}
