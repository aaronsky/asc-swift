// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct GameCenterChallengeVersionCreateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Sendable {
        public var type: `Type`
        public var relationships: Relationships

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case gameCenterChallengeVersions
        }

        public struct Relationships: Codable, Equatable, Sendable {
            public var challenge: Challenge

            public struct Challenge: Codable, Equatable, Sendable {
                public var data: Data

                public struct Data: Codable, Equatable, Identifiable, Sendable {
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

                public init(data: Data) {
                    self.data = data
                }
            }

            public init(challenge: Challenge) {
                self.challenge = challenge
            }
        }

        public init(type: `Type` = .gameCenterChallengeVersions, relationships: Relationships) {
            self.type = type
            self.relationships = relationships
        }
    }

    public init(data: Data) {
        self.data = data
    }
}
