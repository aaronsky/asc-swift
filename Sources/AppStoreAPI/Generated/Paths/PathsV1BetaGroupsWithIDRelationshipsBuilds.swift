// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.BetaGroups.WithID.Relationships {
    public var builds: Builds {
        Builds(path: path + "/builds")
    }

    public struct Builds {
        /// Path: `/v1/betaGroups/{id}/relationships/builds`
        public let path: String

        public func get(limit: Int? = nil) -> Request<AppStoreAPI.BetaGroupBuildsLinkagesResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(limit), id: "betaGroups-builds-get_to_many_relationship")
        }

        private func makeGetQuery(_ limit: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(limit, forKey: "limit")
            return encoder.items
        }

        public func post(_ body: AppStoreAPI.BetaGroupBuildsLinkagesRequest) -> Request<Void> {
            Request(path: path, method: "POST", body: body, id: "betaGroups-builds-create_to_many_relationship")
        }

        public func delete(_ body: AppStoreAPI.BetaGroupBuildsLinkagesRequest) -> Request<Void> {
            Request(path: path, method: "DELETE", body: body, id: "betaGroups-builds-delete_to_many_relationship")
        }
    }
}