// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.AlternativeDistributionPackageVersions.WithID {
    public var deltas: Deltas {
        Deltas(path: path + "/deltas")
    }

    public struct Deltas {
        /// Path: `/v1/alternativeDistributionPackageVersions/{id}/deltas`
        public let path: String

        public func get(fieldsAlternativeDistributionPackageDeltas: [FieldsAlternativeDistributionPackageDeltas]? = nil, limit: Int? = nil) -> Request<_Specification.AlternativeDistributionPackageDeltasResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsAlternativeDistributionPackageDeltas, limit), id: "alternativeDistributionPackageVersions-deltas-get_to_many_related")
        }

        private func makeGetQuery(_ fieldsAlternativeDistributionPackageDeltas: [FieldsAlternativeDistributionPackageDeltas]?, _ limit: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(fieldsAlternativeDistributionPackageDeltas, forKey: "fields[alternativeDistributionPackageDeltas]", explode: false)
            encoder.encode(limit, forKey: "limit")
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
