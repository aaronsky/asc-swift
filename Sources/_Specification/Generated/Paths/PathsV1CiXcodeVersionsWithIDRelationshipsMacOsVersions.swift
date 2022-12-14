// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.CiXcodeVersions.WithID.Relationships {
    public var macOsVersions: MacOsVersions {
        MacOsVersions(path: path + "/macOsVersions")
    }

    public struct MacOsVersions {
        /// Path: `/v1/ciXcodeVersions/{id}/relationships/macOsVersions`
        public let path: String
    }
}
