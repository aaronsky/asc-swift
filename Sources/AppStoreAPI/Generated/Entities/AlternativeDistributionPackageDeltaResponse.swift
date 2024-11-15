// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AlternativeDistributionPackageDeltaResponse: Codable, Equatable, Sendable {
    /// AlternativeDistributionPackageDelta
    public var data: AlternativeDistributionPackageDelta
    public var links: DocumentLinks

    public init(data: AlternativeDistributionPackageDelta, links: DocumentLinks) {
        self.data = data
        self.links = links
    }
}
