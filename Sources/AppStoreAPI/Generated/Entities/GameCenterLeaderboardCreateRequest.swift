// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct GameCenterLeaderboardCreateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Sendable {
        public var type: `Type`
        public var attributes: Attributes
        public var relationships: Relationships?

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case gameCenterLeaderboards
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var defaultFormatter: GameCenterLeaderboardFormatter
            public var referenceName: String
            public var vendorIdentifier: String
            public var submissionType: SubmissionType
            public var scoreSortType: ScoreSortType
            public var scoreRangeStart: String?
            public var scoreRangeEnd: String?
            public var recurrenceStartDate: Date?
            public var recurrenceDuration: String?
            public var recurrenceRule: String?

            public enum SubmissionType: String, CaseIterable, Codable, Sendable {
                case bestScore = "BEST_SCORE"
                case mostRecentScore = "MOST_RECENT_SCORE"
            }

            public enum ScoreSortType: String, CaseIterable, Codable, Sendable {
                case asc = "ASC"
                case desc = "DESC"
            }

            public init(defaultFormatter: GameCenterLeaderboardFormatter, referenceName: String, vendorIdentifier: String, submissionType: SubmissionType, scoreSortType: ScoreSortType, scoreRangeStart: String? = nil, scoreRangeEnd: String? = nil, recurrenceStartDate: Date? = nil, recurrenceDuration: String? = nil, recurrenceRule: String? = nil) {
                self.defaultFormatter = defaultFormatter
                self.referenceName = referenceName
                self.vendorIdentifier = vendorIdentifier
                self.submissionType = submissionType
                self.scoreSortType = scoreSortType
                self.scoreRangeStart = scoreRangeStart
                self.scoreRangeEnd = scoreRangeEnd
                self.recurrenceStartDate = recurrenceStartDate
                self.recurrenceDuration = recurrenceDuration
                self.recurrenceRule = recurrenceRule
            }
        }

        public struct Relationships: Codable, Equatable, Sendable {
            public var gameCenterDetail: GameCenterDetail?
            public var gameCenterGroup: GameCenterGroup?
            public var gameCenterLeaderboardSets: GameCenterLeaderboardSets?

            public struct GameCenterDetail: Codable, Equatable, Sendable {
                public var data: Data?

                public struct Data: Codable, Equatable, Identifiable, Sendable {
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

                public init(data: Data? = nil) {
                    self.data = data
                }
            }

            public struct GameCenterGroup: Codable, Equatable, Sendable {
                public var data: Data?

                public struct Data: Codable, Equatable, Identifiable, Sendable {
                    public var type: `Type`
                    public var id: String

                    public enum `Type`: String, CaseIterable, Codable, Sendable {
                        case gameCenterGroups
                    }

                    public init(type: `Type` = .gameCenterGroups, id: String) {
                        self.type = type
                        self.id = id
                    }
                }

                public init(data: Data? = nil) {
                    self.data = data
                }
            }

            public struct GameCenterLeaderboardSets: Codable, Equatable, Sendable {
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

                public init(data: [Datum]? = nil) {
                    self.data = data
                }
            }

            public init(gameCenterDetail: GameCenterDetail? = nil, gameCenterGroup: GameCenterGroup? = nil, gameCenterLeaderboardSets: GameCenterLeaderboardSets? = nil) {
                self.gameCenterDetail = gameCenterDetail
                self.gameCenterGroup = gameCenterGroup
                self.gameCenterLeaderboardSets = gameCenterLeaderboardSets
            }
        }

        public init(type: `Type` = .gameCenterLeaderboards, attributes: Attributes, relationships: Relationships? = nil) {
            self.type = type
            self.attributes = attributes
            self.relationships = relationships
        }
    }

    public init(data: Data) {
        self.data = data
    }
}