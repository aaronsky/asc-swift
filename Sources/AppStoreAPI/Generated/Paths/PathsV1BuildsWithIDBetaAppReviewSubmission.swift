// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.Builds.WithID {
    public var betaAppReviewSubmission: BetaAppReviewSubmission {
        BetaAppReviewSubmission(path: path + "/betaAppReviewSubmission")
    }

    public struct BetaAppReviewSubmission {
        /// Path: `/v1/builds/{id}/betaAppReviewSubmission`
        public let path: String

        public func get(fieldsBetaAppReviewSubmissions: [FieldsBetaAppReviewSubmissions]? = nil) -> Request<AppStoreAPI.BetaAppReviewSubmissionWithoutIncludesResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsBetaAppReviewSubmissions), id: "builds_betaAppReviewSubmission_getToOneRelated")
        }

        private func makeGetQuery(_ fieldsBetaAppReviewSubmissions: [FieldsBetaAppReviewSubmissions]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(fieldsBetaAppReviewSubmissions, forKey: "fields[betaAppReviewSubmissions]", explode: false)
            return encoder.items
        }

        public enum FieldsBetaAppReviewSubmissions: String, CaseIterable, Codable, Sendable {
            case betaReviewState
            case submittedDate
            case build
        }
    }
}
