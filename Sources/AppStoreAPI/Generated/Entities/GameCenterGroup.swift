// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct GameCenterGroup: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var relationships: Relationships?
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case gameCenterGroups
    }

    public struct Attributes: Codable, Equatable, Sendable {
        public var referenceName: String?

        public init(referenceName: String? = nil) {
            self.referenceName = referenceName
        }
    }

    public struct Relationships: Codable, Equatable, Sendable {
        public var gameCenterDetails: GameCenterDetails?
        public var gameCenterLeaderboards: GameCenterLeaderboards?
        public var gameCenterLeaderboardSets: GameCenterLeaderboardSets?
        public var gameCenterAchievements: GameCenterAchievements?
        public var gameCenterActivities: GameCenterActivities?
        public var gameCenterChallenges: GameCenterChallenges?

        public struct GameCenterDetails: Codable, Equatable, Sendable {
            public var links: RelationshipLinks?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case gameCenterDetails
                }

                public init(type: `Type` = .gameCenterDetails, id: String) {
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

        public struct GameCenterLeaderboards: Codable, Equatable, Sendable {
            public var links: RelationshipLinks?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case gameCenterLeaderboards
                }

                public init(type: `Type` = .gameCenterLeaderboards, id: String) {
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

        public struct GameCenterLeaderboardSets: Codable, Equatable, Sendable {
            public var links: RelationshipLinks?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case gameCenterLeaderboardSets
                }

                public init(type: `Type` = .gameCenterLeaderboardSets, id: String) {
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

        public struct GameCenterAchievements: Codable, Equatable, Sendable {
            public var links: RelationshipLinks?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case gameCenterAchievements
                }

                public init(type: `Type` = .gameCenterAchievements, id: String) {
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

        public struct GameCenterActivities: Codable, Equatable, Sendable {
            public var links: RelationshipLinks?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case gameCenterActivities
                }

                public init(type: `Type` = .gameCenterActivities, id: String) {
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

        public struct GameCenterChallenges: Codable, Equatable, Sendable {
            public var links: RelationshipLinks?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case gameCenterChallenges
                }

                public init(type: `Type` = .gameCenterChallenges, id: String) {
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

        public init(gameCenterDetails: GameCenterDetails? = nil, gameCenterLeaderboards: GameCenterLeaderboards? = nil, gameCenterLeaderboardSets: GameCenterLeaderboardSets? = nil, gameCenterAchievements: GameCenterAchievements? = nil, gameCenterActivities: GameCenterActivities? = nil, gameCenterChallenges: GameCenterChallenges? = nil) {
            self.gameCenterDetails = gameCenterDetails
            self.gameCenterLeaderboards = gameCenterLeaderboards
            self.gameCenterLeaderboardSets = gameCenterLeaderboardSets
            self.gameCenterAchievements = gameCenterAchievements
            self.gameCenterActivities = gameCenterActivities
            self.gameCenterChallenges = gameCenterChallenges
        }
    }

    public init(type: `Type` = .gameCenterGroups, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.relationships = relationships
        self.links = links
    }
}
