// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct GameCenterLeaderboardLocalizationCreateRequest: Codable, Hashable {
    public var data: Data

    public struct Data: Codable, Hashable {
        public var type: `Type`
        public var attributes: Attributes
        public var relationships: Relationships

        public enum `Type`: String, Codable, CaseIterable {
            case gameCenterLeaderboardLocalizations
        }

        public struct Attributes: Codable, Hashable {
            public var locale: String
            public var name: String
            public var formatterOverride: GameCenterLeaderboardFormatter?
            public var formatterSuffix: String?
            public var formatterSuffixSingular: String?

            public init(locale: String, name: String, formatterOverride: GameCenterLeaderboardFormatter? = nil, formatterSuffix: String? = nil, formatterSuffixSingular: String? = nil) {
                self.locale = locale
                self.name = name
                self.formatterOverride = formatterOverride
                self.formatterSuffix = formatterSuffix
                self.formatterSuffixSingular = formatterSuffixSingular
            }
        }

        public struct Relationships: Codable, Hashable {
            public var gameCenterLeaderboard: GameCenterLeaderboard

            public struct GameCenterLeaderboard: Codable, Hashable {
                public var data: Data

                public struct Data: Codable, Hashable, Identifiable {
                    public var type: `Type`
                    public var id: String

                    public enum `Type`: String, Codable, CaseIterable {
                        case gameCenterLeaderboards
                    }

                    public init(type: `Type`, id: String) {
                        self.type = type
                        self.id = id
                    }
                }

                public init(data: Data) {
                    self.data = data
                }
            }

            public init(gameCenterLeaderboard: GameCenterLeaderboard) {
                self.gameCenterLeaderboard = gameCenterLeaderboard
            }
        }

        public init(type: `Type`, attributes: Attributes, relationships: Relationships) {
            self.type = type
            self.attributes = attributes
            self.relationships = relationships
        }
    }

    public init(data: Data) {
        self.data = data
    }
}