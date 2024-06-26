// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.AlternativeDistributionPackageDeltas {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/alternativeDistributionPackageDeltas/{id}`
        public let path: String

        public func get(fieldsAlternativeDistributionPackageDeltas: [FieldsAlternativeDistributionPackageDeltas]? = nil) -> Request<_Specification.AlternativeDistributionPackageDeltaResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsAlternativeDistributionPackageDeltas), id: "alternativeDistributionPackageDeltas-get_instance")
        }

        private func makeGetQuery(_ fieldsAlternativeDistributionPackageDeltas: [FieldsAlternativeDistributionPackageDeltas]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(fieldsAlternativeDistributionPackageDeltas, forKey: "fields[alternativeDistributionPackageDeltas]", explode: false)
            return encoder.items
        }

        public enum FieldsAlternativeDistributionPackageDeltas: String, CaseIterable, Codable, Sendable {
            case alternativeDistributionKeyBlob
            case fileChecksum
            case url
            case urlExpirationDate
        }
    }
}
