// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct BetaBuildLocalization: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var relationships: Relationships?
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case betaBuildLocalizations
    }

    public struct Attributes: Codable, Equatable, Sendable {
        public var whatsNew: String?
        public var locale: String?

        public init(whatsNew: String? = nil, locale: String? = nil) {
            self.whatsNew = whatsNew
            self.locale = locale
        }
    }

    public struct Relationships: Codable, Equatable, Sendable {
        public var build: Build?

        public struct Build: Codable, Equatable, Sendable {
            public var links: RelationshipLinks?
            public var data: Data?

            public struct Data: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case builds
                }

                public init(type: `Type` = .builds, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: RelationshipLinks? = nil, data: Data? = nil) {
                self.links = links
                self.data = data
            }
        }

        public init(build: Build? = nil) {
            self.build = build
        }
    }

    public init(type: `Type` = .betaBuildLocalizations, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.relationships = relationships
        self.links = links
    }
}
