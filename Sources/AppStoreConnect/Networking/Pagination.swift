import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

/// A structure for iterating on paged resources asynchronously.
public struct PagedResponses<Response: Decodable & Sendable>: AsyncSequence, AsyncIteratorProtocol, Sendable {
    /// The type of element produced by this asynchronous sequence.
    public typealias Element = Response

    /// The initial request.
    ///
    /// Used for the initial request, and to shape the type of future requests.
    let request: Request<Response>
    /// A reference to the API client.
    let client: AppStoreConnectClient
    /// The retry strategy.
    let retryStrategy: any RetryStrategy

    /// Creates the sequence.
    /// - Parameters:
    ///   - request: The initial request.
    ///   - client: The API client.
    init(
        request: Request<Response>,
        client: AppStoreConnectClient,
        retry strategy: some RetryStrategy
    ) {
        self.request = request
        self.client = client
        self.retryStrategy = strategy
    }

    private var currentElement: Element?

    /// Asynchronously advances to the next element and returns it, or ends the sequence if there is no next element.
    /// - Returns: The next element, if it exists, or nil to signal the end of the sequence.
    /// - Throws: An error from ``AppStoreConnectClient`` if the current page's request fails.
    public mutating func next() async throws -> Element? {
        guard !Task.isCancelled else {
            return nil
        }

        if let current = currentElement {
            currentElement = try await client.send(request, pageAfter: current, retry: retryStrategy)
        } else {
            currentElement = try await client.send(request, retry: retryStrategy)
        }

        return currentElement
    }

    /// Creates the asynchronous iterator that produces elements of this asynchronous sequence.
    /// - Returns: An instance of the AsyncIterator type used to produce elements of the asynchronous sequence.
    public func makeAsyncIterator() -> Self {
        self
    }
}
