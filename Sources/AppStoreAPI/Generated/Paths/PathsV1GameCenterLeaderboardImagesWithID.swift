// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.GameCenterLeaderboardImages {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/gameCenterLeaderboardImages/{id}`
        public let path: String

        public func get(fieldsGameCenterLeaderboardImages: [FieldsGameCenterLeaderboardImages]? = nil, include: [Include]? = nil) -> Request<AppStoreAPI.GameCenterLeaderboardImageResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsGameCenterLeaderboardImages, include), id: "gameCenterLeaderboardImages-get_instance")
        }

        private func makeGetQuery(_ fieldsGameCenterLeaderboardImages: [FieldsGameCenterLeaderboardImages]?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsGameCenterLeaderboardImages, forKey: "fields[gameCenterLeaderboardImages]")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsGameCenterLeaderboardImages: String, CaseIterable, Codable, Sendable {
            case assetDeliveryState
            case fileName
            case fileSize
            case gameCenterLeaderboardLocalization
            case imageAsset
            case uploadOperations
            case uploaded
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case gameCenterLeaderboardLocalization
        }

        public func patch(_ body: AppStoreAPI.GameCenterLeaderboardImageUpdateRequest) -> Request<AppStoreAPI.GameCenterLeaderboardImageResponse> {
            Request(path: path, method: "PATCH", body: body, id: "gameCenterLeaderboardImages-update_instance")
        }

        public var delete: Request<Void> {
            Request(path: path, method: "DELETE", id: "gameCenterLeaderboardImages-delete_instance")
        }
    }
}