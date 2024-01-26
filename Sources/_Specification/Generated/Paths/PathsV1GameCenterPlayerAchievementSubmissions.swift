// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1 {
    public var gameCenterPlayerAchievementSubmissions: GameCenterPlayerAchievementSubmissions {
        GameCenterPlayerAchievementSubmissions(path: path + "/gameCenterPlayerAchievementSubmissions")
    }

    public struct GameCenterPlayerAchievementSubmissions {
        /// Path: `/v1/gameCenterPlayerAchievementSubmissions`
        public let path: String

        public func post(_ body: _Specification.GameCenterPlayerAchievementSubmissionCreateRequest) -> Request<_Specification.GameCenterPlayerAchievementSubmissionResponse> {
            Request(path: path, method: "POST", body: body, id: "gameCenterPlayerAchievementSubmissions-create_instance")
        }
    }
}