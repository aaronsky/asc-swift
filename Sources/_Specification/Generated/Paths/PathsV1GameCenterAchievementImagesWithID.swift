// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.GameCenterAchievementImages {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/gameCenterAchievementImages/{id}`
        public let path: String

        public func get(fieldsGameCenterAchievementImages: [FieldsGameCenterAchievementImages]? = nil, include: [Include]? = nil) -> Request<_Specification.GameCenterAchievementImageResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsGameCenterAchievementImages, include), id: "gameCenterAchievementImages-get_instance")
        }

        private func makeGetQuery(_ fieldsGameCenterAchievementImages: [FieldsGameCenterAchievementImages]?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsGameCenterAchievementImages, forKey: "fields[gameCenterAchievementImages]")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsGameCenterAchievementImages: String, CaseIterable, Codable, Sendable {
            case assetDeliveryState
            case fileName
            case fileSize
            case gameCenterAchievementLocalization
            case imageAsset
            case uploadOperations
            case uploaded
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case gameCenterAchievementLocalization
        }

        public func patch(_ body: _Specification.GameCenterAchievementImageUpdateRequest) -> Request<_Specification.GameCenterAchievementImageResponse> {
            Request(path: path, method: "PATCH", body: body, id: "gameCenterAchievementImages-update_instance")
        }

        public var delete: Request<Void> {
            Request(path: path, method: "DELETE", id: "gameCenterAchievementImages-delete_instance")
        }
    }
}
