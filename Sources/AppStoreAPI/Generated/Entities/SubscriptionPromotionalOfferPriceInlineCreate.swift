// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct SubscriptionPromotionalOfferPriceInlineCreate: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String?
    public var relationships: Relationships?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case subscriptionPromotionalOfferPrices
    }

    public struct Relationships: Codable, Equatable, Sendable {
        public var territory: Territory?
        public var subscriptionPricePoint: SubscriptionPricePoint?

        public struct Territory: Codable, Equatable, Sendable {
            public var data: Data?

            public struct Data: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case territories
                }

                public init(type: `Type` = .territories, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(data: Data? = nil) {
                self.data = data
            }
        }

        public struct SubscriptionPricePoint: Codable, Equatable, Sendable {
            public var data: Data?

            public struct Data: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case subscriptionPricePoints
                }

                public init(type: `Type` = .subscriptionPricePoints, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(data: Data? = nil) {
                self.data = data
            }
        }

        public init(territory: Territory? = nil, subscriptionPricePoint: SubscriptionPricePoint? = nil) {
            self.territory = territory
            self.subscriptionPricePoint = subscriptionPricePoint
        }
    }

    public init(type: `Type` = .subscriptionPromotionalOfferPrices, id: String? = nil, relationships: Relationships? = nil) {
        self.type = type
        self.id = id
        self.relationships = relationships
    }
}