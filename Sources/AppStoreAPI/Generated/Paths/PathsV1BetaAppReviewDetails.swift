// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1 {
    public var betaAppReviewDetails: BetaAppReviewDetails {
        BetaAppReviewDetails(path: path + "/betaAppReviewDetails")
    }

    public struct BetaAppReviewDetails {
        /// Path: `/v1/betaAppReviewDetails`
        public let path: String

        public func get(filterApp: [String], fieldsBetaAppReviewDetails: [FieldsBetaAppReviewDetails]? = nil, limit: Int? = nil, include: [Include]? = nil, fieldsApps: [FieldsApps]? = nil) -> Request<AppStoreAPI.BetaAppReviewDetailsResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(filterApp, fieldsBetaAppReviewDetails, limit, include, fieldsApps), id: "betaAppReviewDetails-get_collection")
        }

        private func makeGetQuery(_ filterApp: [String], _ fieldsBetaAppReviewDetails: [FieldsBetaAppReviewDetails]?, _ limit: Int?, _ include: [Include]?, _ fieldsApps: [FieldsApps]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(filterApp, forKey: "filter[app]")
            encoder.encode(fieldsBetaAppReviewDetails, forKey: "fields[betaAppReviewDetails]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(include, forKey: "include")
            encoder.encode(fieldsApps, forKey: "fields[apps]")
            return encoder.items
        }

        public enum FieldsBetaAppReviewDetails: String, CaseIterable, Codable, Sendable {
            case app
            case contactEmail
            case contactFirstName
            case contactLastName
            case contactPhone
            case demoAccountName
            case demoAccountPassword
            case demoAccountRequired
            case notes
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case app
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
    }
}