// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1 {
    public var ciXcodeVersions: CiXcodeVersions {
        CiXcodeVersions(path: path + "/ciXcodeVersions")
    }

    public struct CiXcodeVersions {
        /// Path: `/v1/ciXcodeVersions`
        public let path: String

        public func get(fieldsCiXcodeVersions: [FieldsCiXcodeVersions]? = nil, limit: Int? = nil, include: [Include]? = nil, fieldsCiMacOsVersions: [FieldsCiMacOsVersions]? = nil, limitMacOsVersions: Int? = nil) -> Request<AppStoreAPI.CiXcodeVersionsResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsCiXcodeVersions, limit, include, fieldsCiMacOsVersions, limitMacOsVersions), id: "ciXcodeVersions-get_collection")
        }

        private func makeGetQuery(_ fieldsCiXcodeVersions: [FieldsCiXcodeVersions]?, _ limit: Int?, _ include: [Include]?, _ fieldsCiMacOsVersions: [FieldsCiMacOsVersions]?, _ limitMacOsVersions: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsCiXcodeVersions, forKey: "fields[ciXcodeVersions]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(include, forKey: "include")
            encoder.encode(fieldsCiMacOsVersions, forKey: "fields[ciMacOsVersions]")
            encoder.encode(limitMacOsVersions, forKey: "limit[macOsVersions]")
            return encoder.items
        }

        public enum FieldsCiXcodeVersions: String, CaseIterable, Codable, Sendable {
            case macOsVersions
            case name
            case testDestinations
            case version
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case macOsVersions
        }

        public enum FieldsCiMacOsVersions: String, CaseIterable, Codable, Sendable {
            case name
            case version
            case xcodeVersions
        }
    }
}