// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.AlternativeDistributionDomains {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/alternativeDistributionDomains/{id}`
        public let path: String

        public func get(fieldsAlternativeDistributionDomains: [FieldsAlternativeDistributionDomains]? = nil) -> Request<_Specification.AlternativeDistributionDomainResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsAlternativeDistributionDomains), id: "alternativeDistributionDomains-get_instance")
        }

        private func makeGetQuery(_ fieldsAlternativeDistributionDomains: [FieldsAlternativeDistributionDomains]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(fieldsAlternativeDistributionDomains, forKey: "fields[alternativeDistributionDomains]", explode: false)
            return encoder.items
        }

        public enum FieldsAlternativeDistributionDomains: String, CaseIterable, Codable, Sendable {
            case createdDate
            case domain
            case referenceName
        }

        public var delete: Request<Void> {
            Request(path: path, method: "DELETE", id: "alternativeDistributionDomains-delete_instance")
        }
    }
}