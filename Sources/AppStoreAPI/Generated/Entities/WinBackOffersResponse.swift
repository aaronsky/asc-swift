// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct WinBackOffersResponse: Codable, Equatable, Sendable {
    public var data: [WinBackOffer]
    public var included: [WinBackOfferPrice]?
    public var links: PagedDocumentLinks
    public var meta: PagingInformation?

    public init(data: [WinBackOffer], included: [WinBackOfferPrice]? = nil, links: PagedDocumentLinks, meta: PagingInformation? = nil) {
        self.data = data
        self.included = included
        self.links = links
        self.meta = meta
    }
}
