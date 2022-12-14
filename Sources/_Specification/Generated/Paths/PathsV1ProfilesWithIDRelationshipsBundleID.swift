// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.Profiles.WithID.Relationships {
    public var bundleID: BundleID {
        BundleID(path: path + "/bundleId")
    }

    public struct BundleID {
        /// Path: `/v1/profiles/{id}/relationships/bundleId`
        public let path: String
    }
}
