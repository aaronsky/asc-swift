// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1 {
    public var gameCenterEnabledVersions: GameCenterEnabledVersions {
        GameCenterEnabledVersions(path: path + "/gameCenterEnabledVersions")
    }

    public struct GameCenterEnabledVersions {
        /// Path: `/v1/gameCenterEnabledVersions`
        public let path: String
    }
}
