// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.GameCenterAppVersions {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/gameCenterAppVersions/{id}`
        public let path: String

        public func get(fieldsGameCenterAppVersions: [FieldsGameCenterAppVersions]? = nil, include: [Include]? = nil, fieldsAppStoreVersions: [FieldsAppStoreVersions]? = nil, limitCompatibilityVersions: Int? = nil) -> Request<_Specification.GameCenterAppVersionResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsGameCenterAppVersions, include, fieldsAppStoreVersions, limitCompatibilityVersions), id: "gameCenterAppVersions-get_instance")
        }

        private func makeGetQuery(_ fieldsGameCenterAppVersions: [FieldsGameCenterAppVersions]?, _ include: [Include]?, _ fieldsAppStoreVersions: [FieldsAppStoreVersions]?, _ limitCompatibilityVersions: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsGameCenterAppVersions, forKey: "fields[gameCenterAppVersions]")
            encoder.encode(include, forKey: "include")
            encoder.encode(fieldsAppStoreVersions, forKey: "fields[appStoreVersions]")
            encoder.encode(limitCompatibilityVersions, forKey: "limit[compatibilityVersions]")
            return encoder.items
        }

        public enum FieldsGameCenterAppVersions: String, CaseIterable, Codable, Sendable {
            case appStoreVersion
            case compatibilityVersions
            case enabled
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case appStoreVersion
            case compatibilityVersions
        }

        public enum FieldsAppStoreVersions: String, CaseIterable, Codable, Sendable {
            case ageRatingDeclaration
            case alternativeDistributionPackage
            case app
            case appClipDefaultExperience
            case appStoreReviewDetail
            case appStoreState
            case appStoreVersionExperiments
            case appStoreVersionExperimentsV2
            case appStoreVersionLocalizations
            case appStoreVersionPhasedRelease
            case appStoreVersionSubmission
            case appVersionState
            case build
            case copyright
            case createdDate
            case customerReviews
            case downloadable
            case earliestReleaseDate
            case platform
            case releaseType
            case reviewType
            case routingAppCoverage
            case versionString
        }

        public func patch(_ body: _Specification.GameCenterAppVersionUpdateRequest) -> Request<_Specification.GameCenterAppVersionResponse> {
            Request(path: path, method: "PATCH", body: body, id: "gameCenterAppVersions-update_instance")
        }
    }
}
