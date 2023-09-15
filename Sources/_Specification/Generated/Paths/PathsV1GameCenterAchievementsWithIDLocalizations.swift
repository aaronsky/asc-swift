// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.GameCenterAchievements.WithID {
    public var localizations: Localizations {
        Localizations(path: path + "/localizations")
    }

    public struct Localizations {
        /// Path: `/v1/gameCenterAchievements/{id}/localizations`
        public let path: String

        public func get(fieldsGameCenterAchievementImages: [FieldsGameCenterAchievementImages]? = nil, fieldsGameCenterAchievementLocalizations: [FieldsGameCenterAchievementLocalizations]? = nil, fieldsGameCenterAchievements: [FieldsGameCenterAchievements]? = nil, limit: Int? = nil, include: [Include]? = nil) -> Request<_Specification.GameCenterAchievementLocalizationsResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsGameCenterAchievementImages, fieldsGameCenterAchievementLocalizations, fieldsGameCenterAchievements, limit, include), id: "gameCenterAchievements-localizations-get_to_many_related")
        }

        private func makeGetQuery(_ fieldsGameCenterAchievementImages: [FieldsGameCenterAchievementImages]?, _ fieldsGameCenterAchievementLocalizations: [FieldsGameCenterAchievementLocalizations]?, _ fieldsGameCenterAchievements: [FieldsGameCenterAchievements]?, _ limit: Int?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsGameCenterAchievementImages, forKey: "fields[gameCenterAchievementImages]")
            encoder.encode(fieldsGameCenterAchievementLocalizations, forKey: "fields[gameCenterAchievementLocalizations]")
            encoder.encode(fieldsGameCenterAchievements, forKey: "fields[gameCenterAchievements]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsGameCenterAchievementImages: String, Codable, CaseIterable {
            case assetDeliveryState
            case fileName
            case fileSize
            case gameCenterAchievementLocalization
            case imageAsset
            case uploadOperations
            case uploaded
        }

        public enum FieldsGameCenterAchievementLocalizations: String, Codable, CaseIterable {
            case afterEarnedDescription
            case beforeEarnedDescription
            case gameCenterAchievement
            case gameCenterAchievementImage
            case locale
            case name
        }

        public enum FieldsGameCenterAchievements: String, Codable, CaseIterable {
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

        public enum Include: String, Codable, CaseIterable {
            case gameCenterAchievement
            case gameCenterAchievementImage
        }
    }
}