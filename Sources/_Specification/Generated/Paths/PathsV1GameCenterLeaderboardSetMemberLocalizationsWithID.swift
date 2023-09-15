// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.GameCenterLeaderboardSetMemberLocalizations {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/gameCenterLeaderboardSetMemberLocalizations/{id}`
        public let path: String

        public func patch(_ body: _Specification.GameCenterLeaderboardSetMemberLocalizationUpdateRequest) -> Request<_Specification.GameCenterLeaderboardSetMemberLocalizationResponse> {
            Request(path: path, method: "PATCH", body: body, id: "gameCenterLeaderboardSetMemberLocalizations-update_instance")
        }

        public var delete: Request<Void> {
            Request(path: path, method: "DELETE", id: "gameCenterLeaderboardSetMemberLocalizations-delete_instance")
        }
    }
}