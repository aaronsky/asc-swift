// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.SubscriptionLocalizations {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/subscriptionLocalizations/{id}`
        public let path: String

        public func get(fieldsSubscriptionLocalizations: [FieldsSubscriptionLocalizations]? = nil, include: [Include]? = nil) -> Request<AppStoreAPI.SubscriptionLocalizationResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsSubscriptionLocalizations, include), id: "subscriptionLocalizations_getInstance")
        }

        private func makeGetQuery(_ fieldsSubscriptionLocalizations: [FieldsSubscriptionLocalizations]?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsSubscriptionLocalizations, forKey: "fields[subscriptionLocalizations]")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsSubscriptionLocalizations: String, CaseIterable, Codable, Sendable {
            case name
            case locale
            case description
            case state
            case subscription
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case subscription
        }

        public func patch(_ body: AppStoreAPI.SubscriptionLocalizationUpdateRequest) -> Request<AppStoreAPI.SubscriptionLocalizationResponse> {
            Request(path: path, method: "PATCH", body: body, id: "subscriptionLocalizations_updateInstance")
        }

        public var delete: Request<Void> {
            Request(path: path, method: "DELETE", id: "subscriptionLocalizations_deleteInstance")
        }
    }
}
