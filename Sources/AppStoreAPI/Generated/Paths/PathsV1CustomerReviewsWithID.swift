// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.CustomerReviews {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/customerReviews/{id}`
        public let path: String

        public func get(fieldsCustomerReviews: [FieldsCustomerReviews]? = nil, fieldsCustomerReviewResponses: [FieldsCustomerReviewResponses]? = nil, include: [Include]? = nil) -> Request<AppStoreAPI.CustomerReviewResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsCustomerReviews, fieldsCustomerReviewResponses, include), id: "customerReviews_getInstance")
        }

        private func makeGetQuery(_ fieldsCustomerReviews: [FieldsCustomerReviews]?, _ fieldsCustomerReviewResponses: [FieldsCustomerReviewResponses]?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsCustomerReviews, forKey: "fields[customerReviews]")
            encoder.encode(fieldsCustomerReviewResponses, forKey: "fields[customerReviewResponses]")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsCustomerReviews: String, CaseIterable, Codable, Sendable {
            case rating
            case title
            case body
            case reviewerNickname
            case createdDate
            case territory
            case response
        }

        public enum FieldsCustomerReviewResponses: String, CaseIterable, Codable, Sendable {
            case responseBody
            case lastModifiedDate
            case state
            case review
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case response
        }
    }
}
