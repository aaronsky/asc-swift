// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.Profiles.WithID {
    public var certificates: Certificates {
        Certificates(path: path + "/certificates")
    }

    public struct Certificates {
        /// Path: `/v1/profiles/{id}/certificates`
        public let path: String

        /// List All Certificates in a Profile
        public func get(fieldsCertificates: [FieldsCertificates]? = nil, limit: Int? = nil) -> Request<EnterpriseAPI.CertificatesWithoutIncludesResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsCertificates, limit), id: "profiles-certificates-get_to_many_related")
        }

        private func makeGetQuery(_ fieldsCertificates: [FieldsCertificates]?, _ limit: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(fieldsCertificates, forKey: "fields[certificates]", explode: false)
            encoder.encode(limit, forKey: "limit")
            return encoder.items
        }

        public enum FieldsCertificates: String, CaseIterable, Codable, Sendable {
            case certificateContent
            case certificateType
            case csrContent
            case displayName
            case expirationDate
            case name
            case passTypeID = "passTypeId"
            case platform
            case serialNumber
        }
    }
}
