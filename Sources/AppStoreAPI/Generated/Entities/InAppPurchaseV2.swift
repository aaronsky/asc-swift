// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct InAppPurchaseV2: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var relationships: Relationships?
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case inAppPurchases
    }

    public struct Attributes: Codable, Equatable, Sendable {
        public var name: String?
        public var productID: String?
        public var inAppPurchaseType: InAppPurchaseType?
        public var state: InAppPurchaseState?
        public var reviewNote: String?
        public var isFamilySharable: Bool?
        public var isContentHosting: Bool?

        public init(name: String? = nil, productID: String? = nil, inAppPurchaseType: InAppPurchaseType? = nil, state: InAppPurchaseState? = nil, reviewNote: String? = nil, isFamilySharable: Bool? = nil, isContentHosting: Bool? = nil) {
            self.name = name
            self.productID = productID
            self.inAppPurchaseType = inAppPurchaseType
            self.state = state
            self.reviewNote = reviewNote
            self.isFamilySharable = isFamilySharable
            self.isContentHosting = isContentHosting
        }

        private enum CodingKeys: String, CodingKey {
            case name
            case productID = "productId"
            case inAppPurchaseType
            case state
            case reviewNote
            case isFamilySharable = "familySharable"
            case isContentHosting = "contentHosting"
        }
    }

    public struct Relationships: Codable, Equatable, Sendable {
        public var inAppPurchaseLocalizations: InAppPurchaseLocalizations?
        public var pricePoints: PricePoints?
        public var content: Content?
        public var appStoreReviewScreenshot: AppStoreReviewScreenshot?
        public var promotedPurchase: PromotedPurchase?
        public var iapPriceSchedule: IapPriceSchedule?
        public var inAppPurchaseAvailability: InAppPurchaseAvailability?

        public struct InAppPurchaseLocalizations: Codable, Equatable, Sendable {
            public var links: Links?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Links: Codable, Equatable, Sendable {
                public var this: URL?
                public var related: URL?

                public init(this: URL? = nil, related: URL? = nil) {
                    self.this = this
                    self.related = related
                }

                private enum CodingKeys: String, CodingKey {
                    case this = "self"
                    case related
                }
            }

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case inAppPurchaseLocalizations
                }

                public init(type: `Type` = .inAppPurchaseLocalizations, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: Links? = nil, meta: PagingInformation? = nil, data: [Datum]? = nil) {
                self.links = links
                self.meta = meta
                self.data = data
            }
        }

        public struct PricePoints: Codable, Equatable, Sendable {
            public var links: Links?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Links: Codable, Equatable, Sendable {
                public var this: URL?
                public var related: URL?

                public init(this: URL? = nil, related: URL? = nil) {
                    self.this = this
                    self.related = related
                }

                private enum CodingKeys: String, CodingKey {
                    case this = "self"
                    case related
                }
            }

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case inAppPurchasePricePoints
                }

                public init(type: `Type` = .inAppPurchasePricePoints, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: Links? = nil, meta: PagingInformation? = nil, data: [Datum]? = nil) {
                self.links = links
                self.meta = meta
                self.data = data
            }
        }

        public struct Content: Codable, Equatable, Sendable {
            public var links: Links?
            public var data: Data?

            public struct Links: Codable, Equatable, Sendable {
                public var this: URL?
                public var related: URL?

                public init(this: URL? = nil, related: URL? = nil) {
                    self.this = this
                    self.related = related
                }

                private enum CodingKeys: String, CodingKey {
                    case this = "self"
                    case related
                }
            }

            public struct Data: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case inAppPurchaseContents
                }

                public init(type: `Type` = .inAppPurchaseContents, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: Links? = nil, data: Data? = nil) {
                self.links = links
                self.data = data
            }
        }

        public struct AppStoreReviewScreenshot: Codable, Equatable, Sendable {
            public var links: Links?
            public var data: Data?

            public struct Links: Codable, Equatable, Sendable {
                public var this: URL?
                public var related: URL?

                public init(this: URL? = nil, related: URL? = nil) {
                    self.this = this
                    self.related = related
                }

                private enum CodingKeys: String, CodingKey {
                    case this = "self"
                    case related
                }
            }

            public struct Data: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case inAppPurchaseAppStoreReviewScreenshots
                }

                public init(type: `Type` = .inAppPurchaseAppStoreReviewScreenshots, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: Links? = nil, data: Data? = nil) {
                self.links = links
                self.data = data
            }
        }

        public struct PromotedPurchase: Codable, Equatable, Sendable {
            public var links: Links?
            public var data: Data?

            public struct Links: Codable, Equatable, Sendable {
                public var this: URL?
                public var related: URL?

                public init(this: URL? = nil, related: URL? = nil) {
                    self.this = this
                    self.related = related
                }

                private enum CodingKeys: String, CodingKey {
                    case this = "self"
                    case related
                }
            }

            public struct Data: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case promotedPurchases
                }

                public init(type: `Type` = .promotedPurchases, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: Links? = nil, data: Data? = nil) {
                self.links = links
                self.data = data
            }
        }

        public struct IapPriceSchedule: Codable, Equatable, Sendable {
            public var links: Links?
            public var data: Data?

            public struct Links: Codable, Equatable, Sendable {
                public var this: URL?
                public var related: URL?

                public init(this: URL? = nil, related: URL? = nil) {
                    self.this = this
                    self.related = related
                }

                private enum CodingKeys: String, CodingKey {
                    case this = "self"
                    case related
                }
            }

            public struct Data: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case inAppPurchasePriceSchedules
                }

                public init(type: `Type` = .inAppPurchasePriceSchedules, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: Links? = nil, data: Data? = nil) {
                self.links = links
                self.data = data
            }
        }

        public struct InAppPurchaseAvailability: Codable, Equatable, Sendable {
            public var links: Links?
            public var data: Data?

            public struct Links: Codable, Equatable, Sendable {
                public var this: URL?
                public var related: URL?

                public init(this: URL? = nil, related: URL? = nil) {
                    self.this = this
                    self.related = related
                }

                private enum CodingKeys: String, CodingKey {
                    case this = "self"
                    case related
                }
            }

            public struct Data: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case inAppPurchaseAvailabilities
                }

                public init(type: `Type` = .inAppPurchaseAvailabilities, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: Links? = nil, data: Data? = nil) {
                self.links = links
                self.data = data
            }
        }

        public init(inAppPurchaseLocalizations: InAppPurchaseLocalizations? = nil, pricePoints: PricePoints? = nil, content: Content? = nil, appStoreReviewScreenshot: AppStoreReviewScreenshot? = nil, promotedPurchase: PromotedPurchase? = nil, iapPriceSchedule: IapPriceSchedule? = nil, inAppPurchaseAvailability: InAppPurchaseAvailability? = nil) {
            self.inAppPurchaseLocalizations = inAppPurchaseLocalizations
            self.pricePoints = pricePoints
            self.content = content
            self.appStoreReviewScreenshot = appStoreReviewScreenshot
            self.promotedPurchase = promotedPurchase
            self.iapPriceSchedule = iapPriceSchedule
            self.inAppPurchaseAvailability = inAppPurchaseAvailability
        }
    }

    public init(type: `Type` = .inAppPurchases, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.relationships = relationships
        self.links = links
    }
}