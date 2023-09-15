// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct GameCenterLeaderboardImageResponse: Codable, Hashable {
    /// GameCenterLeaderboardImage
    public var data: GameCenterLeaderboardImage
    public var included: [GameCenterLeaderboardLocalization]?
    public var links: DocumentLinks

    public init(data: GameCenterLeaderboardImage, included: [GameCenterLeaderboardLocalization]? = nil, links: DocumentLinks) {
        self.data = data
        self.included = included
        self.links = links
    }
}