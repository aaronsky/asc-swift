// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V2.InAppPurchases.WithID.Relationships {
    public var inAppPurchaseLocalizations: InAppPurchaseLocalizations {
        InAppPurchaseLocalizations(path: path + "/inAppPurchaseLocalizations")
    }

    public struct InAppPurchaseLocalizations {
        /// Path: `/v2/inAppPurchases/{id}/relationships/inAppPurchaseLocalizations`
        public let path: String

        public func get(limit: Int? = nil) -> Request<AppStoreAPI.InAppPurchaseV2InAppPurchaseLocalizationsLinkagesResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(limit), id: "inAppPurchasesV2_inAppPurchaseLocalizations_getToManyRelationship")
        }

        private func makeGetQuery(_ limit: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(limit, forKey: "limit")
            return encoder.items
        }
    }
}
