// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.GameCenterGroups.WithID {
    public var gameCenterDetails: GameCenterDetails {
        GameCenterDetails(path: path + "/gameCenterDetails")
    }

    public struct GameCenterDetails {
        /// Path: `/v1/gameCenterGroups/{id}/gameCenterDetails`
        public let path: String

        public func get(filterGameCenterAppVersionsEnabled: [String]? = nil, fieldsGameCenterAchievementReleases: [FieldsGameCenterAchievementReleases]? = nil, fieldsGameCenterLeaderboardSetReleases: [FieldsGameCenterLeaderboardSetReleases]? = nil, fieldsGameCenterLeaderboardSets: [FieldsGameCenterLeaderboardSets]? = nil, fieldsGameCenterGroups: [FieldsGameCenterGroups]? = nil, fieldsGameCenterDetails: [FieldsGameCenterDetails]? = nil, fieldsGameCenterLeaderboards: [FieldsGameCenterLeaderboards]? = nil, fieldsGameCenterAppVersions: [FieldsGameCenterAppVersions]? = nil, fieldsGameCenterAchievements: [FieldsGameCenterAchievements]? = nil, fieldsApps: [FieldsApps]? = nil, fieldsGameCenterLeaderboardReleases: [FieldsGameCenterLeaderboardReleases]? = nil, limit: Int? = nil, limitGameCenterAppVersions: Int? = nil, limitGameCenterLeaderboards: Int? = nil, limitGameCenterLeaderboardSets: Int? = nil, limitGameCenterAchievements: Int? = nil, limitAchievementReleases: Int? = nil, limitLeaderboardReleases: Int? = nil, limitLeaderboardSetReleases: Int? = nil, include: [Include]? = nil) -> Request<_Specification.GameCenterDetailsResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(filterGameCenterAppVersionsEnabled, fieldsGameCenterAchievementReleases, fieldsGameCenterLeaderboardSetReleases, fieldsGameCenterLeaderboardSets, fieldsGameCenterGroups, fieldsGameCenterDetails, fieldsGameCenterLeaderboards, fieldsGameCenterAppVersions, fieldsGameCenterAchievements, fieldsApps, fieldsGameCenterLeaderboardReleases, limit, limitGameCenterAppVersions, limitGameCenterLeaderboards, limitGameCenterLeaderboardSets, limitGameCenterAchievements, limitAchievementReleases, limitLeaderboardReleases, limitLeaderboardSetReleases, include), id: "gameCenterGroups-gameCenterDetails-get_to_many_related")
        }

        private func makeGetQuery(_ filterGameCenterAppVersionsEnabled: [String]?, _ fieldsGameCenterAchievementReleases: [FieldsGameCenterAchievementReleases]?, _ fieldsGameCenterLeaderboardSetReleases: [FieldsGameCenterLeaderboardSetReleases]?, _ fieldsGameCenterLeaderboardSets: [FieldsGameCenterLeaderboardSets]?, _ fieldsGameCenterGroups: [FieldsGameCenterGroups]?, _ fieldsGameCenterDetails: [FieldsGameCenterDetails]?, _ fieldsGameCenterLeaderboards: [FieldsGameCenterLeaderboards]?, _ fieldsGameCenterAppVersions: [FieldsGameCenterAppVersions]?, _ fieldsGameCenterAchievements: [FieldsGameCenterAchievements]?, _ fieldsApps: [FieldsApps]?, _ fieldsGameCenterLeaderboardReleases: [FieldsGameCenterLeaderboardReleases]?, _ limit: Int?, _ limitGameCenterAppVersions: Int?, _ limitGameCenterLeaderboards: Int?, _ limitGameCenterLeaderboardSets: Int?, _ limitGameCenterAchievements: Int?, _ limitAchievementReleases: Int?, _ limitLeaderboardReleases: Int?, _ limitLeaderboardSetReleases: Int?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(filterGameCenterAppVersionsEnabled, forKey: "filter[gameCenterAppVersions.enabled]")
            encoder.encode(fieldsGameCenterAchievementReleases, forKey: "fields[gameCenterAchievementReleases]")
            encoder.encode(fieldsGameCenterLeaderboardSetReleases, forKey: "fields[gameCenterLeaderboardSetReleases]")
            encoder.encode(fieldsGameCenterLeaderboardSets, forKey: "fields[gameCenterLeaderboardSets]")
            encoder.encode(fieldsGameCenterGroups, forKey: "fields[gameCenterGroups]")
            encoder.encode(fieldsGameCenterDetails, forKey: "fields[gameCenterDetails]")
            encoder.encode(fieldsGameCenterLeaderboards, forKey: "fields[gameCenterLeaderboards]")
            encoder.encode(fieldsGameCenterAppVersions, forKey: "fields[gameCenterAppVersions]")
            encoder.encode(fieldsGameCenterAchievements, forKey: "fields[gameCenterAchievements]")
            encoder.encode(fieldsApps, forKey: "fields[apps]")
            encoder.encode(fieldsGameCenterLeaderboardReleases, forKey: "fields[gameCenterLeaderboardReleases]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(limitGameCenterAppVersions, forKey: "limit[gameCenterAppVersions]")
            encoder.encode(limitGameCenterLeaderboards, forKey: "limit[gameCenterLeaderboards]")
            encoder.encode(limitGameCenterLeaderboardSets, forKey: "limit[gameCenterLeaderboardSets]")
            encoder.encode(limitGameCenterAchievements, forKey: "limit[gameCenterAchievements]")
            encoder.encode(limitAchievementReleases, forKey: "limit[achievementReleases]")
            encoder.encode(limitLeaderboardReleases, forKey: "limit[leaderboardReleases]")
            encoder.encode(limitLeaderboardSetReleases, forKey: "limit[leaderboardSetReleases]")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsGameCenterAchievementReleases: String, CaseIterable, Codable, Sendable {
            case gameCenterAchievement
            case gameCenterDetail
            case live
        }

        public enum FieldsGameCenterLeaderboardSetReleases: String, CaseIterable, Codable, Sendable {
            case gameCenterDetail
            case gameCenterLeaderboardSet
            case live
        }

        public enum FieldsGameCenterLeaderboardSets: String, CaseIterable, Codable, Sendable {
            case gameCenterDetail
            case gameCenterGroup
            case gameCenterLeaderboards
            case groupLeaderboardSet
            case localizations
            case referenceName
            case releases
            case vendorIdentifier
        }

        public enum FieldsGameCenterGroups: String, CaseIterable, Codable, Sendable {
            case gameCenterAchievements
            case gameCenterDetails
            case gameCenterLeaderboardSets
            case gameCenterLeaderboards
            case referenceName
        }

        public enum FieldsGameCenterDetails: String, CaseIterable, Codable, Sendable {
            case achievementReleases
            case app
            case arcadeEnabled
            case challengeEnabled
            case defaultGroupLeaderboard
            case defaultLeaderboard
            case gameCenterAchievements
            case gameCenterAppVersions
            case gameCenterGroup
            case gameCenterLeaderboardSets
            case gameCenterLeaderboards
            case leaderboardReleases
            case leaderboardSetReleases
        }

        public enum FieldsGameCenterLeaderboards: String, CaseIterable, Codable, Sendable {
            case archived
            case defaultFormatter
            case gameCenterDetail
            case gameCenterGroup
            case gameCenterLeaderboardSets
            case groupLeaderboard
            case localizations
            case recurrenceDuration
            case recurrenceRule
            case recurrenceStartDate
            case referenceName
            case releases
            case scoreRangeEnd
            case scoreRangeStart
            case scoreSortType
            case submissionType
            case vendorIdentifier
        }

        public enum FieldsGameCenterAppVersions: String, CaseIterable, Codable, Sendable {
            case appStoreVersion
            case compatibilityVersions
            case enabled
        }

        public enum FieldsGameCenterAchievements: String, CaseIterable, Codable, Sendable {
            case archived
            case gameCenterDetail
            case gameCenterGroup
            case groupAchievement
            case localizations
            case points
            case referenceName
            case releases
            case repeatable
            case showBeforeEarned
            case vendorIdentifier
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
            case availableInNewTerritories
            case availableTerritories
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
            case pricePoints
            case prices
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

        public enum FieldsGameCenterLeaderboardReleases: String, CaseIterable, Codable, Sendable {
            case gameCenterDetail
            case gameCenterLeaderboard
            case live
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case achievementReleases
            case app
            case defaultGroupLeaderboard
            case defaultLeaderboard
            case gameCenterAchievements
            case gameCenterAppVersions
            case gameCenterGroup
            case gameCenterLeaderboardSets
            case gameCenterLeaderboards
            case leaderboardReleases
            case leaderboardSetReleases
        }
    }
}
