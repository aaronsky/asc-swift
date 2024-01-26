// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.GameCenterMatchmakingTeams {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/gameCenterMatchmakingTeams/{id}`
        public let path: String

        public func patch(_ body: _Specification.GameCenterMatchmakingTeamUpdateRequest) -> Request<_Specification.GameCenterMatchmakingTeamResponse> {
            Request(path: path, method: "PATCH", body: body, id: "gameCenterMatchmakingTeams-update_instance")
        }

        public var delete: Request<Void> {
            Request(path: path, method: "DELETE", id: "gameCenterMatchmakingTeams-delete_instance")
        }
    }
}