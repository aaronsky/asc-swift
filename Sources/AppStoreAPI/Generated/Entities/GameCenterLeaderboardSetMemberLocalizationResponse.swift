// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct GameCenterLeaderboardSetMemberLocalizationResponse: Codable, Equatable, Sendable {
    /// GameCenterLeaderboardSetMemberLocalization
    public var data: GameCenterLeaderboardSetMemberLocalization
    public var included: [IncludedItem]?
    public var links: DocumentLinks

    public enum IncludedItem: Codable, Equatable, Sendable {
        case gameCenterLeaderboardSet(GameCenterLeaderboardSet)
        case gameCenterLeaderboard(GameCenterLeaderboard)

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let value = try? container.decode(GameCenterLeaderboardSet.self) {
                self = .gameCenterLeaderboardSet(value)
            } else if let value = try? container.decode(GameCenterLeaderboard.self) {
                self = .gameCenterLeaderboard(value)
            } else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Data could not be decoded as any of the expected types (GameCenterLeaderboardSet, GameCenterLeaderboard)."
                )
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .gameCenterLeaderboardSet(let value): try container.encode(value)
            case .gameCenterLeaderboard(let value): try container.encode(value)
            }
        }
    }

    public init(data: GameCenterLeaderboardSetMemberLocalization, included: [IncludedItem]? = nil, links: DocumentLinks) {
        self.data = data
        self.included = included
        self.links = links
    }
}