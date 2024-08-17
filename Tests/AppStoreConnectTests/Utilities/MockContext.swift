import AppStoreConnect
import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

struct MockContext {
    var client: AppStoreConnectClient
    var transport: MockTransport
    var authenticator: MockAuthenticator

    init() {
        self.init(responses: [
            .data(MockData.mockingSuccessNoContent())
        ])
    }

    init<Content: Codable>(
        content: Content...
    ) throws {
        try self.init(
            responses: content.map {
                try .data(MockData.mockingSuccess(with: $0))
            })
    }

    init(
        responses: [MockTransport.Output]
    ) {
        self.transport = MockTransport(responses: responses)
        self.authenticator = MockAuthenticator()
        self.client = AppStoreConnectClient(
            transport: transport,
            authenticator: authenticator
        )
    }

    func request<T>() -> Request<T> {
        transport.request()
    }
}
