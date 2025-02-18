// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct BetaTester: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var relationships: Relationships?
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case betaTesters
    }

    public struct Attributes: Codable, Equatable, Sendable {
        public var firstName: String?
        public var lastName: String?
        public var email: String?
        public var inviteType: BetaInviteType?
        public var state: BetaTesterState?

        public init(firstName: String? = nil, lastName: String? = nil, email: String? = nil, inviteType: BetaInviteType? = nil, state: BetaTesterState? = nil) {
            self.firstName = firstName
            self.lastName = lastName
            self.email = email
            self.inviteType = inviteType
            self.state = state
        }
    }

    public struct Relationships: Codable, Equatable, Sendable {
        public var apps: Apps?
        public var betaGroups: BetaGroups?
        public var builds: Builds?

        public struct Apps: Codable, Equatable, Sendable {
            public var links: RelationshipLinks?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
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

            public init(links: RelationshipLinks? = nil, meta: PagingInformation? = nil, data: [Datum]? = nil) {
                self.links = links
                self.meta = meta
                self.data = data
            }
        }

        public struct BetaGroups: Codable, Equatable, Sendable {
            public var links: RelationshipLinks?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case betaGroups
                }

                public init(type: `Type` = .betaGroups, id: String) {
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

        public struct Builds: Codable, Equatable, Sendable {
            public var links: RelationshipLinks?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
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

            public init(links: RelationshipLinks? = nil, meta: PagingInformation? = nil, data: [Datum]? = nil) {
                self.links = links
                self.meta = meta
                self.data = data
            }
        }

        public init(apps: Apps? = nil, betaGroups: BetaGroups? = nil, builds: Builds? = nil) {
            self.apps = apps
            self.betaGroups = betaGroups
            self.builds = builds
        }
    }

    public init(type: `Type` = .betaTesters, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.relationships = relationships
        self.links = links
    }
}
