// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.Subscriptions.WithID.Relationships {
    public var pricePoints: PricePoints {
        PricePoints(path: path + "/pricePoints")
    }

    public struct PricePoints {
        /// Path: `/v1/subscriptions/{id}/relationships/pricePoints`
        public let path: String
    }
}
