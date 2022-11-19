import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Error thrown when the ``Resource`` provided to the client is incompatible
/// with the client's supported API versions.
public enum ResourceError: Error, Equatable {
}

/// Resource describes an endpoint on any of App Store Connect's APIs. Do not implement this type.
public protocol Resource {
    /// The input type.
    associatedtype Body = Void
    /// The return type.
    associatedtype Content = Void

    /// The path to the resource.
    var path: String { get }
    /// An instance of the input type to be served with the request.
    var body: Body { get }
    /// Transform the given URLRequest to fit the resource.
    func transformRequest(_ request: inout URLRequest)
}

extension Resource {
    public var version: APIVersion {
        APIVersion.REST.v2
    }

    public func transformRequest(_ request: inout URLRequest) {}
}

extension Resource where Body == Void {
    public var body: Body {
        ()
    }
}

/// A specialization of ``Resource`` that supports pagination.
public protocol PaginatedResource: Resource where Content: Decodable {}

extension URLRequest {
    init<R: Resource>(
        _ resource: R,
        configuration: Configuration,
        tokens: TokenProvider?
    ) async throws {
        let version = resource.version
        guard
            version == configuration.version
                || version == configuration.graphQLVersion
                || version == configuration.agentVersion
                || version == configuration.testAnalyticsVersion
        else {
            throw ResourceError.incompatibleVersion(version)
        }

        let url = version.url(for: resource.path)
        var request = URLRequest(url: url)
        await configuration.transformRequest(&request, tokens: tokens, version: version)
        resource.transformRequest(&request)

        self = request
    }

    init<R: Resource>(
        _ resource: R,
        configuration: Configuration,
        tokens: TokenProvider?,
        encoder: JSONEncoder
    ) async throws where R.Body: Encodable {
        try await self.init(resource, configuration: configuration, tokens: tokens)
        httpBody = try encoder.encode(resource.body)
    }

    init<R: Resource & PaginatedResource>(
        _ resource: R,
        configuration: Configuration,
        tokens: TokenProvider?,
        pageOptions: PageOptions? = nil
    ) async throws {
        try await self.init(resource, configuration: configuration, tokens: tokens)
        if let options = pageOptions {
            appendPageOptions(options)
        }
    }

    init<R: Resource & PaginatedResource>(
        _ resource: R,
        configuration: Configuration,
        tokens: TokenProvider?,
        encoder: JSONEncoder,
        pageOptions: PageOptions? = nil
    ) async throws where R.Body: Encodable {
        try await self.init(resource, configuration: configuration, tokens: tokens, encoder: encoder)
        if let options = pageOptions {
            appendPageOptions(options)
        }
    }
}
