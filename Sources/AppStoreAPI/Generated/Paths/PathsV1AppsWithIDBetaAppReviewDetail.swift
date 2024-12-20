// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.Apps.WithID {
    public var betaAppReviewDetail: BetaAppReviewDetail {
        BetaAppReviewDetail(path: path + "/betaAppReviewDetail")
    }

    public struct BetaAppReviewDetail {
        /// Path: `/v1/apps/{id}/betaAppReviewDetail`
        public let path: String

        public func get(fieldsBetaAppReviewDetails: [FieldsBetaAppReviewDetails]? = nil) -> Request<AppStoreAPI.BetaAppReviewDetailWithoutIncludesResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsBetaAppReviewDetails), id: "apps_betaAppReviewDetail_getToOneRelated")
        }

        private func makeGetQuery(_ fieldsBetaAppReviewDetails: [FieldsBetaAppReviewDetails]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(fieldsBetaAppReviewDetails, forKey: "fields[betaAppReviewDetails]", explode: false)
            return encoder.items
        }

        public enum FieldsBetaAppReviewDetails: String, CaseIterable, Codable, Sendable {
            case contactFirstName
            case contactLastName
            case contactPhone
            case contactEmail
            case demoAccountName
            case demoAccountPassword
            case demoAccountRequired
            case notes
            case app
        }
    }
}
