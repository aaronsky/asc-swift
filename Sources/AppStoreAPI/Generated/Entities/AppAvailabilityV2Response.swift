// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AppAvailabilityV2Response: Codable, Equatable, Sendable {
    /// AppAvailabilityV2
    public var data: AppAvailabilityV2
    public var included: [TerritoryAvailability]?
    public var links: DocumentLinks

    public init(data: AppAvailabilityV2, included: [TerritoryAvailability]? = nil, links: DocumentLinks) {
        self.data = data
        self.included = included
        self.links = links
    }
}