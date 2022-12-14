// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V2.InAppPurchases.WithID.Relationships {
    public var promotedPurchase: PromotedPurchase {
        PromotedPurchase(path: path + "/promotedPurchase")
    }

    public struct PromotedPurchase {
        /// Path: `/v2/inAppPurchases/{id}/relationships/promotedPurchase`
        public let path: String
    }
}
