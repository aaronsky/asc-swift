import AppStoreConnect
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class MockTransport: Transport {
    enum Output: Equatable {
        case data(Response<Data>)
        case fileURL(Response<URL>)
    }

    enum Error: Swift.Error, Equatable {
        case tooManyRequests
        case unexpectedResponse(Output)
    }

    var history: [URLRequest] = []
    var responses: [Output]

    init(
        responses: [Output]
    ) {
        self.responses = responses
    }

    func request<T>() -> Request<T> {
        .init(path: "test", method: "GET")
    }

    func send(request: URLRequest, decoder: JSONDecoder) async throws -> Response<Data> {
        history.append(request)

        if responses.isEmpty {
            throw Error.tooManyRequests
        }

        switch responses.removeFirst() {
        case .fileURL(let url):
            throw Error.unexpectedResponse(.fileURL(url))
        case .data(let data):
            return data
        }
    }

    func download(request: URLRequest) async throws -> Response<URL> {
        history.append(request)

        if responses.isEmpty {
            throw Error.tooManyRequests
        }

        switch responses.removeFirst() {
        case .fileURL(let url):
            return url
        case .data(let data):
            throw Error.unexpectedResponse(.data(data))
        }
    }

    func upload(request: URLRequest, data: Data, decoder: JSONDecoder) async throws -> Response<Data> {
        try await send(request: request, decoder: decoder)
    }
}
