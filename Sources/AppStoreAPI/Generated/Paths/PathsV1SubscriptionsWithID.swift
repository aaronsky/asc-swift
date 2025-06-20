// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.Subscriptions {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/subscriptions/{id}`
        public let path: String

        public func get(fieldsSubscriptions: [FieldsSubscriptions]? = nil, fieldsSubscriptionLocalizations: [FieldsSubscriptionLocalizations]? = nil, fieldsSubscriptionAppStoreReviewScreenshots: [FieldsSubscriptionAppStoreReviewScreenshots]? = nil, fieldsSubscriptionIntroductoryOffers: [FieldsSubscriptionIntroductoryOffers]? = nil, fieldsSubscriptionPromotionalOffers: [FieldsSubscriptionPromotionalOffers]? = nil, fieldsSubscriptionOfferCodes: [FieldsSubscriptionOfferCodes]? = nil, fieldsSubscriptionPrices: [FieldsSubscriptionPrices]? = nil, fieldsPromotedPurchases: [FieldsPromotedPurchases]? = nil, fieldsSubscriptionAvailabilities: [FieldsSubscriptionAvailabilities]? = nil, fieldsWinBackOffers: [FieldsWinBackOffers]? = nil, fieldsSubscriptionImages: [FieldsSubscriptionImages]? = nil, include: [Include]? = nil, limitImages: Int? = nil, limitIntroductoryOffers: Int? = nil, limitOfferCodes: Int? = nil, limitPrices: Int? = nil, limitPromotionalOffers: Int? = nil, limitSubscriptionLocalizations: Int? = nil, limitWinBackOffers: Int? = nil) -> Request<AppStoreAPI.SubscriptionResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsSubscriptions, fieldsSubscriptionLocalizations, fieldsSubscriptionAppStoreReviewScreenshots, fieldsSubscriptionIntroductoryOffers, fieldsSubscriptionPromotionalOffers, fieldsSubscriptionOfferCodes, fieldsSubscriptionPrices, fieldsPromotedPurchases, fieldsSubscriptionAvailabilities, fieldsWinBackOffers, fieldsSubscriptionImages, include, limitImages, limitIntroductoryOffers, limitOfferCodes, limitPrices, limitPromotionalOffers, limitSubscriptionLocalizations, limitWinBackOffers), id: "subscriptions_getInstance")
        }

        private func makeGetQuery(_ fieldsSubscriptions: [FieldsSubscriptions]?, _ fieldsSubscriptionLocalizations: [FieldsSubscriptionLocalizations]?, _ fieldsSubscriptionAppStoreReviewScreenshots: [FieldsSubscriptionAppStoreReviewScreenshots]?, _ fieldsSubscriptionIntroductoryOffers: [FieldsSubscriptionIntroductoryOffers]?, _ fieldsSubscriptionPromotionalOffers: [FieldsSubscriptionPromotionalOffers]?, _ fieldsSubscriptionOfferCodes: [FieldsSubscriptionOfferCodes]?, _ fieldsSubscriptionPrices: [FieldsSubscriptionPrices]?, _ fieldsPromotedPurchases: [FieldsPromotedPurchases]?, _ fieldsSubscriptionAvailabilities: [FieldsSubscriptionAvailabilities]?, _ fieldsWinBackOffers: [FieldsWinBackOffers]?, _ fieldsSubscriptionImages: [FieldsSubscriptionImages]?, _ include: [Include]?, _ limitImages: Int?, _ limitIntroductoryOffers: Int?, _ limitOfferCodes: Int?, _ limitPrices: Int?, _ limitPromotionalOffers: Int?, _ limitSubscriptionLocalizations: Int?, _ limitWinBackOffers: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsSubscriptions, forKey: "fields[subscriptions]")
            encoder.encode(fieldsSubscriptionLocalizations, forKey: "fields[subscriptionLocalizations]")
            encoder.encode(fieldsSubscriptionAppStoreReviewScreenshots, forKey: "fields[subscriptionAppStoreReviewScreenshots]")
            encoder.encode(fieldsSubscriptionIntroductoryOffers, forKey: "fields[subscriptionIntroductoryOffers]")
            encoder.encode(fieldsSubscriptionPromotionalOffers, forKey: "fields[subscriptionPromotionalOffers]")
            encoder.encode(fieldsSubscriptionOfferCodes, forKey: "fields[subscriptionOfferCodes]")
            encoder.encode(fieldsSubscriptionPrices, forKey: "fields[subscriptionPrices]")
            encoder.encode(fieldsPromotedPurchases, forKey: "fields[promotedPurchases]")
            encoder.encode(fieldsSubscriptionAvailabilities, forKey: "fields[subscriptionAvailabilities]")
            encoder.encode(fieldsWinBackOffers, forKey: "fields[winBackOffers]")
            encoder.encode(fieldsSubscriptionImages, forKey: "fields[subscriptionImages]")
            encoder.encode(include, forKey: "include")
            encoder.encode(limitImages, forKey: "limit[images]")
            encoder.encode(limitIntroductoryOffers, forKey: "limit[introductoryOffers]")
            encoder.encode(limitOfferCodes, forKey: "limit[offerCodes]")
            encoder.encode(limitPrices, forKey: "limit[prices]")
            encoder.encode(limitPromotionalOffers, forKey: "limit[promotionalOffers]")
            encoder.encode(limitSubscriptionLocalizations, forKey: "limit[subscriptionLocalizations]")
            encoder.encode(limitWinBackOffers, forKey: "limit[winBackOffers]")
            return encoder.items
        }

        public enum FieldsSubscriptions: String, CaseIterable, Codable, Sendable {
            case name
            case productID = "productId"
            case familySharable
            case state
            case subscriptionPeriod
            case reviewNote
            case groupLevel
            case subscriptionLocalizations
            case appStoreReviewScreenshot
            case group
            case introductoryOffers
            case promotionalOffers
            case offerCodes
            case prices
            case pricePoints
            case promotedPurchase
            case subscriptionAvailability
            case winBackOffers
            case images
        }

        public enum FieldsSubscriptionLocalizations: String, CaseIterable, Codable, Sendable {
            case name
            case locale
            case description
            case state
            case subscription
        }

        public enum FieldsSubscriptionAppStoreReviewScreenshots: String, CaseIterable, Codable, Sendable {
            case fileSize
            case fileName
            case sourceFileChecksum
            case imageAsset
            case assetToken
            case assetType
            case uploadOperations
            case assetDeliveryState
            case subscription
        }

        public enum FieldsSubscriptionIntroductoryOffers: String, CaseIterable, Codable, Sendable {
            case startDate
            case endDate
            case duration
            case offerMode
            case numberOfPeriods
            case subscription
            case territory
            case subscriptionPricePoint
        }

        public enum FieldsSubscriptionPromotionalOffers: String, CaseIterable, Codable, Sendable {
            case duration
            case name
            case numberOfPeriods
            case offerCode
            case offerMode
            case subscription
            case prices
        }

        public enum FieldsSubscriptionOfferCodes: String, CaseIterable, Codable, Sendable {
            case name
            case customerEligibilities
            case offerEligibility
            case duration
            case offerMode
            case numberOfPeriods
            case active
            case subscription
            case oneTimeUseCodes
            case customCodes
            case prices
        }

        public enum FieldsSubscriptionPrices: String, CaseIterable, Codable, Sendable {
            case startDate
            case preserved
            case territory
            case subscriptionPricePoint
        }

        public enum FieldsPromotedPurchases: String, CaseIterable, Codable, Sendable {
            case visibleForAllUsers
            case enabled
            case state
            case inAppPurchaseV2
            case subscription
        }

        public enum FieldsSubscriptionAvailabilities: String, CaseIterable, Codable, Sendable {
            case availableInNewTerritories
            case availableTerritories
        }

        public enum FieldsWinBackOffers: String, CaseIterable, Codable, Sendable {
            case referenceName
            case offerID = "offerId"
            case duration
            case offerMode
            case periodCount
            case customerEligibilityPaidSubscriptionDurationInMonths
            case customerEligibilityTimeSinceLastSubscribedInMonths
            case customerEligibilityWaitBetweenOffersInMonths
            case startDate
            case endDate
            case priority
            case promotionIntent
            case prices
        }

        public enum FieldsSubscriptionImages: String, CaseIterable, Codable, Sendable {
            case fileSize
            case fileName
            case sourceFileChecksum
            case assetToken
            case imageAsset
            case uploadOperations
            case state
            case subscription
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case subscriptionLocalizations
            case appStoreReviewScreenshot
            case group
            case introductoryOffers
            case promotionalOffers
            case offerCodes
            case prices
            case promotedPurchase
            case subscriptionAvailability
            case winBackOffers
            case images
        }

        public func patch(_ body: AppStoreAPI.SubscriptionUpdateRequest) -> Request<AppStoreAPI.SubscriptionResponse> {
            Request(path: path, method: "PATCH", body: body, id: "subscriptions_updateInstance")
        }

        public var delete: Request<Void> {
            Request(path: path, method: "DELETE", id: "subscriptions_deleteInstance")
        }
    }
}
