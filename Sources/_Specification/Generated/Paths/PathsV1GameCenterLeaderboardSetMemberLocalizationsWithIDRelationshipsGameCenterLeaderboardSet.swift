// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.GameCenterLeaderboardSetMemberLocalizations.WithID.Relationships {
    public var gameCenterLeaderboardSet: GameCenterLeaderboardSet {
        GameCenterLeaderboardSet(path: path + "/gameCenterLeaderboardSet")
    }

    public struct GameCenterLeaderboardSet {
        /// Path: `/v1/gameCenterLeaderboardSetMemberLocalizations/{id}/relationships/gameCenterLeaderboardSet`
        public let path: String
    }
}