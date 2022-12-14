// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.Builds.WithID.Relationships {
    public var appStoreVersion: AppStoreVersion {
        AppStoreVersion(path: path + "/appStoreVersion")
    }

    public struct AppStoreVersion {
        /// Path: `/v1/builds/{id}/relationships/appStoreVersion`
        public let path: String
    }
}
