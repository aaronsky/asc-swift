import AppStoreConnect
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class MockTransport {
    enum Error: Swift.Error {
        case tooManyRequests
    }

    var history: [URLRequest] = []
    var responses: [Transport.Output]

    init(
        responses: [Transport.Output]
    ) {
        self.responses = responses
    }
}

extension MockTransport: Transport {
    func send(request: URLRequest) async throws -> Output {
        history.append(request)

        if responses.isEmpty {
            throw MockTransport.Error.tooManyRequests
        }

        return responses.removeFirst()
    }
}
