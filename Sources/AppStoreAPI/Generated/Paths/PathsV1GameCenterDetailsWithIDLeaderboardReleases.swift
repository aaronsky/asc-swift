// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.GameCenterDetails.WithID {
    public var leaderboardReleases: LeaderboardReleases {
        LeaderboardReleases(path: path + "/leaderboardReleases")
    }

    public struct LeaderboardReleases {
        /// Path: `/v1/gameCenterDetails/{id}/leaderboardReleases`
        public let path: String

        public func get(filterLive: [String]? = nil, filterGameCenterLeaderboard: [String]? = nil, fieldsGameCenterDetails: [FieldsGameCenterDetails]? = nil, fieldsGameCenterLeaderboards: [FieldsGameCenterLeaderboards]? = nil, fieldsGameCenterLeaderboardReleases: [FieldsGameCenterLeaderboardReleases]? = nil, limit: Int? = nil, include: [Include]? = nil) -> Request<AppStoreAPI.GameCenterLeaderboardReleasesResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(filterLive, filterGameCenterLeaderboard, fieldsGameCenterDetails, fieldsGameCenterLeaderboards, fieldsGameCenterLeaderboardReleases, limit, include), id: "gameCenterDetails-leaderboardReleases-get_to_many_related")
        }

        private func makeGetQuery(_ filterLive: [String]?, _ filterGameCenterLeaderboard: [String]?, _ fieldsGameCenterDetails: [FieldsGameCenterDetails]?, _ fieldsGameCenterLeaderboards: [FieldsGameCenterLeaderboards]?, _ fieldsGameCenterLeaderboardReleases: [FieldsGameCenterLeaderboardReleases]?, _ limit: Int?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(filterLive, forKey: "filter[live]")
            encoder.encode(filterGameCenterLeaderboard, forKey: "filter[gameCenterLeaderboard]")
            encoder.encode(fieldsGameCenterDetails, forKey: "fields[gameCenterDetails]")
            encoder.encode(fieldsGameCenterLeaderboards, forKey: "fields[gameCenterLeaderboards]")
            encoder.encode(fieldsGameCenterLeaderboardReleases, forKey: "fields[gameCenterLeaderboardReleases]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(include, forKey: "include")
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

        public enum FieldsGameCenterLeaderboardReleases: String, CaseIterable, Codable, Sendable {
            case gameCenterDetail
            case gameCenterLeaderboard
            case live
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case gameCenterDetail
            case gameCenterLeaderboard
        }
    }
}