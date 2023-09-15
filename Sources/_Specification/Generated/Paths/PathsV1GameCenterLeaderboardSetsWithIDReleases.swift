// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.GameCenterLeaderboardSets.WithID {
    public var releases: Releases {
        Releases(path: path + "/releases")
    }

    public struct Releases {
        /// Path: `/v1/gameCenterLeaderboardSets/{id}/releases`
        public let path: String

        public func get(filterLive: [String]? = nil, filterGameCenterDetail: [String]? = nil, fieldsGameCenterLeaderboardSetReleases: [FieldsGameCenterLeaderboardSetReleases]? = nil, fieldsGameCenterLeaderboardSets: [FieldsGameCenterLeaderboardSets]? = nil, fieldsGameCenterDetails: [FieldsGameCenterDetails]? = nil, limit: Int? = nil, include: [Include]? = nil) -> Request<_Specification.GameCenterLeaderboardSetReleasesResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(filterLive, filterGameCenterDetail, fieldsGameCenterLeaderboardSetReleases, fieldsGameCenterLeaderboardSets, fieldsGameCenterDetails, limit, include), id: "gameCenterLeaderboardSets-releases-get_to_many_related")
        }

        private func makeGetQuery(_ filterLive: [String]?, _ filterGameCenterDetail: [String]?, _ fieldsGameCenterLeaderboardSetReleases: [FieldsGameCenterLeaderboardSetReleases]?, _ fieldsGameCenterLeaderboardSets: [FieldsGameCenterLeaderboardSets]?, _ fieldsGameCenterDetails: [FieldsGameCenterDetails]?, _ limit: Int?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(filterLive, forKey: "filter[live]")
            encoder.encode(filterGameCenterDetail, forKey: "filter[gameCenterDetail]")
            encoder.encode(fieldsGameCenterLeaderboardSetReleases, forKey: "fields[gameCenterLeaderboardSetReleases]")
            encoder.encode(fieldsGameCenterLeaderboardSets, forKey: "fields[gameCenterLeaderboardSets]")
            encoder.encode(fieldsGameCenterDetails, forKey: "fields[gameCenterDetails]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsGameCenterLeaderboardSetReleases: String, Codable, CaseIterable {
            case gameCenterDetail
            case gameCenterLeaderboardSet
            case live
        }

        public enum FieldsGameCenterLeaderboardSets: String, Codable, CaseIterable {
            case gameCenterDetail
            case gameCenterGroup
            case gameCenterLeaderboards
            case groupLeaderboardSet
            case localizations
            case referenceName
            case releases
            case vendorIdentifier
        }

        public enum FieldsGameCenterDetails: String, Codable, CaseIterable {
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

        public enum Include: String, Codable, CaseIterable {
            case gameCenterDetail
            case gameCenterLeaderboardSet
        }
    }
}