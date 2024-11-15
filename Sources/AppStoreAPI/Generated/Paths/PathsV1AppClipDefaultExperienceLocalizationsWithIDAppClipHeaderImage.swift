// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.AppClipDefaultExperienceLocalizations.WithID {
    public var appClipHeaderImage: AppClipHeaderImage {
        AppClipHeaderImage(path: path + "/appClipHeaderImage")
    }

    public struct AppClipHeaderImage {
        /// Path: `/v1/appClipDefaultExperienceLocalizations/{id}/appClipHeaderImage`
        public let path: String

        public func get(fieldsAppClipHeaderImages: [FieldsAppClipHeaderImages]? = nil, fieldsAppClipDefaultExperienceLocalizations: [FieldsAppClipDefaultExperienceLocalizations]? = nil, include: [Include]? = nil) -> Request<AppStoreAPI.AppClipHeaderImageResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsAppClipHeaderImages, fieldsAppClipDefaultExperienceLocalizations, include), id: "appClipDefaultExperienceLocalizations_appClipHeaderImage_getToOneRelated")
        }

        private func makeGetQuery(_ fieldsAppClipHeaderImages: [FieldsAppClipHeaderImages]?, _ fieldsAppClipDefaultExperienceLocalizations: [FieldsAppClipDefaultExperienceLocalizations]?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsAppClipHeaderImages, forKey: "fields[appClipHeaderImages]")
            encoder.encode(fieldsAppClipDefaultExperienceLocalizations, forKey: "fields[appClipDefaultExperienceLocalizations]")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsAppClipHeaderImages: String, CaseIterable, Codable, Sendable {
            case fileSize
            case fileName
            case sourceFileChecksum
            case imageAsset
            case uploadOperations
            case assetDeliveryState
            case appClipDefaultExperienceLocalization
        }

        public enum FieldsAppClipDefaultExperienceLocalizations: String, CaseIterable, Codable, Sendable {
            case locale
            case subtitle
            case appClipDefaultExperience
            case appClipHeaderImage
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case appClipDefaultExperienceLocalization
        }
    }
}
