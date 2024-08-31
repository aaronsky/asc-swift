import AppStoreConnect
import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public actor MockTransport: Transport {
    public enum Output: Equatable, Sendable {
        case data(Response<Data>)
        case fileURL(Response<URL>)
    }

    public enum Error: Swift.Error, Equatable {
        case tooManyRequests
        case unexpectedResponse(Output)
    }

    public var history: [URLRequest] = []
    public var responses: [Output]

    public init(
        responses: [Output]
    ) {
        self.responses = responses
    }

    public func request<T>() -> Request<T> {
        .init(path: "test", method: "GET")
    }

    public func send(request: URLRequest, decoder: JSONDecoder) async throws -> Response<Data> {
        history.append(request)

        if responses.isEmpty {
            throw Error.tooManyRequests
        }

        let response: Response<Data>

        switch responses.removeFirst() {
        case .fileURL(let url):
            throw Error.unexpectedResponse(.fileURL(url))
        case .data(let data):
            response = data
        }

        try response.check()

        return response
    }

    public func download(request: URLRequest) async throws -> Response<URL> {
        history.append(request)

        if responses.isEmpty {
            throw Error.tooManyRequests
        }

        let response: Response<URL>

        switch responses.removeFirst() {
        case .fileURL(let url):
            response = url
        case .data(let data):
            throw Error.unexpectedResponse(.data(data))
        }

        try response.check()

        return response
    }

    public func upload(request: URLRequest, data: Data, decoder: JSONDecoder) async throws -> Response<Data> {
        try await send(request: request, decoder: decoder)
    }
}
