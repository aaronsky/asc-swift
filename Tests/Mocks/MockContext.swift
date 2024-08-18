import AppStoreConnect
import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct MockContext {
    public var client: AppStoreConnectClient
    public var transport: MockTransport
    public var authenticator: MockAuthenticator

    public init() {
        self.init(responses: [
            .data(MockData.mockingSuccessNoContent())
        ])
    }

    public init<Content: Codable>(
        content: Content...
    ) throws {
        try self.init(
            responses: content.map {
                try .data(MockData.mockingSuccess(with: $0))
            })
    }

    public init(
        responses: [MockTransport.Output]
    ) {
        self.transport = MockTransport(responses: responses)
        self.authenticator = MockAuthenticator()
        self.client = AppStoreConnectClient(
            transport: transport,
            authenticator: authenticator
        )
    }

    public func request<T>() async -> Request<T> {
        await transport.request()
    }
}
