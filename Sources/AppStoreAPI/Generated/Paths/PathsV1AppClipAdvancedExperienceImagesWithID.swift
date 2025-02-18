// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.AppClipAdvancedExperienceImages {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/appClipAdvancedExperienceImages/{id}`
        public let path: String

        public func get(fieldsAppClipAdvancedExperienceImages: [FieldsAppClipAdvancedExperienceImages]? = nil) -> Request<AppStoreAPI.AppClipAdvancedExperienceImageResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsAppClipAdvancedExperienceImages), id: "appClipAdvancedExperienceImages_getInstance")
        }

        private func makeGetQuery(_ fieldsAppClipAdvancedExperienceImages: [FieldsAppClipAdvancedExperienceImages]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(fieldsAppClipAdvancedExperienceImages, forKey: "fields[appClipAdvancedExperienceImages]", explode: false)
            return encoder.items
        }

        public enum FieldsAppClipAdvancedExperienceImages: String, CaseIterable, Codable, Sendable {
            case fileSize
            case fileName
            case sourceFileChecksum
            case imageAsset
            case uploadOperations
            case assetDeliveryState
        }

        public func patch(_ body: AppStoreAPI.AppClipAdvancedExperienceImageUpdateRequest) -> Request<AppStoreAPI.AppClipAdvancedExperienceImageResponse> {
            Request(path: path, method: "PATCH", body: body, id: "appClipAdvancedExperienceImages_updateInstance")
        }
    }
}
