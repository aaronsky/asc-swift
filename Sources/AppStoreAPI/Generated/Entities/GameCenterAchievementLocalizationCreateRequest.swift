// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct GameCenterAchievementLocalizationCreateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Sendable {
        public var type: `Type`
        public var attributes: Attributes
        public var relationships: Relationships

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case gameCenterAchievementLocalizations
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var locale: String
            public var name: String
            public var beforeEarnedDescription: String
            public var afterEarnedDescription: String

            public init(locale: String, name: String, beforeEarnedDescription: String, afterEarnedDescription: String) {
                self.locale = locale
                self.name = name
                self.beforeEarnedDescription = beforeEarnedDescription
                self.afterEarnedDescription = afterEarnedDescription
            }
        }

        public struct Relationships: Codable, Equatable, Sendable {
            public var gameCenterAchievement: GameCenterAchievement

            public struct GameCenterAchievement: Codable, Equatable, Sendable {
                public var data: Data

                public struct Data: Codable, Equatable, Identifiable, Sendable {
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

                public init(data: Data) {
                    self.data = data
                }
            }

            public init(gameCenterAchievement: GameCenterAchievement) {
                self.gameCenterAchievement = gameCenterAchievement
            }
        }

        public init(type: `Type` = .gameCenterAchievementLocalizations, attributes: Attributes, relationships: Relationships) {
            self.type = type
            self.attributes = attributes
            self.relationships = relationships
        }
    }

    public init(data: Data) {
        self.data = data
    }
}