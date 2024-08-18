import Foundation
import Mocks
import XCTest

@testable import AppStoreAPI
@testable import AppStoreConnect

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

final class UploadOperationsTests: XCTestCase {
    private struct TestData {
        enum Case {
            case successUploadSingle
            case successUploadMultipart
        }

        var context: MockUploadContext
        var resources = MockUploadResources()

        init(testCase: Case) throws {
            switch testCase {
            case .successUploadSingle:
                context = MockUploadContext(
                    responses: [
                        .data(MockData.mockingSuccessUpload())
                    ],
                    uploadOperations: [
                        resources.uploadOperationSingle
                    ]
                )
            case .successUploadMultipart:
                context = MockUploadContext(
                    responses: [
                        .data(MockData.mockingSuccessUpload()),
                        .data(MockData.mockingSuccessUpload()),
                        .data(MockData.mockingSuccessUpload()),
                    ],
                    uploadOperations: resources.uploadOperationMultipart
                )
            }
        }
    }

    func testRequestUploadSingle() async throws {
        let someData = Data(repeating: .random(in: UInt8.min...UInt8.max), count: 64)
        let testData = try TestData(testCase: .successUploadSingle)
        var authenticator = await testData.context.client.authenticator
        let operation = try XCTUnwrap(testData.context.uploadOperations.first)
        try XCTAssertEqual(XCTUnwrap(operation.offset) + XCTUnwrap(operation.length), someData.count)

        try await testData.context.client.upload(operation: operation, from: someData)

        let history = await testData.context.transport.history
        let encoder = await testData.context.client.encoder

        XCTAssertEqual(history.count, testData.context.uploadOperations.count)
        try XCTAssertEqual(
            history.first,
            URLRequest(
                uploadOperation: operation,
                encoder: encoder,
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

        let history = await testData.context.transport.history
        let encoder = await testData.context.client.encoder

        try XCTAssertEqual(
            history,
            testData.context.uploadOperations.map {
                try URLRequest(
                    uploadOperation: $0,
                    encoder: encoder,
                    authenticator: &authenticator
                )
            }
        )
    }
}

struct MockUploadContext {
    var client: AppStoreConnectClient
    var transport: MockTransport
    var authenticator: MockAuthenticator
    var uploadOperations: [UploadOperation]

    init(
        responses: [MockTransport.Output],
        uploadOperations: [UploadOperation]
    ) {
        self.transport = MockTransport(responses: responses)
        self.authenticator = MockAuthenticator()
        self.client = AppStoreConnectClient(
            transport: transport,
            authenticator: authenticator
        )
        self.uploadOperations = uploadOperations
    }

    func request<T>() async -> Request<T> {
        await transport.request()
    }
}

struct MockUploadResources {
    var uploadOperationSingle = UploadOperation(
        method: "POST",
        url: "test",
        length: 64,
        offset: 0,
        requestHeaders: nil
    )

    var uploadOperationMultipart = [
        UploadOperation(
            method: "POST",
            url: "test",
            length: 32,
            offset: 0,
            requestHeaders: nil
        ),
        UploadOperation(
            method: "POST",
            url: "test",
            length: 32,
            offset: 32,
            requestHeaders: nil
        ),
        UploadOperation(
            method: "POST",
            url: "test",
            length: 16,
            offset: 64,
            requestHeaders: nil
        ),
    ]
}
