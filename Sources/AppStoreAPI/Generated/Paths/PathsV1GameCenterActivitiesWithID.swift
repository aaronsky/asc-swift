// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.GameCenterActivities {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/gameCenterActivities/{id}`
        public let path: String

        public func get(fieldsGameCenterActivities: [FieldsGameCenterActivities]? = nil, fieldsGameCenterActivityVersions: [FieldsGameCenterActivityVersions]? = nil, include: [Include]? = nil, limitAchievements: Int? = nil, limitLeaderboards: Int? = nil, limitVersions: Int? = nil) -> Request<AppStoreAPI.GameCenterActivityResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsGameCenterActivities, fieldsGameCenterActivityVersions, include, limitAchievements, limitLeaderboards, limitVersions), id: "gameCenterActivities_getInstance")
        }

        private func makeGetQuery(_ fieldsGameCenterActivities: [FieldsGameCenterActivities]?, _ fieldsGameCenterActivityVersions: [FieldsGameCenterActivityVersions]?, _ include: [Include]?, _ limitAchievements: Int?, _ limitLeaderboards: Int?, _ limitVersions: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsGameCenterActivities, forKey: "fields[gameCenterActivities]")
            encoder.encode(fieldsGameCenterActivityVersions, forKey: "fields[gameCenterActivityVersions]")
            encoder.encode(include, forKey: "include")
            encoder.encode(limitAchievements, forKey: "limit[achievements]")
            encoder.encode(limitLeaderboards, forKey: "limit[leaderboards]")
            encoder.encode(limitVersions, forKey: "limit[versions]")
            return encoder.items
        }

        public enum FieldsGameCenterActivities: String, CaseIterable, Codable, Sendable {
            case referenceName
            case vendorIdentifier
            case playStyle
            case minimumPlayersCount
            case maximumPlayersCount
            case supportsPartyCode
            case archived
            case properties
            case gameCenterDetail
            case gameCenterGroup
            case achievements
            case leaderboards
            case versions
        }

        public enum FieldsGameCenterActivityVersions: String, CaseIterable, Codable, Sendable {
            case version
            case state
            case fallbackURL = "fallbackUrl"
            case activity
            case localizations
            case defaultImage
            case releases
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case gameCenterDetail
            case gameCenterGroup
            case achievements
            case leaderboards
            case versions
        }

        public func patch(_ body: AppStoreAPI.GameCenterActivityUpdateRequest) -> Request<AppStoreAPI.GameCenterActivityResponse> {
            Request(path: path, method: "PATCH", body: body, id: "gameCenterActivities_updateInstance")
        }

        public var delete: Request<Void> {
            Request(path: path, method: "DELETE", id: "gameCenterActivities_deleteInstance")
        }
    }
}
