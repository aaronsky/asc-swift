// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AlternativeDistributionDomain: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case alternativeDistributionDomains
    }

    public struct Attributes: Codable, Equatable, Sendable {
        public var domain: String?
        public var referenceName: String?
        public var createdDate: Date?

        public init(domain: String? = nil, referenceName: String? = nil, createdDate: Date? = nil) {
            self.domain = domain
            self.referenceName = referenceName
            self.createdDate = createdDate
        }
    }

    public init(type: `Type` = .alternativeDistributionDomains, id: String, attributes: Attributes? = nil, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.links = links
    }
}