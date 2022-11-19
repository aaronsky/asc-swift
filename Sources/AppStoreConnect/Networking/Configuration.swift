import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Generic configuration for the ``AppStoreConnect``.
public struct Configuration: Equatable, Hashable, Sendable {
    public let userAgent = "asc-swift"

    public init() {}

    func transformRequest(_ request: inout URLRequest) async {}
}
