// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.Devices {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/devices/{id}`
        public let path: String

        public func get(fieldsDevices: [FieldsDevices]? = nil) -> Request<AppStoreAPI.DeviceResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsDevices), id: "devices-get_instance")
        }

        private func makeGetQuery(_ fieldsDevices: [FieldsDevices]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(fieldsDevices, forKey: "fields[devices]", explode: false)
            return encoder.items
        }

        public enum FieldsDevices: String, CaseIterable, Codable, Sendable {
            case addedDate
            case deviceClass
            case model
            case name
            case platform
            case status
            case udid
        }

        public func patch(_ body: AppStoreAPI.DeviceUpdateRequest) -> Request<AppStoreAPI.DeviceResponse> {
            Request(path: path, method: "PATCH", body: body, id: "devices-update_instance")
        }
    }
}