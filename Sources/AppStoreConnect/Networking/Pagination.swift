import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// A structure for iterating on paged resources asynchronously.
public struct PagedResponses<Response>: AsyncSequence, AsyncIteratorProtocol where Response: Decodable {
    public typealias Element = Response

    /// The initial request. Used for the initial request, and to shape the type of future requests.
    let request: Request<Response>
    /// A reference to the API client.
    let client: AppStoreConnectClient

    /// Creates the sequence.
    /// - Parameters:
    ///   - request: The initial request.
    ///   - client: The API client.
    init(
        request: Request<Response>,
        client: AppStoreConnectClient
    ) {
        self.request = request
        self.client = client
    }

    private var currentElement: Element?

    public mutating func next() async throws -> Element? {
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
