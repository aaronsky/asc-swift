// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct SubscriptionOfferCodeOneTimeUseCode: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var relationships: Relationships?
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case subscriptionOfferCodeOneTimeUseCodes
    }

    public struct Attributes: Codable, Equatable, Sendable {
        public var numberOfCodes: Int?
        public var createdDate: Date?
        public var expirationDate: String?
        public var isActive: Bool?

        public init(numberOfCodes: Int? = nil, createdDate: Date? = nil, expirationDate: String? = nil, isActive: Bool? = nil) {
            self.numberOfCodes = numberOfCodes
            self.createdDate = createdDate
            self.expirationDate = expirationDate
            self.isActive = isActive
        }

        private enum CodingKeys: String, CodingKey {
            case numberOfCodes
            case createdDate
            case expirationDate
            case isActive = "active"
        }
    }

    public struct Relationships: Codable, Equatable, Sendable {
        public var offerCode: OfferCode?

        public struct OfferCode: Codable, Equatable, Sendable {
            public var links: Links?
            public var data: Data?

            public struct Links: Codable, Equatable, Sendable {
                public var this: URL?
                public var related: URL?

                public init(this: URL? = nil, related: URL? = nil) {
                    self.this = this
                    self.related = related
                }

                private enum CodingKeys: String, CodingKey {
                    case this = "self"
                    case related
                }
            }

            public struct Data: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case subscriptionOfferCodes
                }

                public init(type: `Type` = .subscriptionOfferCodes, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: Links? = nil, data: Data? = nil) {
                self.links = links
                self.data = data
            }
        }

        public init(offerCode: OfferCode? = nil) {
            self.offerCode = offerCode
        }
    }

    public init(type: `Type` = .subscriptionOfferCodeOneTimeUseCodes, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.relationships = relationships
        self.links = links
    }
}
