// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct BetaBuildLocalizationResponse: Codable, Equatable, Sendable {
    /// BetaBuildLocalization
    public var data: BetaBuildLocalization
    public var included: [Build]?
    public var links: DocumentLinks

    public init(data: BetaBuildLocalization, included: [Build]? = nil, links: DocumentLinks) {
        self.data = data
        self.included = included
        self.links = links
    }
}
