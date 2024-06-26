// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1 {
    public var subscriptionPrices: SubscriptionPrices {
        SubscriptionPrices(path: path + "/subscriptionPrices")
    }

    public struct SubscriptionPrices {
        /// Path: `/v1/subscriptionPrices`
        public let path: String

        public func post(_ body: _Specification.SubscriptionPriceCreateRequest) -> Request<_Specification.SubscriptionPriceResponse> {
            Request(path: path, method: "POST", body: body, id: "subscriptionPrices-create_instance")
        }
    }
}
