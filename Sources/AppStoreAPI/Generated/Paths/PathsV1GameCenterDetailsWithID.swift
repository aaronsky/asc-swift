// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.GameCenterDetails {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/gameCenterDetails/{id}`
        public let path: String

        public func get(fieldsGameCenterDetails: [FieldsGameCenterDetails]? = nil, include: [Include]? = nil, fieldsGameCenterAchievementReleases: [FieldsGameCenterAchievementReleases]? = nil, fieldsGameCenterLeaderboardSetReleases: [FieldsGameCenterLeaderboardSetReleases]? = nil, fieldsGameCenterLeaderboardSets: [FieldsGameCenterLeaderboardSets]? = nil, fieldsGameCenterGroups: [FieldsGameCenterGroups]? = nil, fieldsGameCenterLeaderboards: [FieldsGameCenterLeaderboards]? = nil, fieldsGameCenterAchievements: [FieldsGameCenterAchievements]? = nil, fieldsGameCenterAppVersions: [FieldsGameCenterAppVersions]? = nil, fieldsGameCenterLeaderboardReleases: [FieldsGameCenterLeaderboardReleases]? = nil, limitAchievementReleases: Int? = nil, limitGameCenterAchievements: Int? = nil, limitGameCenterAppVersions: Int? = nil, limitGameCenterLeaderboardSets: Int? = nil, limitGameCenterLeaderboards: Int? = nil, limitLeaderboardReleases: Int? = nil, limitLeaderboardSetReleases: Int? = nil) -> Request<AppStoreAPI.GameCenterDetailResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsGameCenterDetails, include, fieldsGameCenterAchievementReleases, fieldsGameCenterLeaderboardSetReleases, fieldsGameCenterLeaderboardSets, fieldsGameCenterGroups, fieldsGameCenterLeaderboards, fieldsGameCenterAchievements, fieldsGameCenterAppVersions, fieldsGameCenterLeaderboardReleases, limitAchievementReleases, limitGameCenterAchievements, limitGameCenterAppVersions, limitGameCenterLeaderboardSets, limitGameCenterLeaderboards, limitLeaderboardReleases, limitLeaderboardSetReleases), id: "gameCenterDetails-get_instance")
        }

        private func makeGetQuery(_ fieldsGameCenterDetails: [FieldsGameCenterDetails]?, _ include: [Include]?, _ fieldsGameCenterAchievementReleases: [FieldsGameCenterAchievementReleases]?, _ fieldsGameCenterLeaderboardSetReleases: [FieldsGameCenterLeaderboardSetReleases]?, _ fieldsGameCenterLeaderboardSets: [FieldsGameCenterLeaderboardSets]?, _ fieldsGameCenterGroups: [FieldsGameCenterGroups]?, _ fieldsGameCenterLeaderboards: [FieldsGameCenterLeaderboards]?, _ fieldsGameCenterAchievements: [FieldsGameCenterAchievements]?, _ fieldsGameCenterAppVersions: [FieldsGameCenterAppVersions]?, _ fieldsGameCenterLeaderboardReleases: [FieldsGameCenterLeaderboardReleases]?, _ limitAchievementReleases: Int?, _ limitGameCenterAchievements: Int?, _ limitGameCenterAppVersions: Int?, _ limitGameCenterLeaderboardSets: Int?, _ limitGameCenterLeaderboards: Int?, _ limitLeaderboardReleases: Int?, _ limitLeaderboardSetReleases: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsGameCenterDetails, forKey: "fields[gameCenterDetails]")
            encoder.encode(include, forKey: "include")
            encoder.encode(fieldsGameCenterAchievementReleases, forKey: "fields[gameCenterAchievementReleases]")
            encoder.encode(fieldsGameCenterLeaderboardSetReleases, forKey: "fields[gameCenterLeaderboardSetReleases]")
            encoder.encode(fieldsGameCenterLeaderboardSets, forKey: "fields[gameCenterLeaderboardSets]")
            encoder.encode(fieldsGameCenterGroups, forKey: "fields[gameCenterGroups]")
            encoder.encode(fieldsGameCenterLeaderboards, forKey: "fields[gameCenterLeaderboards]")
            encoder.encode(fieldsGameCenterAchievements, forKey: "fields[gameCenterAchievements]")
            encoder.encode(fieldsGameCenterAppVersions, forKey: "fields[gameCenterAppVersions]")
            encoder.encode(fieldsGameCenterLeaderboardReleases, forKey: "fields[gameCenterLeaderboardReleases]")
            encoder.encode(limitAchievementReleases, forKey: "limit[achievementReleases]")
            encoder.encode(limitGameCenterAchievements, forKey: "limit[gameCenterAchievements]")
            encoder.encode(limitGameCenterAppVersions, forKey: "limit[gameCenterAppVersions]")
            encoder.encode(limitGameCenterLeaderboardSets, forKey: "limit[gameCenterLeaderboardSets]")
            encoder.encode(limitGameCenterLeaderboards, forKey: "limit[gameCenterLeaderboards]")
            encoder.encode(limitLeaderboardReleases, forKey: "limit[leaderboardReleases]")
            encoder.encode(limitLeaderboardSetReleases, forKey: "limit[leaderboardSetReleases]")
            return encoder.items
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

        public enum FieldsGameCenterAppVersions: String, CaseIterable, Codable, Sendable {
            case appStoreVersion
            case compatibilityVersions
            case enabled
        }

        public enum FieldsGameCenterLeaderboardReleases: String, CaseIterable, Codable, Sendable {
            case gameCenterDetail
            case gameCenterLeaderboard
            case live
        }

        public func patch(_ body: AppStoreAPI.GameCenterDetailUpdateRequest) -> Request<AppStoreAPI.GameCenterDetailResponse> {
            Request(path: path, method: "PATCH", body: body, id: "gameCenterDetails-update_instance")
        }
    }
}