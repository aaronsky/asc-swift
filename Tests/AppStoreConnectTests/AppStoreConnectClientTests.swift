import Foundation
import XCTest

@testable import AppStoreConnect

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

final class AppStoreConnectTests: XCTestCase {
    private struct TestData {
        enum Case {
            case success
            case successPaginated
            case successNoContent
            case successDownload
            case badResponse
            case unsuccessfulResponse
            case noData
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
        for try await response: MockResources.PagedContent in testData.context.client.pages(
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
}
