// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.CiProducts.WithID.Relationships {
    public var additionalRepositories: AdditionalRepositories {
        AdditionalRepositories(path: path + "/additionalRepositories")
    }

    public struct AdditionalRepositories {
        /// Path: `/v1/ciProducts/{id}/relationships/additionalRepositories`
        public let path: String

        public func get(limit: Int? = nil) -> Request<AppStoreAPI.CiProductAdditionalRepositoriesLinkagesResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(limit), id: "ciProducts_additionalRepositories_getToManyRelationship")
        }

        private func makeGetQuery(_ limit: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(limit, forKey: "limit")
            return encoder.items
        }
    }
}
