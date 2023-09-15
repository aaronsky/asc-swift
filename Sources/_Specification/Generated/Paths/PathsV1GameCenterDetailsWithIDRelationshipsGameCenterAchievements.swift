// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.GameCenterDetails.WithID.Relationships {
    public var gameCenterAchievements: GameCenterAchievements {
        GameCenterAchievements(path: path + "/gameCenterAchievements")
    }

    public struct GameCenterAchievements {
        /// Path: `/v1/gameCenterDetails/{id}/relationships/gameCenterAchievements`
        public let path: String

        public func get(limit: Int? = nil) -> Request<_Specification.GameCenterDetailGameCenterAchievementsLinkagesResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(limit), id: "gameCenterDetails-gameCenterAchievements-get_to_many_relationship")
        }

        private func makeGetQuery(_ limit: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(limit, forKey: "limit")
            return encoder.items
        }

        public func patch(_ body: _Specification.GameCenterDetailGameCenterAchievementsLinkagesRequest) -> Request<Void> {
            Request(path: path, method: "PATCH", body: body, id: "gameCenterDetails-gameCenterAchievements-replace_to_many_relationship")
        }
    }
}