// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct ScmGitReference: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var relationships: Relationships?
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case scmGitReferences
    }

    public struct Attributes: Codable, Equatable, Sendable {
        public var name: String?
        public var canonicalName: String?
        public var isDeleted: Bool?
        public var kind: CiGitRefKind?

        public init(name: String? = nil, canonicalName: String? = nil, isDeleted: Bool? = nil, kind: CiGitRefKind? = nil) {
            self.name = name
            self.canonicalName = canonicalName
            self.isDeleted = isDeleted
            self.kind = kind
        }
    }

    public struct Relationships: Codable, Equatable, Sendable {
        public var repository: Repository?

        public struct Repository: Codable, Equatable, Sendable {
            public var data: Data?

            public struct Data: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case scmRepositories
                }

                public init(type: `Type` = .scmRepositories, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(data: Data? = nil) {
                self.data = data
            }
        }

        public init(repository: Repository? = nil) {
            self.repository = repository
        }
    }

    public init(type: `Type` = .scmGitReferences, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.relationships = relationships
        self.links = links
    }
}
