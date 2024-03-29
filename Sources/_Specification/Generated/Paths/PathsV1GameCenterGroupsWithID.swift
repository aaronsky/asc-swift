// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.GameCenterGroups {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/gameCenterGroups/{id}`
        public let path: String

        public func get(fieldsGameCenterGroups: [FieldsGameCenterGroups]? = nil, include: [Include]? = nil, fieldsGameCenterLeaderboardSets: [FieldsGameCenterLeaderboardSets]? = nil, fieldsGameCenterDetails: [FieldsGameCenterDetails]? = nil, fieldsGameCenterLeaderboards: [FieldsGameCenterLeaderboards]? = nil, fieldsGameCenterAchievements: [FieldsGameCenterAchievements]? = nil, limitGameCenterAchievements: Int? = nil, limitGameCenterDetails: Int? = nil, limitGameCenterLeaderboardSets: Int? = nil, limitGameCenterLeaderboards: Int? = nil) -> Request<_Specification.GameCenterGroupResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsGameCenterGroups, include, fieldsGameCenterLeaderboardSets, fieldsGameCenterDetails, fieldsGameCenterLeaderboards, fieldsGameCenterAchievements, limitGameCenterAchievements, limitGameCenterDetails, limitGameCenterLeaderboardSets, limitGameCenterLeaderboards), id: "gameCenterGroups-get_instance")
        }

        private func makeGetQuery(_ fieldsGameCenterGroups: [FieldsGameCenterGroups]?, _ include: [Include]?, _ fieldsGameCenterLeaderboardSets: [FieldsGameCenterLeaderboardSets]?, _ fieldsGameCenterDetails: [FieldsGameCenterDetails]?, _ fieldsGameCenterLeaderboards: [FieldsGameCenterLeaderboards]?, _ fieldsGameCenterAchievements: [FieldsGameCenterAchievements]?, _ limitGameCenterAchievements: Int?, _ limitGameCenterDetails: Int?, _ limitGameCenterLeaderboardSets: Int?, _ limitGameCenterLeaderboards: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsGameCenterGroups, forKey: "fields[gameCenterGroups]")
            encoder.encode(include, forKey: "include")
            encoder.encode(fieldsGameCenterLeaderboardSets, forKey: "fields[gameCenterLeaderboardSets]")
            encoder.encode(fieldsGameCenterDetails, forKey: "fields[gameCenterDetails]")
            encoder.encode(fieldsGameCenterLeaderboards, forKey: "fields[gameCenterLeaderboards]")
            encoder.encode(fieldsGameCenterAchievements, forKey: "fields[gameCenterAchievements]")
            encoder.encode(limitGameCenterAchievements, forKey: "limit[gameCenterAchievements]")
            encoder.encode(limitGameCenterDetails, forKey: "limit[gameCenterDetails]")
            encoder.encode(limitGameCenterLeaderboardSets, forKey: "limit[gameCenterLeaderboardSets]")
            encoder.encode(limitGameCenterLeaderboards, forKey: "limit[gameCenterLeaderboards]")
            return encoder.items
        }

        public enum FieldsGameCenterGroups: String, CaseIterable, Codable, Sendable {
            case gameCenterAchievements
            case gameCenterDetails
            case gameCenterLeaderboardSets
            case gameCenterLeaderboards
            case referenceName
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case gameCenterAchievements
            case gameCenterDetails
            case gameCenterLeaderboardSets
            case gameCenterLeaderboards
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

        public func patch(_ body: _Specification.GameCenterGroupUpdateRequest) -> Request<_Specification.GameCenterGroupResponse> {
            Request(path: path, method: "PATCH", body: body, id: "gameCenterGroups-update_instance")
        }

        public var delete: Request<Void> {
            Request(path: path, method: "DELETE", id: "gameCenterGroups-delete_instance")
        }
    }
}
