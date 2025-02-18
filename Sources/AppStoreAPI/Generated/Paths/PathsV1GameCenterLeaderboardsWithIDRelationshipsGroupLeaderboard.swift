// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.GameCenterLeaderboards.WithID.Relationships {
    public var groupLeaderboard: GroupLeaderboard {
        GroupLeaderboard(path: path + "/groupLeaderboard")
    }

    public struct GroupLeaderboard {
        /// Path: `/v1/gameCenterLeaderboards/{id}/relationships/groupLeaderboard`
        public let path: String

        public var get: Request<AppStoreAPI.GameCenterLeaderboardGroupLeaderboardLinkageResponse> {
            Request(path: path, method: "GET", id: "gameCenterLeaderboards_groupLeaderboard_getToOneRelationship")
        }

        public func patch(_ body: AppStoreAPI.GameCenterLeaderboardGroupLeaderboardLinkageRequest) -> Request<Void> {
            Request(path: path, method: "PATCH", body: body, id: "gameCenterLeaderboards_groupLeaderboard_updateToOneRelationship")
        }
    }
}
