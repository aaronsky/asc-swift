// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.SubscriptionOfferCodes.WithID {
    public var customCodes: CustomCodes {
        CustomCodes(path: path + "/customCodes")
    }

    public struct CustomCodes {
        /// Path: `/v1/subscriptionOfferCodes/{id}/customCodes`
        public let path: String

        public func get(fieldsSubscriptionOfferCodeCustomCodes: [FieldsSubscriptionOfferCodeCustomCodes]? = nil, fieldsSubscriptionOfferCodes: [FieldsSubscriptionOfferCodes]? = nil, limit: Int? = nil, include: [Include]? = nil) -> Request<AppStoreAPI.SubscriptionOfferCodeCustomCodesResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsSubscriptionOfferCodeCustomCodes, fieldsSubscriptionOfferCodes, limit, include), id: "subscriptionOfferCodes-customCodes-get_to_many_related")
        }

        private func makeGetQuery(_ fieldsSubscriptionOfferCodeCustomCodes: [FieldsSubscriptionOfferCodeCustomCodes]?, _ fieldsSubscriptionOfferCodes: [FieldsSubscriptionOfferCodes]?, _ limit: Int?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsSubscriptionOfferCodeCustomCodes, forKey: "fields[subscriptionOfferCodeCustomCodes]")
            encoder.encode(fieldsSubscriptionOfferCodes, forKey: "fields[subscriptionOfferCodes]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsSubscriptionOfferCodeCustomCodes: String, CaseIterable, Codable, Sendable {
            case active
            case createdDate
            case customCode
            case expirationDate
            case numberOfCodes
            case offerCode
        }

        public enum FieldsSubscriptionOfferCodes: String, CaseIterable, Codable, Sendable {
            case active
            case customCodes
            case customerEligibilities
            case duration
            case name
            case numberOfPeriods
            case offerEligibility
            case offerMode
            case oneTimeUseCodes
            case prices
            case subscription
            case totalNumberOfCodes
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case offerCode
        }
    }
}