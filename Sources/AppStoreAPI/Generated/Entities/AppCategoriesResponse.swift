// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AppCategoriesResponse: Codable, Equatable, Sendable {
    public var data: [AppCategory]
    public var included: [AppCategory]?
    public var links: PagedDocumentLinks
    public var meta: PagingInformation?

    public init(data: [AppCategory], included: [AppCategory]? = nil, links: PagedDocumentLinks, meta: PagingInformation? = nil) {
        self.data = data
        self.included = included
        self.links = links
        self.meta = meta
    }
}