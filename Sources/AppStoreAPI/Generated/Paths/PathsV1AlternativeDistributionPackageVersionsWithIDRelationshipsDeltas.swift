// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.AlternativeDistributionPackageVersions.WithID.Relationships {
    public var deltas: Deltas {
        Deltas(path: path + "/deltas")
    }

    public struct Deltas {
        /// Path: `/v1/alternativeDistributionPackageVersions/{id}/relationships/deltas`
        public let path: String

        public func get(limit: Int? = nil) -> Request<AppStoreAPI.AlternativeDistributionPackageVersionDeltasLinkagesResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(limit), id: "alternativeDistributionPackageVersions_deltas_getToManyRelationship")
        }

        private func makeGetQuery(_ limit: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(limit, forKey: "limit")
            return encoder.items
        }
    }
}
