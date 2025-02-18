// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.WinBackOffers.WithID {
    public var prices: Prices {
        Prices(path: path + "/prices")
    }

    public struct Prices {
        /// Path: `/v1/winBackOffers/{id}/prices`
        public let path: String

        public func get(filterTerritory: [String]? = nil, fieldsWinBackOfferPrices: [FieldsWinBackOfferPrices]? = nil, fieldsTerritories: [FieldsTerritories]? = nil, fieldsSubscriptionPricePoints: [FieldsSubscriptionPricePoints]? = nil, limit: Int? = nil, include: [Include]? = nil) -> Request<AppStoreAPI.WinBackOfferPricesResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(filterTerritory, fieldsWinBackOfferPrices, fieldsTerritories, fieldsSubscriptionPricePoints, limit, include), id: "winBackOffers_prices_getToManyRelated")
        }

        private func makeGetQuery(_ filterTerritory: [String]?, _ fieldsWinBackOfferPrices: [FieldsWinBackOfferPrices]?, _ fieldsTerritories: [FieldsTerritories]?, _ fieldsSubscriptionPricePoints: [FieldsSubscriptionPricePoints]?, _ limit: Int?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(filterTerritory, forKey: "filter[territory]")
            encoder.encode(fieldsWinBackOfferPrices, forKey: "fields[winBackOfferPrices]")
            encoder.encode(fieldsTerritories, forKey: "fields[territories]")
            encoder.encode(fieldsSubscriptionPricePoints, forKey: "fields[subscriptionPricePoints]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsWinBackOfferPrices: String, CaseIterable, Codable, Sendable {
            case territory
            case subscriptionPricePoint
        }

        public enum FieldsTerritories: String, CaseIterable, Codable, Sendable {
            case currency
        }

        public enum FieldsSubscriptionPricePoints: String, CaseIterable, Codable, Sendable {
            case customerPrice
            case proceeds
            case proceedsYear2
            case territory
            case equalizations
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case territory
            case subscriptionPricePoint
        }
    }
}
