// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AppCategory: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var relationships: Relationships?
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case appCategories
    }

    public struct Attributes: Codable, Equatable, Sendable {
        public var platforms: [Platform]?

        public init(platforms: [Platform]? = nil) {
            self.platforms = platforms
        }
    }

    public struct Relationships: Codable, Equatable, Sendable {
        public var subcategories: Subcategories?
        public var parent: Parent?

        public struct Subcategories: Codable, Equatable, Sendable {
            public var links: RelationshipLinks?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case appCategories
                }

                public init(type: `Type` = .appCategories, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: RelationshipLinks? = nil, meta: PagingInformation? = nil, data: [Datum]? = nil) {
                self.links = links
                self.meta = meta
                self.data = data
            }
        }

        public struct Parent: Codable, Equatable, Sendable {
            public var links: RelationshipLinks?
            public var data: Data?

            public struct Data: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case appCategories
                }

                public init(type: `Type` = .appCategories, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: RelationshipLinks? = nil, data: Data? = nil) {
                self.links = links
                self.data = data
            }
        }

        public init(subcategories: Subcategories? = nil, parent: Parent? = nil) {
            self.subcategories = subcategories
            self.parent = parent
        }
    }

    public init(type: `Type` = .appCategories, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.relationships = relationships
        self.links = links
    }
}
