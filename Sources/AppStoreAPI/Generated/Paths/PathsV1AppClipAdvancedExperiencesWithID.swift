// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.AppClipAdvancedExperiences {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/appClipAdvancedExperiences/{id}`
        public let path: String

        public func get(fieldsAppClipAdvancedExperiences: [FieldsAppClipAdvancedExperiences]? = nil, include: [Include]? = nil, limitLocalizations: Int? = nil) -> Request<AppStoreAPI.AppClipAdvancedExperienceResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsAppClipAdvancedExperiences, include, limitLocalizations), id: "appClipAdvancedExperiences-get_instance")
        }

        private func makeGetQuery(_ fieldsAppClipAdvancedExperiences: [FieldsAppClipAdvancedExperiences]?, _ include: [Include]?, _ limitLocalizations: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsAppClipAdvancedExperiences, forKey: "fields[appClipAdvancedExperiences]")
            encoder.encode(include, forKey: "include")
            encoder.encode(limitLocalizations, forKey: "limit[localizations]")
            return encoder.items
        }

        public enum FieldsAppClipAdvancedExperiences: String, CaseIterable, Codable, Sendable {
            case action
            case appClip
            case businessCategory
            case defaultLanguage
            case headerImage
            case isPoweredBy
            case link
            case localizations
            case place
            case placeStatus
            case removed
            case status
            case version
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case appClip
            case headerImage
            case localizations
        }

        public func patch(_ body: AppStoreAPI.AppClipAdvancedExperienceUpdateRequest) -> Request<AppStoreAPI.AppClipAdvancedExperienceResponse> {
            Request(path: path, method: "PATCH", body: body, id: "appClipAdvancedExperiences-update_instance")
        }
    }
}