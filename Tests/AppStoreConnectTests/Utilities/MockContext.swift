import AppStoreConnect
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct MockContext {
    var client: AppStoreConnectClient
    var resources = MockResources()

    init() {
        let configuration = Configuration.default
        self.init(
            configuration: configuration,
            responses: [
                MockData.mockingSuccessNoContent(url: configuration.version.baseURL)
            ]
        )
    }

    init<Content: Codable>(
        content: Content...
    ) throws {
        let configuration = Configuration.default
        try self.init(
            configuration: configuration,
            responses: content.map {
                try MockData.mockingSuccess(with: $0, url: configuration.version.baseURL)
            }
        )
    }

    private init(
        configuration: Configuration,
        responses: [(Data, URLResponse)]
    ) {
        let transport = MockTransport(responses: responses)
        client = AppStoreConnectClient(
            configuration: configuration,
            transport: transport
        )
    }
}
