// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.SubscriptionLocalizations {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/subscriptionLocalizations/{id}`
        public let path: String

        public func get(fieldsSubscriptionLocalizations: [FieldsSubscriptionLocalizations]? = nil, include: [Include]? = nil) -> Request<_Specification.SubscriptionLocalizationResponse> {
            Request(method: "GET", url: path, query: makeGetQuery(fieldsSubscriptionLocalizations, include), id: "subscriptionLocalizations-get_instance")
        }

        private func makeGetQuery(_ fieldsSubscriptionLocalizations: [FieldsSubscriptionLocalizations]?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsSubscriptionLocalizations, forKey: "fields[subscriptionLocalizations]")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsSubscriptionLocalizations: String, Codable, CaseIterable {
            case description
            case locale
            case name
            case state
            case subscription
        }

        public enum Include: String, Codable, CaseIterable {
            case subscription
        }

        public func patch(_ body: _Specification.SubscriptionLocalizationUpdateRequest) -> Request<_Specification.SubscriptionLocalizationResponse> {
            Request(method: "PATCH", url: path, body: body, id: "subscriptionLocalizations-update_instance")
        }

        public var delete: Request<Void> {
            Request(method: "DELETE", url: path, id: "subscriptionLocalizations-delete_instance")
        }
    }
}
