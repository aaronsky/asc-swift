import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct PagedResponses<T>: AsyncSequence, AsyncIteratorProtocol where T: Decodable {
    public typealias Element = T

    let request: Request<T>
    let client: AppStoreConnectClient

    init(
        request: Request<T>,
        client: AppStoreConnectClient
    ) {
        self.request = request
        self.client = client
    }

    private var currentElement: T?

    public mutating func next() async throws -> T? {
        guard !Task.isCancelled else {
            return nil
        }

        if let current = currentElement {
            currentElement = try await client.send(request, pageAfter: current)
        } else {
            currentElement = try await client.send(request)
        }

        return currentElement
    }

    public func makeAsyncIterator() -> Self {
        self
    }
}
