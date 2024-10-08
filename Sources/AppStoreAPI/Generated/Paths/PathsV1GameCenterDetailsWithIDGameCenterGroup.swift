// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.GameCenterDetails.WithID {
    public var gameCenterGroup: GameCenterGroup {
        GameCenterGroup(path: path + "/gameCenterGroup")
    }

    public struct GameCenterGroup {
        /// Path: `/v1/gameCenterDetails/{id}/gameCenterGroup`
        public let path: String

        public func get(fieldsGameCenterGroups: [FieldsGameCenterGroups]? = nil, fieldsGameCenterDetails: [FieldsGameCenterDetails]? = nil, fieldsGameCenterLeaderboards: [FieldsGameCenterLeaderboards]? = nil, fieldsGameCenterLeaderboardSets: [FieldsGameCenterLeaderboardSets]? = nil, fieldsGameCenterAchievements: [FieldsGameCenterAchievements]? = nil, include: [Include]? = nil, limitGameCenterDetails: Int? = nil, limitGameCenterLeaderboards: Int? = nil, limitGameCenterLeaderboardSets: Int? = nil, limitGameCenterAchievements: Int? = nil) -> Request<AppStoreAPI.GameCenterGroupResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsGameCenterGroups, fieldsGameCenterDetails, fieldsGameCenterLeaderboards, fieldsGameCenterLeaderboardSets, fieldsGameCenterAchievements, include, limitGameCenterDetails, limitGameCenterLeaderboards, limitGameCenterLeaderboardSets, limitGameCenterAchievements), id: "gameCenterDetails_gameCenterGroup_getToOneRelated")
        }

        private func makeGetQuery(_ fieldsGameCenterGroups: [FieldsGameCenterGroups]?, _ fieldsGameCenterDetails: [FieldsGameCenterDetails]?, _ fieldsGameCenterLeaderboards: [FieldsGameCenterLeaderboards]?, _ fieldsGameCenterLeaderboardSets: [FieldsGameCenterLeaderboardSets]?, _ fieldsGameCenterAchievements: [FieldsGameCenterAchievements]?, _ include: [Include]?, _ limitGameCenterDetails: Int?, _ limitGameCenterLeaderboards: Int?, _ limitGameCenterLeaderboardSets: Int?, _ limitGameCenterAchievements: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsGameCenterGroups, forKey: "fields[gameCenterGroups]")
            encoder.encode(fieldsGameCenterDetails, forKey: "fields[gameCenterDetails]")
            encoder.encode(fieldsGameCenterLeaderboards, forKey: "fields[gameCenterLeaderboards]")
            encoder.encode(fieldsGameCenterLeaderboardSets, forKey: "fields[gameCenterLeaderboardSets]")
            encoder.encode(fieldsGameCenterAchievements, forKey: "fields[gameCenterAchievements]")
            encoder.encode(include, forKey: "include")
            encoder.encode(limitGameCenterDetails, forKey: "limit[gameCenterDetails]")
            encoder.encode(limitGameCenterLeaderboards, forKey: "limit[gameCenterLeaderboards]")
            encoder.encode(limitGameCenterLeaderboardSets, forKey: "limit[gameCenterLeaderboardSets]")
            encoder.encode(limitGameCenterAchievements, forKey: "limit[gameCenterAchievements]")
            return encoder.items
        }

        public enum FieldsGameCenterGroups: String, CaseIterable, Codable, Sendable {
            case referenceName
            case gameCenterDetails
            case gameCenterLeaderboards
            case gameCenterLeaderboardSets
            case gameCenterAchievements
        }

        public enum FieldsGameCenterDetails: String, CaseIterable, Codable, Sendable {
            case arcadeEnabled
            case challengeEnabled
            case app
            case gameCenterAppVersions
            case gameCenterGroup
            case gameCenterLeaderboards
            case gameCenterLeaderboardSets
            case gameCenterAchievements
            case defaultLeaderboard
            case defaultGroupLeaderboard
            case achievementReleases
            case leaderboardReleases
            case leaderboardSetReleases
        }

        public enum FieldsGameCenterLeaderboards: String, CaseIterable, Codable, Sendable {
            case defaultFormatter
            case referenceName
            case vendorIdentifier
            case submissionType
            case scoreSortType
            case scoreRangeStart
            case scoreRangeEnd
            case recurrenceStartDate
            case recurrenceDuration
            case recurrenceRule
            case archived
            case gameCenterDetail
            case gameCenterGroup
            case groupLeaderboard
            case gameCenterLeaderboardSets
            case localizations
            case releases
        }

        public enum FieldsGameCenterLeaderboardSets: String, CaseIterable, Codable, Sendable {
            case referenceName
            case vendorIdentifier
            case gameCenterDetail
            case gameCenterGroup
            case groupLeaderboardSet
            case localizations
            case gameCenterLeaderboards
            case releases
        }

        public enum FieldsGameCenterAchievements: String, CaseIterable, Codable, Sendable {
            case referenceName
            case vendorIdentifier
            case points
            case showBeforeEarned
            case repeatable
            case archived
            case gameCenterDetail
            case gameCenterGroup
            case groupAchievement
            case localizations
            case releases
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case gameCenterDetails
            case gameCenterLeaderboards
            case gameCenterLeaderboardSets
            case gameCenterAchievements
        }
    }
}
