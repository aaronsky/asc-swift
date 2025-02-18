// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.AppEventScreenshots {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/appEventScreenshots/{id}`
        public let path: String

        public func get(fieldsAppEventScreenshots: [FieldsAppEventScreenshots]? = nil, include: [Include]? = nil) -> Request<AppStoreAPI.AppEventScreenshotResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsAppEventScreenshots, include), id: "appEventScreenshots_getInstance")
        }

        private func makeGetQuery(_ fieldsAppEventScreenshots: [FieldsAppEventScreenshots]?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsAppEventScreenshots, forKey: "fields[appEventScreenshots]")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsAppEventScreenshots: String, CaseIterable, Codable, Sendable {
            case fileSize
            case fileName
            case imageAsset
            case assetToken
            case uploadOperations
            case assetDeliveryState
            case appEventAssetType
            case appEventLocalization
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case appEventLocalization
        }

        public func patch(_ body: AppStoreAPI.AppEventScreenshotUpdateRequest) -> Request<AppStoreAPI.AppEventScreenshotResponse> {
            Request(path: path, method: "PATCH", body: body, id: "appEventScreenshots_updateInstance")
        }

        public var delete: Request<Void> {
            Request(path: path, method: "DELETE", id: "appEventScreenshots_deleteInstance")
        }
    }
}
