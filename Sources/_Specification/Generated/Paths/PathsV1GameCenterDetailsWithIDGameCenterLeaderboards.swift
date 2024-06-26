// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.GameCenterDetails.WithID {
    public var gameCenterLeaderboards: GameCenterLeaderboards {
        GameCenterLeaderboards(path: path + "/gameCenterLeaderboards")
    }

    public struct GameCenterLeaderboards {
        /// Path: `/v1/gameCenterDetails/{id}/gameCenterLeaderboards`
        public let path: String

        public func get(filterArchived: [String]? = nil, filterReferenceName: [String]? = nil, filterID: [String]? = nil, fieldsGameCenterLeaderboardLocalizations: [FieldsGameCenterLeaderboardLocalizations]? = nil, fieldsGameCenterLeaderboardSets: [FieldsGameCenterLeaderboardSets]? = nil, fieldsGameCenterGroups: [FieldsGameCenterGroups]? = nil, fieldsGameCenterDetails: [FieldsGameCenterDetails]? = nil, fieldsGameCenterLeaderboards: [FieldsGameCenterLeaderboards]? = nil, fieldsGameCenterLeaderboardReleases: [FieldsGameCenterLeaderboardReleases]? = nil, limit: Int? = nil, limitGameCenterLeaderboardSets: Int? = nil, limitLocalizations: Int? = nil, limitReleases: Int? = nil, include: [Include]? = nil) -> Request<_Specification.GameCenterLeaderboardsResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(filterArchived, filterReferenceName, filterID, fieldsGameCenterLeaderboardLocalizations, fieldsGameCenterLeaderboardSets, fieldsGameCenterGroups, fieldsGameCenterDetails, fieldsGameCenterLeaderboards, fieldsGameCenterLeaderboardReleases, limit, limitGameCenterLeaderboardSets, limitLocalizations, limitReleases, include), id: "gameCenterDetails-gameCenterLeaderboards-get_to_many_related")
        }

        private func makeGetQuery(_ filterArchived: [String]?, _ filterReferenceName: [String]?, _ filterID: [String]?, _ fieldsGameCenterLeaderboardLocalizations: [FieldsGameCenterLeaderboardLocalizations]?, _ fieldsGameCenterLeaderboardSets: [FieldsGameCenterLeaderboardSets]?, _ fieldsGameCenterGroups: [FieldsGameCenterGroups]?, _ fieldsGameCenterDetails: [FieldsGameCenterDetails]?, _ fieldsGameCenterLeaderboards: [FieldsGameCenterLeaderboards]?, _ fieldsGameCenterLeaderboardReleases: [FieldsGameCenterLeaderboardReleases]?, _ limit: Int?, _ limitGameCenterLeaderboardSets: Int?, _ limitLocalizations: Int?, _ limitReleases: Int?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(filterArchived, forKey: "filter[archived]")
            encoder.encode(filterReferenceName, forKey: "filter[referenceName]")
            encoder.encode(filterID, forKey: "filter[id]")
            encoder.encode(fieldsGameCenterLeaderboardLocalizations, forKey: "fields[gameCenterLeaderboardLocalizations]")
            encoder.encode(fieldsGameCenterLeaderboardSets, forKey: "fields[gameCenterLeaderboardSets]")
            encoder.encode(fieldsGameCenterGroups, forKey: "fields[gameCenterGroups]")
            encoder.encode(fieldsGameCenterDetails, forKey: "fields[gameCenterDetails]")
            encoder.encode(fieldsGameCenterLeaderboards, forKey: "fields[gameCenterLeaderboards]")
            encoder.encode(fieldsGameCenterLeaderboardReleases, forKey: "fields[gameCenterLeaderboardReleases]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(limitGameCenterLeaderboardSets, forKey: "limit[gameCenterLeaderboardSets]")
            encoder.encode(limitLocalizations, forKey: "limit[localizations]")
            encoder.encode(limitReleases, forKey: "limit[releases]")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsGameCenterLeaderboardLocalizations: String, CaseIterable, Codable, Sendable {
            case formatterOverride
            case formatterSuffix
            case formatterSuffixSingular
            case gameCenterLeaderboard
            case gameCenterLeaderboardImage
            case locale
            case name
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

        public enum FieldsGameCenterLeaderboardReleases: String, CaseIterable, Codable, Sendable {
            case gameCenterDetail
            case gameCenterLeaderboard
            case live
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case gameCenterDetail
            case gameCenterGroup
            case gameCenterLeaderboardSets
            case groupLeaderboard
            case localizations
            case releases
        }
    }
}
