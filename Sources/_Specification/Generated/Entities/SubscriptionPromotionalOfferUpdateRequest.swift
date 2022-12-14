// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct SubscriptionPromotionalOfferUpdateRequest: Codable, Hashable {
    public var data: Data
    public var included: [SubscriptionPromotionalOfferPriceInlineCreate]?

    public struct Data: Codable, Hashable, Identifiable {
        public var type: `Type`
        public var id: String
        public var relationships: Relationships?

        public enum `Type`: String, Codable, CaseIterable {
            case subscriptionPromotionalOffers
        }

        public struct Relationships: Codable, Hashable {
            public var prices: Prices?

            public struct Prices: Codable, Hashable {
                public var data: [Datum]?

                public struct Datum: Codable, Hashable, Identifiable {
                    public var type: `Type`
                    public var id: String

                    public enum `Type`: String, Codable, CaseIterable {
                        case subscriptionPromotionalOfferPrices
                    }

                    public init(type: `Type`, id: String) {
                        self.type = type
                        self.id = id
                    }
                }

                public init(data: [Datum]? = nil) {
                    self.data = data
                }
            }

            public init(prices: Prices? = nil) {
                self.prices = prices
            }
        }

        public init(type: `Type`, id: String, relationships: Relationships? = nil) {
            self.type = type
            self.id = id
            self.relationships = relationships
        }
    }

    public init(data: Data, included: [SubscriptionPromotionalOfferPriceInlineCreate]? = nil) {
        self.data = data
        self.included = included
    }
}
