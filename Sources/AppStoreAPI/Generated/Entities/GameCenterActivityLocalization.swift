// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct GameCenterActivityLocalization: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var relationships: Relationships?
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case gameCenterActivityLocalizations
    }

    public struct Attributes: Codable, Equatable, Sendable {
        public var locale: String?
        public var name: String?
        public var description: String?

        public init(locale: String? = nil, name: String? = nil, description: String? = nil) {
            self.locale = locale
            self.name = name
            self.description = description
        }
    }

    public struct Relationships: Codable, Equatable, Sendable {
        public var version: Version?
        public var image: Image?

        public struct Version: Codable, Equatable, Sendable {
            public var data: Data?

            public struct Data: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case gameCenterActivityVersions
                }

                public init(type: `Type` = .gameCenterActivityVersions, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(data: Data? = nil) {
                self.data = data
            }
        }

        public struct Image: Codable, Equatable, Sendable {
            public var links: RelationshipLinks?
            public var data: Data?

            public struct Data: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case gameCenterActivityImages
                }

                public init(type: `Type` = .gameCenterActivityImages, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: RelationshipLinks? = nil, data: Data? = nil) {
                self.links = links
                self.data = data
            }
        }

        public init(version: Version? = nil, image: Image? = nil) {
            self.version = version
            self.image = image
        }
    }

    public init(type: `Type` = .gameCenterActivityLocalizations, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.relationships = relationships
        self.links = links
    }
}
