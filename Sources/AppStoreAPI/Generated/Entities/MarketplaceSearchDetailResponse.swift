// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct MarketplaceSearchDetailResponse: Codable, Equatable, Sendable {
    /// MarketplaceSearchDetail
    public var data: MarketplaceSearchDetail
    public var links: DocumentLinks

    public init(data: MarketplaceSearchDetail, links: DocumentLinks) {
        self.data = data
        self.links = links
    }
}
