// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.GameCenterLeaderboardSetLocalizations.WithID.Relationships {
    public var gameCenterLeaderboardSetImage: GameCenterLeaderboardSetImage {
        GameCenterLeaderboardSetImage(path: path + "/gameCenterLeaderboardSetImage")
    }

    public struct GameCenterLeaderboardSetImage {
        /// Path: `/v1/gameCenterLeaderboardSetLocalizations/{id}/relationships/gameCenterLeaderboardSetImage`
        public let path: String
    }
}