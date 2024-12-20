// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.AppPreviewSets.WithID {
    public var appPreviews: AppPreviews {
        AppPreviews(path: path + "/appPreviews")
    }

    public struct AppPreviews {
        /// Path: `/v1/appPreviewSets/{id}/appPreviews`
        public let path: String

        public func get(fieldsAppPreviews: [FieldsAppPreviews]? = nil, fieldsAppPreviewSets: [FieldsAppPreviewSets]? = nil, limit: Int? = nil, include: [Include]? = nil) -> Request<AppStoreAPI.AppPreviewsResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsAppPreviews, fieldsAppPreviewSets, limit, include), id: "appPreviewSets_appPreviews_getToManyRelated")
        }

        private func makeGetQuery(_ fieldsAppPreviews: [FieldsAppPreviews]?, _ fieldsAppPreviewSets: [FieldsAppPreviewSets]?, _ limit: Int?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsAppPreviews, forKey: "fields[appPreviews]")
            encoder.encode(fieldsAppPreviewSets, forKey: "fields[appPreviewSets]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsAppPreviews: String, CaseIterable, Codable, Sendable {
            case fileSize
            case fileName
            case sourceFileChecksum
            case previewFrameTimeCode
            case mimeType
            case videoURL = "videoUrl"
            case previewFrameImage
            case previewImage
            case uploadOperations
            case assetDeliveryState
            case videoDeliveryState
            case appPreviewSet
        }

        public enum FieldsAppPreviewSets: String, CaseIterable, Codable, Sendable {
            case previewType
            case appStoreVersionLocalization
            case appCustomProductPageLocalization
            case appStoreVersionExperimentTreatmentLocalization
            case appPreviews
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case appPreviewSet
        }
    }
}
