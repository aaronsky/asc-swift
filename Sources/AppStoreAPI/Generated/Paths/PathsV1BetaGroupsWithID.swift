// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.BetaGroups {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/betaGroups/{id}`
        public let path: String

        public func get(fieldsBetaGroups: [FieldsBetaGroups]? = nil, include: [Include]? = nil, fieldsBetaTesters: [FieldsBetaTesters]? = nil, fieldsApps: [FieldsApps]? = nil, fieldsBuilds: [FieldsBuilds]? = nil, limitBetaTesters: Int? = nil, limitBuilds: Int? = nil) -> Request<AppStoreAPI.BetaGroupResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsBetaGroups, include, fieldsBetaTesters, fieldsApps, fieldsBuilds, limitBetaTesters, limitBuilds), id: "betaGroups-get_instance")
        }

        private func makeGetQuery(_ fieldsBetaGroups: [FieldsBetaGroups]?, _ include: [Include]?, _ fieldsBetaTesters: [FieldsBetaTesters]?, _ fieldsApps: [FieldsApps]?, _ fieldsBuilds: [FieldsBuilds]?, _ limitBetaTesters: Int?, _ limitBuilds: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsBetaGroups, forKey: "fields[betaGroups]")
            encoder.encode(include, forKey: "include")
            encoder.encode(fieldsBetaTesters, forKey: "fields[betaTesters]")
            encoder.encode(fieldsApps, forKey: "fields[apps]")
            encoder.encode(fieldsBuilds, forKey: "fields[builds]")
            encoder.encode(limitBetaTesters, forKey: "limit[betaTesters]")
            encoder.encode(limitBuilds, forKey: "limit[builds]")
            return encoder.items
        }

        public enum FieldsBetaGroups: String, CaseIterable, Codable, Sendable {
            case app
            case betaTesters
            case builds
            case createdDate
            case feedbackEnabled
            case hasAccessToAllBuilds
            case iosBuildsAvailableForAppleSiliconMac
            case isInternalGroup
            case name
            case publicLink
            case publicLinkEnabled
            case publicLinkID = "publicLinkId"
            case publicLinkLimit
            case publicLinkLimitEnabled
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case app
            case betaTesters
            case builds
        }

        public enum FieldsBetaTesters: String, CaseIterable, Codable, Sendable {
            case apps
            case betaGroups
            case builds
            case email
            case firstName
            case inviteType
            case lastName
            case state
        }

        public enum FieldsApps: String, CaseIterable, Codable, Sendable {
            case alternativeDistributionKey
            case analyticsReportRequests
            case appAvailability
            case appClips
            case appCustomProductPages
            case appEncryptionDeclarations
            case appEvents
            case appInfos
            case appPricePoints
            case appPriceSchedule
            case appStoreVersionExperimentsV2
            case appStoreVersions
            case betaAppLocalizations
            case betaAppReviewDetail
            case betaGroups
            case betaLicenseAgreement
            case betaTesters
            case builds
            case bundleID = "bundleId"
            case ciProduct
            case contentRightsDeclaration
            case customerReviews
            case endUserLicenseAgreement
            case gameCenterDetail
            case gameCenterEnabledVersions
            case inAppPurchases
            case inAppPurchasesV2
            case isOrEverWasMadeForKids
            case marketplaceSearchDetail
            case name
            case perfPowerMetrics
            case preOrder
            case preReleaseVersions
            case primaryLocale
            case promotedPurchases
            case reviewSubmissions
            case sku
            case subscriptionGracePeriod
            case subscriptionGroups
            case subscriptionStatusURL = "subscriptionStatusUrl"
            case subscriptionStatusURLForSandbox = "subscriptionStatusUrlForSandbox"
            case subscriptionStatusURLVersion = "subscriptionStatusUrlVersion"
            case subscriptionStatusURLVersionForSandbox = "subscriptionStatusUrlVersionForSandbox"
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

        public func patch(_ body: AppStoreAPI.BetaGroupUpdateRequest) -> Request<AppStoreAPI.BetaGroupResponse> {
            Request(path: path, method: "PATCH", body: body, id: "betaGroups-update_instance")
        }

        public var delete: Request<Void> {
            Request(path: path, method: "DELETE", id: "betaGroups-delete_instance")
        }
    }
}