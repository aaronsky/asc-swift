// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.GameCenterGroups.WithID.Relationships {
    public var gameCenterAchievements: GameCenterAchievements {
        GameCenterAchievements(path: path + "/gameCenterAchievements")
    }

    public struct GameCenterAchievements {
        /// Path: `/v1/gameCenterGroups/{id}/relationships/gameCenterAchievements`
        public let path: String

        public func get(limit: Int? = nil) -> Request<AppStoreAPI.GameCenterGroupGameCenterAchievementsLinkagesResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(limit), id: "gameCenterGroups_gameCenterAchievements_getToManyRelationship")
        }

        private func makeGetQuery(_ limit: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(limit, forKey: "limit")
            return encoder.items
        }

        public func patch(_ body: AppStoreAPI.GameCenterGroupGameCenterAchievementsLinkagesRequest) -> Request<Void> {
            Request(path: path, method: "PATCH", body: body, id: "gameCenterGroups_gameCenterAchievements_replaceToManyRelationship")
        }
    }
}
