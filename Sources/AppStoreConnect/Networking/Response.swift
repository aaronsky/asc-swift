import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Response from sending a ``Resource``.
public struct Response<T> {
    /// Data returned by an API.
    public let content: T
    /// The response metadata and headers from the network.
    public let response: URLResponse
    /// The page of the response, if paginated.
    public let page: Page?

    init(
        content: T,
        response: URLResponse
    ) {
        self.content = content
        self.response = response
        if let response = response as? HTTPURLResponse, let link = response.allHeaderFields["Link"] as? String {
            page = Page(for: link)
        } else {
            page = nil
        }
    }
}

extension Response: Equatable where T: Equatable {}
extension Response: Hashable where T: Hashable {}
extension Response: Sendable where T: Sendable {}

/// Error thrown when the response from the ``Transport`` cannot be interpreted.
public enum ResponseError: Error {
    case incompatibleResponse(URLResponse)
}

/// Buildkite-specific error returned from the REST API.
public struct BuildkiteError: Error {
    /// Symbolized status code from the response.
    public var statusCode: StatusCode
    /// Overview message describing the errors.
    public var message: String
    /// List of sub-errors to contextualize the reasons for failure.
    public var errors: [String]

    init(
        statusCode: StatusCode,
        intermediary: Intermediary
    ) {
        self.statusCode = statusCode
        self.message = intermediary.message ?? ""
        self.errors = intermediary.errors ?? []
    }

    struct Intermediary: Codable {
        var message: String?
        var errors: [String]?
    }
}
