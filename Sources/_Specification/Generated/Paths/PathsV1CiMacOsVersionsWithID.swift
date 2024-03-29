// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.CiMacOsVersions {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/ciMacOsVersions/{id}`
        public let path: String

        public func get(fieldsCiMacOsVersions: [FieldsCiMacOsVersions]? = nil, include: [Include]? = nil, fieldsCiXcodeVersions: [FieldsCiXcodeVersions]? = nil, limitXcodeVersions: Int? = nil) -> Request<_Specification.CiMacOsVersionResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsCiMacOsVersions, include, fieldsCiXcodeVersions, limitXcodeVersions), id: "ciMacOsVersions-get_instance")
        }

        private func makeGetQuery(_ fieldsCiMacOsVersions: [FieldsCiMacOsVersions]?, _ include: [Include]?, _ fieldsCiXcodeVersions: [FieldsCiXcodeVersions]?, _ limitXcodeVersions: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsCiMacOsVersions, forKey: "fields[ciMacOsVersions]")
            encoder.encode(include, forKey: "include")
            encoder.encode(fieldsCiXcodeVersions, forKey: "fields[ciXcodeVersions]")
            encoder.encode(limitXcodeVersions, forKey: "limit[xcodeVersions]")
            return encoder.items
        }

        public enum FieldsCiMacOsVersions: String, CaseIterable, Codable, Sendable {
            case name
            case version
            case xcodeVersions
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case xcodeVersions
        }

        public enum FieldsCiXcodeVersions: String, CaseIterable, Codable, Sendable {
            case macOsVersions
            case name
            case testDestinations
            case version
        }
    }
}
