// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1 {
    public var userInvitations: UserInvitations {
        UserInvitations(path: path + "/userInvitations")
    }

    public struct UserInvitations {
        /// Path: `/v1/userInvitations`
        public let path: String

        public func get(filterEmail: [String]? = nil, filterRoles: [FilterRoles]? = nil, filterVisibleApps: [String]? = nil, sort: [Sort]? = nil, fieldsUserInvitations: [FieldsUserInvitations]? = nil, limit: Int? = nil, include: [Include]? = nil, fieldsApps: [FieldsApps]? = nil, limitVisibleApps: Int? = nil) -> Request<_Specification.UserInvitationsResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(filterEmail, filterRoles, filterVisibleApps, sort, fieldsUserInvitations, limit, include, fieldsApps, limitVisibleApps), id: "userInvitations-get_collection")
        }

        private func makeGetQuery(_ filterEmail: [String]?, _ filterRoles: [FilterRoles]?, _ filterVisibleApps: [String]?, _ sort: [Sort]?, _ fieldsUserInvitations: [FieldsUserInvitations]?, _ limit: Int?, _ include: [Include]?, _ fieldsApps: [FieldsApps]?, _ limitVisibleApps: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(filterEmail, forKey: "filter[email]")
            encoder.encode(filterRoles, forKey: "filter[roles]")
            encoder.encode(filterVisibleApps, forKey: "filter[visibleApps]")
            encoder.encode(sort, forKey: "sort")
            encoder.encode(fieldsUserInvitations, forKey: "fields[userInvitations]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(include, forKey: "include")
            encoder.encode(fieldsApps, forKey: "fields[apps]")
            encoder.encode(limitVisibleApps, forKey: "limit[visibleApps]")
            return encoder.items
        }

        public enum FilterRoles: String, CaseIterable, Codable, Sendable {
            case admin = "ADMIN"
            case finance = "FINANCE"
            case accountHolder = "ACCOUNT_HOLDER"
            case sales = "SALES"
            case marketing = "MARKETING"
            case appManager = "APP_MANAGER"
            case developer = "DEVELOPER"
            case accessToReports = "ACCESS_TO_REPORTS"
            case customerSupport = "CUSTOMER_SUPPORT"
            case createApps = "CREATE_APPS"
            case cloudManagedDeveloperID = "CLOUD_MANAGED_DEVELOPER_ID"
            case cloudManagedAppDistribution = "CLOUD_MANAGED_APP_DISTRIBUTION"
            case generateIndividualKeys = "GENERATE_INDIVIDUAL_KEYS"
        }

        public enum Sort: String, CaseIterable, Codable, Sendable {
            case email
            case minusemail = "-email"
            case lastName
            case minuslastName = "-lastName"
        }

        public enum FieldsUserInvitations: String, CaseIterable, Codable, Sendable {
            case allAppsVisible
            case email
            case expirationDate
            case firstName
            case lastName
            case provisioningAllowed
            case roles
            case visibleApps
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case visibleApps
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

        public func post(_ body: _Specification.UserInvitationCreateRequest) -> Request<_Specification.UserInvitationResponse> {
            Request(path: path, method: "POST", body: body, id: "userInvitations-create_instance")
        }
    }
}
