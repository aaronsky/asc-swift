// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.GameCenterAppVersions.WithID.Relationships {
    public var appStoreVersion: AppStoreVersion {
        AppStoreVersion(path: path + "/appStoreVersion")
    }

    public struct AppStoreVersion {
        /// Path: `/v1/gameCenterAppVersions/{id}/relationships/appStoreVersion`
        public let path: String

        public var get: Request<AppStoreAPI.GameCenterAppVersionAppStoreVersionLinkageResponse> {
            Request(path: path, method: "GET", id: "gameCenterAppVersions_appStoreVersion_getToOneRelationship")
        }
    }
}
