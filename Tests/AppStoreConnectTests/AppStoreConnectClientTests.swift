import Foundation
import Mocks
import Testing

@testable import AppStoreConnect

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

@Test func request() async throws {
    let resources = MockResources()
    let context = try MockContext(content: resources.content)
    let response: MockResources.Content = try await context.client.send(context.request())
    #expect(resources.content == response)
}

@Test func requestWithPagedResponses() async throws {
    let resources = MockResources()
    let context = try MockContext(
        content: resources.pagedContentFirst,
        resources.pagedContentNext,
        resources.pagedContentLast
    )

    var page = 0
    let pages = [
        resources.pagedContentFirst,
        resources.pagedContentNext,
        resources.pagedContentLast,
    ]
    for try await response: MockResources.PagedContent in await context.client.pages(
        context.request()
    ) {
        defer { page += 1 }
        #expect(response == pages[page])
    }

    #expect(page == 3)
}

@Test func requestWithManualPagination() async throws {
    let resources = MockResources()
    let context = try MockContext(
        content: resources.pagedContentFirst,
        resources.pagedContentNext,
        resources.pagedContentLast
    )
    var response: MockResources.PagedContent? = try await context.client.send(context.request())
    #expect(resources.pagedContentFirst == response)
    response = try await context.client.send(context.request(), pageAfter: #require(response))
    #expect(resources.pagedContentNext == response)
    response = try await context.client.send(context.request(), pageAfter: #require(response))
    #expect(resources.pagedContentLast == response)
    response = try await context.client.send(context.request(), pageAfter: #require(response))
    #expect(response == nil)
}

@Test func noContentResponse() async throws {
    let context = MockContext()
    _ = try await context.client.send(context.request())
}

@Test func badResponse() async throws {
    let context = MockContext(responses: [
        .data(MockData.mockingIncompatibleResponse())
    ])
    await #expect(throws: (any Error).self) {
        try await context.client.send(context.request())
    }
}

@Test func unsuccessfulResponse() async throws {
    let context = MockContext(responses: [
        .data(MockData.mockingUnsuccessfulResponse())
    ])
    await #expect(throws: (any Error).self) {
        try await context.client.send(context.request())
    }
}

@Test func requestDownload() async throws {
    let resources = MockResources()
    let context = MockContext(responses: [
        .fileURL(MockData.mockingSuccessDownload(to: resources.downloadURL))
    ])
    let response: URL = try await context.client.download(context.request())
    #expect(resources.downloadURL == response)
}

@Test func requestWithFixedRetry() async throws {
    let context = MockContext(responses: [
        .data(MockData.mockingServerErrorResponse()),
        .data(MockData.mockingServerErrorResponse()),
        .data(MockData.mockingServerErrorResponse()),
    ])
    await #expect(throws: (any Error).self) {
        try await context.client.send(
            context.request(),
            retry: .fixedInterval(.zero, limit: 3, clock: ImmediateClock())
        )
    }
}

@Test func requestWithExponentialBackoffRetry() async throws {
    let context = MockContext(responses: [
        .data(MockData.mockingServerErrorResponse()),
        .data(MockData.mockingServerErrorResponse()),
        .data(MockData.mockingServerErrorResponse()),
    ])
    await #expect(throws: (any Error).self) {
        try await context.client.send(
            context.request(),
            retry: .exponentialBackoff(interval: .zero, limit: 3, exponentialBase: 2, clock: ImmediateClock())
        )
    }
}

@Test func requestWithCustomRetry() async throws {
    struct MockRetryStrategy: RetryStrategy {
        var limit: Int

        func waitAndContinue(for error: any Error, iteration: Int) async throws -> Bool {
            guard iteration < limit else { return false }

            return true
        }
    }

    let context = MockContext(responses: [
        .data(MockData.mockingServerErrorResponse()),
        .data(MockData.mockingServerErrorResponse()),
        .data(MockData.mockingServerErrorResponse()),
    ])
    await #expect(throws: (any Error).self) {
        try await context.client.send(
            context.request(),
            retry: MockRetryStrategy(limit: 3)
        )
    }
}

/// Adapted from https://github.com/pointfreeco/swift-clocks/blob/2c747763e02f8d39ed1b868e1725e65d8e06950d/Sources/Clocks/ImmediateClock.swift
private final class ImmediateClock<Duration>: Clock, @unchecked Sendable where Duration: DurationProtocol & Hashable {
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
