// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct GameCenterLeaderboardSetReleaseCreateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Sendable {
        public var type: `Type`
        public var relationships: Relationships

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case gameCenterLeaderboardSetReleases
        }

        public struct Relationships: Codable, Equatable, Sendable {
            public var gameCenterDetail: GameCenterDetail
            public var gameCenterLeaderboardSet: GameCenterLeaderboardSet

            public struct GameCenterDetail: Codable, Equatable, Sendable {
                public var data: Data

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

                public init(data: Data) {
                    self.data = data
                }
            }

            public struct GameCenterLeaderboardSet: Codable, Equatable, Sendable {
                public var data: Data

                public struct Data: Codable, Equatable, Identifiable, Sendable {
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

                public init(data: Data) {
                    self.data = data
                }
            }

            public init(gameCenterDetail: GameCenterDetail, gameCenterLeaderboardSet: GameCenterLeaderboardSet) {
                self.gameCenterDetail = gameCenterDetail
                self.gameCenterLeaderboardSet = gameCenterLeaderboardSet
            }
        }

        public init(type: `Type` = .gameCenterLeaderboardSetReleases, relationships: Relationships) {
            self.type = type
            self.relationships = relationships
        }
    }

    public init(data: Data) {
        self.data = data
    }
}