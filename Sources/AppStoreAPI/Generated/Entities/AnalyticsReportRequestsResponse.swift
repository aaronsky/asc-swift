// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AnalyticsReportRequestsResponse: Codable, Equatable, Sendable {
    public var data: [AnalyticsReportRequest]
    public var included: [AnalyticsReport]?
    public var links: PagedDocumentLinks
    public var meta: PagingInformation?

    public init(data: [AnalyticsReportRequest], included: [AnalyticsReport]? = nil, links: PagedDocumentLinks, meta: PagingInformation? = nil) {
        self.data = data
        self.included = included
        self.links = links
        self.meta = meta
    }
}