// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct CiMacOsVersionsResponse: Codable, Equatable, Sendable {
    public var data: [CiMacOsVersion]
    public var included: [CiXcodeVersion]?
    public var links: PagedDocumentLinks
    public var meta: PagingInformation?

    public init(data: [CiMacOsVersion], included: [CiXcodeVersion]? = nil, links: PagedDocumentLinks, meta: PagingInformation? = nil) {
        self.data = data
        self.included = included
        self.links = links
        self.meta = meta
    }
}