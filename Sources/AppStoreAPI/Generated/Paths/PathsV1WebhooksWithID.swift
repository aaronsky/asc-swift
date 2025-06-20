// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.Webhooks {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/webhooks/{id}`
        public let path: String

        public func get(fieldsWebhooks: [FieldsWebhooks]? = nil, include: [Include]? = nil) -> Request<AppStoreAPI.WebhookResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsWebhooks, include), id: "webhooks_getInstance")
        }

        private func makeGetQuery(_ fieldsWebhooks: [FieldsWebhooks]?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsWebhooks, forKey: "fields[webhooks]")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsWebhooks: String, CaseIterable, Codable, Sendable {
            case enabled
            case eventTypes
            case name
            case url
            case app
            case deliveries
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case app
        }

        public func patch(_ body: AppStoreAPI.WebhookUpdateRequest) -> Request<AppStoreAPI.WebhookResponse> {
            Request(path: path, method: "PATCH", body: body, id: "webhooks_updateInstance")
        }

        public var delete: Request<Void> {
            Request(path: path, method: "DELETE", id: "webhooks_deleteInstance")
        }
    }
}
