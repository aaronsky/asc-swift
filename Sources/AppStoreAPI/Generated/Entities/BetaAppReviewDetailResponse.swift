// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct BetaAppReviewDetailResponse: Codable, Equatable, Sendable {
    /// BetaAppReviewDetail
    public var data: BetaAppReviewDetail
    public var included: [App]?
    public var links: DocumentLinks

    public init(data: BetaAppReviewDetail, included: [App]? = nil, links: DocumentLinks) {
        self.data = data
        self.included = included
        self.links = links
    }
}
