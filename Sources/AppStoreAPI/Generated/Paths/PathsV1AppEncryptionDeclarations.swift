// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1 {
    public var appEncryptionDeclarations: AppEncryptionDeclarations {
        AppEncryptionDeclarations(path: path + "/appEncryptionDeclarations")
    }

    public struct AppEncryptionDeclarations {
        /// Path: `/v1/appEncryptionDeclarations`
        public let path: String

        public func get(filterPlatform: [FilterPlatform]? = nil, filterApp: [String]? = nil, filterBuilds: [String]? = nil, fieldsAppEncryptionDeclarations: [FieldsAppEncryptionDeclarations]? = nil, limit: Int? = nil, include: [Include]? = nil, fieldsAppEncryptionDeclarationDocuments: [FieldsAppEncryptionDeclarationDocuments]? = nil, fieldsApps: [FieldsApps]? = nil, limitBuilds: Int? = nil) -> Request<AppStoreAPI.AppEncryptionDeclarationsResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(filterPlatform, filterApp, filterBuilds, fieldsAppEncryptionDeclarations, limit, include, fieldsAppEncryptionDeclarationDocuments, fieldsApps, limitBuilds), id: "appEncryptionDeclarations-get_collection")
        }

        private func makeGetQuery(_ filterPlatform: [FilterPlatform]?, _ filterApp: [String]?, _ filterBuilds: [String]?, _ fieldsAppEncryptionDeclarations: [FieldsAppEncryptionDeclarations]?, _ limit: Int?, _ include: [Include]?, _ fieldsAppEncryptionDeclarationDocuments: [FieldsAppEncryptionDeclarationDocuments]?, _ fieldsApps: [FieldsApps]?, _ limitBuilds: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(filterPlatform, forKey: "filter[platform]")
            encoder.encode(filterApp, forKey: "filter[app]")
            encoder.encode(filterBuilds, forKey: "filter[builds]")
            encoder.encode(fieldsAppEncryptionDeclarations, forKey: "fields[appEncryptionDeclarations]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(include, forKey: "include")
            encoder.encode(fieldsAppEncryptionDeclarationDocuments, forKey: "fields[appEncryptionDeclarationDocuments]")
            encoder.encode(fieldsApps, forKey: "fields[apps]")
            encoder.encode(limitBuilds, forKey: "limit[builds]")
            return encoder.items
        }

        public enum FilterPlatform: String, CaseIterable, Codable, Sendable {
            case ios = "IOS"
            case macOs = "MAC_OS"
            case tvOs = "TV_OS"
            case visionOs = "VISION_OS"
        }

        public enum FieldsAppEncryptionDeclarations: String, CaseIterable, Codable, Sendable {
            case app
            case appDescription
            case appEncryptionDeclarationDocument
            case appEncryptionDeclarationState
            case availableOnFrenchStore
            case builds
            case codeValue
            case containsProprietaryCryptography
            case containsThirdPartyCryptography
            case createdDate
            case documentName
            case documentType
            case documentURL = "documentUrl"
            case exempt
            case platform
            case uploadedDate
            case usesEncryption
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case app
            case appEncryptionDeclarationDocument
            case builds
        }

        public enum FieldsAppEncryptionDeclarationDocuments: String, CaseIterable, Codable, Sendable {
            case appEncryptionDeclaration
            case assetDeliveryState
            case assetToken
            case downloadURL = "downloadUrl"
            case fileName
            case fileSize
            case sourceFileChecksum
            case uploadOperations
            case uploaded
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