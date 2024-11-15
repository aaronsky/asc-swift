// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct GameCenterMatchmakingRuleSet: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var relationships: Relationships?
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case gameCenterMatchmakingRuleSets
    }

    public struct Attributes: Codable, Equatable, Sendable {
        public var referenceName: String?
        public var ruleLanguageVersion: Int?
        public var minPlayers: Int?
        public var maxPlayers: Int?

        public init(referenceName: String? = nil, ruleLanguageVersion: Int? = nil, minPlayers: Int? = nil, maxPlayers: Int? = nil) {
            self.referenceName = referenceName
            self.ruleLanguageVersion = ruleLanguageVersion
            self.minPlayers = minPlayers
            self.maxPlayers = maxPlayers
        }
    }

    public struct Relationships: Codable, Equatable, Sendable {
        public var teams: Teams?
        public var rules: Rules?
        public var matchmakingQueues: MatchmakingQueues?

        public struct Teams: Codable, Equatable, Sendable {
            public var links: RelationshipLinks?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case gameCenterMatchmakingTeams
                }

                public init(type: `Type` = .gameCenterMatchmakingTeams, id: String) {
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

        public struct Rules: Codable, Equatable, Sendable {
            public var links: RelationshipLinks?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case gameCenterMatchmakingRules
                }

                public init(type: `Type` = .gameCenterMatchmakingRules, id: String) {
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

        public struct MatchmakingQueues: Codable, Equatable, Sendable {
            public var links: RelationshipLinks?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case gameCenterMatchmakingQueues
                }

                public init(type: `Type` = .gameCenterMatchmakingQueues, id: String) {
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

        public init(teams: Teams? = nil, rules: Rules? = nil, matchmakingQueues: MatchmakingQueues? = nil) {
            self.teams = teams
            self.rules = rules
            self.matchmakingQueues = matchmakingQueues
        }
    }

    public init(type: `Type` = .gameCenterMatchmakingRuleSets, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.relationships = relationships
        self.links = links
    }
}
