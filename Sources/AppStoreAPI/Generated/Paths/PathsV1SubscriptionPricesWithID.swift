// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.SubscriptionPrices {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/subscriptionPrices/{id}`
        public let path: String

        public var delete: Request<Void> {
            Request(path: path, method: "DELETE", id: "subscriptionPrices-delete_instance")
        }
    }
}