// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.AppScreenshotSets.WithID {
    public var appScreenshots: AppScreenshots {
        AppScreenshots(path: path + "/appScreenshots")
    }

    public struct AppScreenshots {
        /// Path: `/v1/appScreenshotSets/{id}/appScreenshots`
        public let path: String

        public func get(fieldsAppScreenshots: [FieldsAppScreenshots]? = nil, fieldsAppScreenshotSets: [FieldsAppScreenshotSets]? = nil, limit: Int? = nil, include: [Include]? = nil) -> Request<AppStoreAPI.AppScreenshotsResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsAppScreenshots, fieldsAppScreenshotSets, limit, include), id: "appScreenshotSets_appScreenshots_getToManyRelated")
        }

        private func makeGetQuery(_ fieldsAppScreenshots: [FieldsAppScreenshots]?, _ fieldsAppScreenshotSets: [FieldsAppScreenshotSets]?, _ limit: Int?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsAppScreenshots, forKey: "fields[appScreenshots]")
            encoder.encode(fieldsAppScreenshotSets, forKey: "fields[appScreenshotSets]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsAppScreenshots: String, CaseIterable, Codable, Sendable {
            case fileSize
            case fileName
            case sourceFileChecksum
            case imageAsset
            case assetToken
            case assetType
            case uploadOperations
            case assetDeliveryState
            case appScreenshotSet
        }

        public enum FieldsAppScreenshotSets: String, CaseIterable, Codable, Sendable {
            case screenshotDisplayType
            case appStoreVersionLocalization
            case appCustomProductPageLocalization
            case appStoreVersionExperimentTreatmentLocalization
            case appScreenshots
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case appScreenshotSet
        }
    }
}
