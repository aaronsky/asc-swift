// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1 {
    public var betaAppReviewSubmissions: BetaAppReviewSubmissions {
        BetaAppReviewSubmissions(path: path + "/betaAppReviewSubmissions")
    }

    public struct BetaAppReviewSubmissions {
        /// Path: `/v1/betaAppReviewSubmissions`
        public let path: String

        public func get(filterBetaReviewState: [FilterBetaReviewState]? = nil, filterBuild: [String], fieldsBetaAppReviewSubmissions: [FieldsBetaAppReviewSubmissions]? = nil, limit: Int? = nil, include: [Include]? = nil, fieldsBuilds: [FieldsBuilds]? = nil) -> Request<AppStoreAPI.BetaAppReviewSubmissionsResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(filterBetaReviewState, filterBuild, fieldsBetaAppReviewSubmissions, limit, include, fieldsBuilds), id: "betaAppReviewSubmissions-get_collection")
        }

        private func makeGetQuery(_ filterBetaReviewState: [FilterBetaReviewState]?, _ filterBuild: [String], _ fieldsBetaAppReviewSubmissions: [FieldsBetaAppReviewSubmissions]?, _ limit: Int?, _ include: [Include]?, _ fieldsBuilds: [FieldsBuilds]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(filterBetaReviewState, forKey: "filter[betaReviewState]")
            encoder.encode(filterBuild, forKey: "filter[build]")
            encoder.encode(fieldsBetaAppReviewSubmissions, forKey: "fields[betaAppReviewSubmissions]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(include, forKey: "include")
            encoder.encode(fieldsBuilds, forKey: "fields[builds]")
            return encoder.items
        }

        public enum FilterBetaReviewState: String, CaseIterable, Codable, Sendable {
            case waitingForReview = "WAITING_FOR_REVIEW"
            case inReview = "IN_REVIEW"
            case rejected = "REJECTED"
            case approved = "APPROVED"
        }

        public enum FieldsBetaAppReviewSubmissions: String, CaseIterable, Codable, Sendable {
            case betaReviewState
            case build
            case submittedDate
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case build
        }

        public enum FieldsBuilds: String, CaseIterable, Codable, Sendable {
            case app
            case appEncryptionDeclaration
            case appStoreVersion
            case betaAppReviewSubmission
            case betaBuildLocalizations
            case betaGroups
            case buildAudienceType
            case buildBetaDetail
            case buildBundles
            case computedMinMacOsVersion
            case diagnosticSignatures
            case expirationDate
            case expired
            case iconAssetToken
            case icons
            case individualTesters
            case lsMinimumSystemVersion
            case minOsVersion
            case perfPowerMetrics
            case preReleaseVersion
            case processingState
            case uploadedDate
            case usesNonExemptEncryption
            case version
        }

        public func post(_ body: AppStoreAPI.BetaAppReviewSubmissionCreateRequest) -> Request<AppStoreAPI.BetaAppReviewSubmissionResponse> {
            Request(path: path, method: "POST", body: body, id: "betaAppReviewSubmissions-create_instance")
        }
    }
}