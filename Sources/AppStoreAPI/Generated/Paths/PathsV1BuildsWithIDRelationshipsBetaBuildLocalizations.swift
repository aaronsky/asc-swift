// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.Builds.WithID.Relationships {
    public var betaBuildLocalizations: BetaBuildLocalizations {
        BetaBuildLocalizations(path: path + "/betaBuildLocalizations")
    }

    public struct BetaBuildLocalizations {
        /// Path: `/v1/builds/{id}/relationships/betaBuildLocalizations`
        public let path: String

        public func get(limit: Int? = nil) -> Request<AppStoreAPI.BuildBetaBuildLocalizationsLinkagesResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(limit), id: "builds_betaBuildLocalizations_getToManyRelationship")
        }

        private func makeGetQuery(_ limit: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(limit, forKey: "limit")
            return encoder.items
        }
    }
}
