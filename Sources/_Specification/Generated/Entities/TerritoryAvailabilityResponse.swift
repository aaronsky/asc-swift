// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct TerritoryAvailabilityResponse: Codable, Hashable {
    /// TerritoryAvailability
    public var data: TerritoryAvailability
    public var included: [Territory]?
    public var links: DocumentLinks

    public init(data: TerritoryAvailability, included: [Territory]? = nil, links: DocumentLinks) {
        self.data = data
        self.included = included
        self.links = links
    }
}