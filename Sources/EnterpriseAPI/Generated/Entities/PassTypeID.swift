// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct PassTypeID: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var relationships: Relationships?
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case passTypeIDs = "passTypeIds"
    }

    public struct Attributes: Codable, Equatable, Sendable {
        public var name: String?
        public var identifier: String?

        public init(name: String? = nil, identifier: String? = nil) {
            self.name = name
            self.identifier = identifier
        }
    }

    public struct Relationships: Codable, Equatable, Sendable {
        public var certificates: Certificates?

        public struct Certificates: Codable, Equatable, Sendable {
            public var links: RelationshipLinks?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case certificates
                }

                public init(type: `Type` = .certificates, id: String) {
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

        public init(certificates: Certificates? = nil) {
            self.certificates = certificates
        }
    }

    public init(type: `Type` = .passTypeIDs, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.relationships = relationships
        self.links = links
    }
}