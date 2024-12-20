// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct SubscriptionLocalizationResponse: Codable, Equatable, Sendable {
    /// SubscriptionLocalization
    public var data: SubscriptionLocalization
    public var included: [Subscription]?
    public var links: DocumentLinks

    public init(data: SubscriptionLocalization, included: [Subscription]? = nil, links: DocumentLinks) {
        self.data = data
        self.included = included
        self.links = links
    }
}
