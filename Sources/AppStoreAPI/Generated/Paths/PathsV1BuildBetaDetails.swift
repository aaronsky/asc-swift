// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1 {
    public var buildBetaDetails: BuildBetaDetails {
        BuildBetaDetails(path: path + "/buildBetaDetails")
    }

    public struct BuildBetaDetails {
        /// Path: `/v1/buildBetaDetails`
        public let path: String

        public func get(filterBuild: [String]? = nil, filterID: [String]? = nil, fieldsBuildBetaDetails: [FieldsBuildBetaDetails]? = nil, limit: Int? = nil, include: [Include]? = nil, fieldsBuilds: [FieldsBuilds]? = nil) -> Request<AppStoreAPI.BuildBetaDetailsResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(filterBuild, filterID, fieldsBuildBetaDetails, limit, include, fieldsBuilds), id: "buildBetaDetails-get_collection")
        }

        private func makeGetQuery(_ filterBuild: [String]?, _ filterID: [String]?, _ fieldsBuildBetaDetails: [FieldsBuildBetaDetails]?, _ limit: Int?, _ include: [Include]?, _ fieldsBuilds: [FieldsBuilds]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(filterBuild, forKey: "filter[build]")
            encoder.encode(filterID, forKey: "filter[id]")
            encoder.encode(fieldsBuildBetaDetails, forKey: "fields[buildBetaDetails]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(include, forKey: "include")
            encoder.encode(fieldsBuilds, forKey: "fields[builds]")
            return encoder.items
        }

        public enum FieldsBuildBetaDetails: String, CaseIterable, Codable, Sendable {
            case autoNotifyEnabled
            case build
            case externalBuildState
            case internalBuildState
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
    }
}