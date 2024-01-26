// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct GameCenterMatchmakingTestPlayerPropertyInlineCreate: Codable, Equatable, Identifiable {
    public var type: `Type`
    public var id: String?
    public var attributes: Attributes

    public enum `Type`: String, Codable, CaseIterable {
        case gameCenterMatchmakingTestPlayerProperties
    }

    public struct Attributes: Codable, Equatable {
        public var playerID: String
        public var properties: [Property]?

        public init(playerID: String, properties: [Property]? = nil) {
            self.playerID = playerID
            self.properties = properties
        }

        private enum CodingKeys: String, CodingKey {
            case playerID = "playerId"
            case properties
        }
    }

    public init(type: `Type`, id: String? = nil, attributes: Attributes) {
        self.type = type
        self.id = id
        self.attributes = attributes
    }
}