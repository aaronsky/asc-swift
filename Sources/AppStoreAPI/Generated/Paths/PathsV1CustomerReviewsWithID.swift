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

        public func get(fieldsCustomerReviews: [FieldsCustomerReviews]? = nil, include: [Include]? = nil, fieldsCustomerReviewResponses: [FieldsCustomerReviewResponses]? = nil) -> Request<AppStoreAPI.CustomerReviewResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsCustomerReviews, include, fieldsCustomerReviewResponses), id: "customerReviews-get_instance")
        }

        private func makeGetQuery(_ fieldsCustomerReviews: [FieldsCustomerReviews]?, _ include: [Include]?, _ fieldsCustomerReviewResponses: [FieldsCustomerReviewResponses]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsCustomerReviews, forKey: "fields[customerReviews]")
            encoder.encode(include, forKey: "include")
            encoder.encode(fieldsCustomerReviewResponses, forKey: "fields[customerReviewResponses]")
            return encoder.items
        }

        public enum FieldsCustomerReviews: String, CaseIterable, Codable, Sendable {
            case body
            case createdDate
            case rating
            case response
            case reviewerNickname
            case territory
            case title
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case response
        }

        public enum FieldsCustomerReviewResponses: String, CaseIterable, Codable, Sendable {
            case lastModifiedDate
            case responseBody
            case review
            case state
        }
    }
}