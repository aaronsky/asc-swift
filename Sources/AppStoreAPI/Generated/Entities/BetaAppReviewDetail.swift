// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct BetaAppReviewDetail: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var relationships: Relationships?
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case betaAppReviewDetails
    }

    public struct Attributes: Codable, Equatable, Sendable {
        public var contactFirstName: String?
        public var contactLastName: String?
        public var contactPhone: String?
        public var contactEmail: String?
        public var demoAccountName: String?
        public var demoAccountPassword: String?
        public var isDemoAccountRequired: Bool?
        public var notes: String?

        public init(contactFirstName: String? = nil, contactLastName: String? = nil, contactPhone: String? = nil, contactEmail: String? = nil, demoAccountName: String? = nil, demoAccountPassword: String? = nil, isDemoAccountRequired: Bool? = nil, notes: String? = nil) {
            self.contactFirstName = contactFirstName
            self.contactLastName = contactLastName
            self.contactPhone = contactPhone
            self.contactEmail = contactEmail
            self.demoAccountName = demoAccountName
            self.demoAccountPassword = demoAccountPassword
            self.isDemoAccountRequired = isDemoAccountRequired
            self.notes = notes
        }

        private enum CodingKeys: String, CodingKey {
            case contactFirstName
            case contactLastName
            case contactPhone
            case contactEmail
            case demoAccountName
            case demoAccountPassword
            case isDemoAccountRequired = "demoAccountRequired"
            case notes
        }
    }

    public struct Relationships: Codable, Equatable, Sendable {
        public var app: App?

        public struct App: Codable, Equatable, Sendable {
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
                    case apps
                }

                public init(type: `Type` = .apps, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: Links? = nil, data: Data? = nil) {
                self.links = links
                self.data = data
            }
        }

        public init(app: App? = nil) {
            self.app = app
        }
    }

    public init(type: `Type` = .betaAppReviewDetails, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.relationships = relationships
        self.links = links
    }
}