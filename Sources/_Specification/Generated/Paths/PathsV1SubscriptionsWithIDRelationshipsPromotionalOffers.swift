// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.Subscriptions.WithID.Relationships {
    public var promotionalOffers: PromotionalOffers {
        PromotionalOffers(path: path + "/promotionalOffers")
    }

    public struct PromotionalOffers {
        /// Path: `/v1/subscriptions/{id}/relationships/promotionalOffers`
        public let path: String
    }
}
