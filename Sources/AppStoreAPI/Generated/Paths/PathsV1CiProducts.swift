// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1 {
    public var ciProducts: CiProducts {
        CiProducts(path: path + "/ciProducts")
    }

    public struct CiProducts {
        /// Path: `/v1/ciProducts`
        public let path: String

        public func get(filterProductType: [FilterProductType]? = nil, filterApp: [String]? = nil, fieldsCiProducts: [FieldsCiProducts]? = nil, limit: Int? = nil, include: [Include]? = nil, fieldsCiBuildRuns: [FieldsCiBuildRuns]? = nil, fieldsCiWorkflows: [FieldsCiWorkflows]? = nil, fieldsApps: [FieldsApps]? = nil, fieldsScmRepositories: [FieldsScmRepositories]? = nil, limitPrimaryRepositories: Int? = nil) -> Request<AppStoreAPI.CiProductsResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(filterProductType, filterApp, fieldsCiProducts, limit, include, fieldsCiBuildRuns, fieldsCiWorkflows, fieldsApps, fieldsScmRepositories, limitPrimaryRepositories), id: "ciProducts-get_collection")
        }

        private func makeGetQuery(_ filterProductType: [FilterProductType]?, _ filterApp: [String]?, _ fieldsCiProducts: [FieldsCiProducts]?, _ limit: Int?, _ include: [Include]?, _ fieldsCiBuildRuns: [FieldsCiBuildRuns]?, _ fieldsCiWorkflows: [FieldsCiWorkflows]?, _ fieldsApps: [FieldsApps]?, _ fieldsScmRepositories: [FieldsScmRepositories]?, _ limitPrimaryRepositories: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(filterProductType, forKey: "filter[productType]")
            encoder.encode(filterApp, forKey: "filter[app]")
            encoder.encode(fieldsCiProducts, forKey: "fields[ciProducts]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(include, forKey: "include")
            encoder.encode(fieldsCiBuildRuns, forKey: "fields[ciBuildRuns]")
            encoder.encode(fieldsCiWorkflows, forKey: "fields[ciWorkflows]")
            encoder.encode(fieldsApps, forKey: "fields[apps]")
            encoder.encode(fieldsScmRepositories, forKey: "fields[scmRepositories]")
            encoder.encode(limitPrimaryRepositories, forKey: "limit[primaryRepositories]")
            return encoder.items
        }

        public enum FilterProductType: String, CaseIterable, Codable, Sendable {
            case app = "APP"
            case framework = "FRAMEWORK"
        }

        public enum FieldsCiProducts: String, CaseIterable, Codable, Sendable {
            case additionalRepositories
            case app
            case buildRuns
            case bundleID = "bundleId"
            case createdDate
            case name
            case primaryRepositories
            case productType
            case workflows
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case app
            case bundleID = "bundleId"
            case primaryRepositories
        }

        public enum FieldsCiBuildRuns: String, CaseIterable, Codable, Sendable {
            case actions
            case buildRun
            case builds
            case cancelReason
            case clean
            case completionStatus
            case createdDate
            case destinationBranch
            case destinationCommit
            case executionProgress
            case finishedDate
            case isPullRequestBuild
            case issueCounts
            case number
            case product
            case pullRequest
            case sourceBranchOrTag
            case sourceCommit
            case startReason
            case startedDate
            case workflow
        }

        public enum FieldsCiWorkflows: String, CaseIterable, Codable, Sendable {
            case actions
            case branchStartCondition
            case buildRuns
            case clean
            case containerFilePath
            case description
            case isEnabled
            case isLockedForEditing
            case lastModifiedDate
            case macOsVersion
            case manualBranchStartCondition
            case manualPullRequestStartCondition
            case manualTagStartCondition
            case name
            case product
            case pullRequestStartCondition
            case repository
            case scheduledStartCondition
            case tagStartCondition
            case xcodeVersion
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

        public enum FieldsScmRepositories: String, CaseIterable, Codable, Sendable {
            case defaultBranch
            case gitReferences
            case httpCloneURL = "httpCloneUrl"
            case lastAccessedDate
            case ownerName
            case pullRequests
            case repositoryName
            case scmProvider
            case sshCloneURL = "sshCloneUrl"
        }
    }
}