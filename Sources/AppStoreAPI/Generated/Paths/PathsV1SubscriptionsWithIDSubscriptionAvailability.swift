// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.Subscriptions.WithID {
    public var subscriptionAvailability: SubscriptionAvailability {
        SubscriptionAvailability(path: path + "/subscriptionAvailability")
    }

    public struct SubscriptionAvailability {
        /// Path: `/v1/subscriptions/{id}/subscriptionAvailability`
        public let path: String

        public func get(fieldsSubscriptionAvailabilities: [FieldsSubscriptionAvailabilities]? = nil, fieldsSubscriptions: [FieldsSubscriptions]? = nil, fieldsTerritories: [FieldsTerritories]? = nil, limitAvailableTerritories: Int? = nil, include: [Include]? = nil) -> Request<AppStoreAPI.SubscriptionAvailabilityResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsSubscriptionAvailabilities, fieldsSubscriptions, fieldsTerritories, limitAvailableTerritories, include), id: "subscriptions-subscriptionAvailability-get_to_one_related")
        }

        private func makeGetQuery(_ fieldsSubscriptionAvailabilities: [FieldsSubscriptionAvailabilities]?, _ fieldsSubscriptions: [FieldsSubscriptions]?, _ fieldsTerritories: [FieldsTerritories]?, _ limitAvailableTerritories: Int?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsSubscriptionAvailabilities, forKey: "fields[subscriptionAvailabilities]")
            encoder.encode(fieldsSubscriptions, forKey: "fields[subscriptions]")
            encoder.encode(fieldsTerritories, forKey: "fields[territories]")
            encoder.encode(limitAvailableTerritories, forKey: "limit[availableTerritories]")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsSubscriptionAvailabilities: String, CaseIterable, Codable, Sendable {
            case availableInNewTerritories
            case availableTerritories
            case subscription
        }

        public enum FieldsSubscriptions: String, CaseIterable, Codable, Sendable {
            case appStoreReviewScreenshot
            case familySharable
            case group
            case groupLevel
            case introductoryOffers
            case name
            case offerCodes
            case pricePoints
            case prices
            case productID = "productId"
            case promotedPurchase
            case promotionalOffers
            case reviewNote
            case state
            case subscriptionAvailability
            case subscriptionLocalizations
            case subscriptionPeriod
        }

        public enum FieldsTerritories: String, CaseIterable, Codable, Sendable {
            case currency
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case availableTerritories
            case subscription
        }
    }
}