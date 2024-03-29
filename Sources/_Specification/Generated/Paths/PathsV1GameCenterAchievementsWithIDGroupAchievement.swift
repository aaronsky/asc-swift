// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.GameCenterAchievements.WithID {
    public var groupAchievement: GroupAchievement {
        GroupAchievement(path: path + "/groupAchievement")
    }

    public struct GroupAchievement {
        /// Path: `/v1/gameCenterAchievements/{id}/groupAchievement`
        public let path: String

        public func get(fieldsGameCenterAchievementReleases: [FieldsGameCenterAchievementReleases]? = nil, fieldsGameCenterGroups: [FieldsGameCenterGroups]? = nil, fieldsGameCenterDetails: [FieldsGameCenterDetails]? = nil, fieldsGameCenterAchievementLocalizations: [FieldsGameCenterAchievementLocalizations]? = nil, fieldsGameCenterAchievements: [FieldsGameCenterAchievements]? = nil, limitLocalizations: Int? = nil, limitReleases: Int? = nil, include: [Include]? = nil) -> Request<_Specification.GameCenterAchievementResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsGameCenterAchievementReleases, fieldsGameCenterGroups, fieldsGameCenterDetails, fieldsGameCenterAchievementLocalizations, fieldsGameCenterAchievements, limitLocalizations, limitReleases, include), id: "gameCenterAchievements-groupAchievement-get_to_one_related")
        }

        private func makeGetQuery(_ fieldsGameCenterAchievementReleases: [FieldsGameCenterAchievementReleases]?, _ fieldsGameCenterGroups: [FieldsGameCenterGroups]?, _ fieldsGameCenterDetails: [FieldsGameCenterDetails]?, _ fieldsGameCenterAchievementLocalizations: [FieldsGameCenterAchievementLocalizations]?, _ fieldsGameCenterAchievements: [FieldsGameCenterAchievements]?, _ limitLocalizations: Int?, _ limitReleases: Int?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsGameCenterAchievementReleases, forKey: "fields[gameCenterAchievementReleases]")
            encoder.encode(fieldsGameCenterGroups, forKey: "fields[gameCenterGroups]")
            encoder.encode(fieldsGameCenterDetails, forKey: "fields[gameCenterDetails]")
            encoder.encode(fieldsGameCenterAchievementLocalizations, forKey: "fields[gameCenterAchievementLocalizations]")
            encoder.encode(fieldsGameCenterAchievements, forKey: "fields[gameCenterAchievements]")
            encoder.encode(limitLocalizations, forKey: "limit[localizations]")
            encoder.encode(limitReleases, forKey: "limit[releases]")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsGameCenterAchievementReleases: String, CaseIterable, Codable, Sendable {
            case gameCenterAchievement
            case gameCenterDetail
            case live
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

        public enum FieldsGameCenterAchievementLocalizations: String, CaseIterable, Codable, Sendable {
            case afterEarnedDescription
            case beforeEarnedDescription
            case gameCenterAchievement
            case gameCenterAchievementImage
            case locale
            case name
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

        public enum Include: String, CaseIterable, Codable, Sendable {
            case gameCenterDetail
            case gameCenterGroup
            case groupAchievement
            case localizations
            case releases
        }
    }
}
