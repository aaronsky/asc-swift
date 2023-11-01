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
            case successUploadSingle
            case successUploadMultipart
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
            case .successUploadSingle:
                context = MockContext(
                    responses: [
                        .data(MockData.mockingSuccessUpload())
                    ],
                    uploadOperations: [
                        resources.uploadOperationSingle
                    ]
                )
            case .successUploadMultipart:
                context = MockContext(
                    responses: [
                        .data(MockData.mockingSuccessUpload()),
                        .data(MockData.mockingSuccessUpload()),
                        .data(MockData.mockingSuccessUpload()),
                    ],
                    uploadOperations: resources.uploadOperationMultipart
                )
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

    func testRequestUploadSingle() async throws {
        let someData = Data(repeating: .random(in: UInt8.min...UInt8.max), count: 64)
        let testData = try TestData(testCase: .successUploadSingle)
        var authenticator = await testData.context.client.authenticator
        let operation = try XCTUnwrap(testData.context.uploadOperations.first)
        try XCTAssertEqual(XCTUnwrap(operation.offset) + XCTUnwrap(operation.length), someData.count)

        try await testData.context.client.upload(operation: operation, from: someData)

        XCTAssertEqual(testData.context.transport.history.count, testData.context.uploadOperations.count)
        try XCTAssertEqual(
            testData.context.transport.history.first,
            URLRequest(
                uploadOperation: operation,
                encoder: testData.context.client.encoder,
                authenticator: &authenticator
            )
        )
    }

    func testRequestUploadMultipart() async throws {
        let someData = Data(repeating: .random(in: UInt8.min...UInt8.max), count: 80)
        let testData = try TestData(testCase: .successUploadMultipart)
        var authenticator = await testData.context.client.authenticator
        XCTAssertEqual(testData.context.uploadOperations.count, 3)
        let totalLength = testData.context.uploadOperations.reduce(0) { acc, op in
            acc + (op.length ?? 0)
        }
        XCTAssertEqual(totalLength, someData.count)

        for operation in testData.context.uploadOperations {
            try await testData.context.client.upload(operation: operation, from: someData)
        }

        try XCTAssertEqual(
            testData.context.transport.history,
            testData.context.uploadOperations.map {
                try URLRequest(
                    uploadOperation: $0,
                    encoder: testData.context.client.encoder,
                    authenticator: &authenticator
                )
            }
        )
    }
}
