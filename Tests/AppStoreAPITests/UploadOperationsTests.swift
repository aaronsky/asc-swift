import Foundation
import Mocks
import Testing

@testable import AppStoreAPI
@testable import AppStoreConnect

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

@Test func requestUploadSingle() async throws {
    let someData = Data(repeating: .random(in: UInt8.min...UInt8.max), count: 64)
    let context = MockUploadContext(
        responses: [
            .data(MockData.mockingSuccessUpload())
        ],
        uploadOperations: [
            UploadOperation(
                method: "POST",
                url: "test",
                length: 64,
                offset: 0,
                requestHeaders: nil
            )
        ]
    )
    var authenticator = await context.client.authenticator
    let operation = try #require(context.uploadOperations.first)
    try #expect(#require(operation.offset) + #require(operation.length) == someData.count)

    try await context.client.upload(operation: operation, from: someData)

    let history = await context.transport.history
    let encoder = await context.client.encoder

    let expectedRequest = try URLRequest(
        uploadOperation: operation,
        encoder: encoder,
        authenticator: &authenticator
    )

    #expect(history.count == context.uploadOperations.count)
    #expect(history.first == expectedRequest)
}

@Test func requestUploadMultipart() async throws {
    let someData = Data(repeating: .random(in: UInt8.min...UInt8.max), count: 80)
    let context = MockUploadContext(
        responses: [
            .data(MockData.mockingSuccessUpload()),
            .data(MockData.mockingSuccessUpload()),
            .data(MockData.mockingSuccessUpload()),
        ],
        uploadOperations: [
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
    )
    var authenticator = await context.client.authenticator
    #expect(context.uploadOperations.count == 3)
    let totalLength = context.uploadOperations.reduce(0) { acc, op in
        acc + (op.length ?? 0)
    }
    #expect(totalLength == someData.count)

    for operation in context.uploadOperations {
        try await context.client.upload(operation: operation, from: someData)
    }

    let history = await context.transport.history
    let encoder = await context.client.encoder

    let expectedRequests = try context.uploadOperations.map {
        try URLRequest(
            uploadOperation: $0,
            encoder: encoder,
            authenticator: &authenticator
        )
    }

    #expect(history == expectedRequests)
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
