// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.Certificates {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/certificates/{id}`
        public let path: String

        public func get(fieldsCertificates: [FieldsCertificates]? = nil) -> Request<AppStoreAPI.CertificateResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsCertificates), id: "certificates-get_instance")
        }

        private func makeGetQuery(_ fieldsCertificates: [FieldsCertificates]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(fieldsCertificates, forKey: "fields[certificates]", explode: false)
            return encoder.items
        }

        public enum FieldsCertificates: String, CaseIterable, Codable, Sendable {
            case certificateContent
            case certificateType
            case csrContent
            case displayName
            case expirationDate
            case name
            case platform
            case serialNumber
        }

        public var delete: Request<Void> {
            Request(path: path, method: "DELETE", id: "certificates-delete_instance")
        }
    }
}