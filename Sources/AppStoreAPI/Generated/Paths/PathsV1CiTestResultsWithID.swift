// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.CiTestResults {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/ciTestResults/{id}`
        public let path: String

        public func get(fieldsCiTestResults: [FieldsCiTestResults]? = nil) -> Request<AppStoreAPI.CiTestResultResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsCiTestResults), id: "ciTestResults-get_instance")
        }

        private func makeGetQuery(_ fieldsCiTestResults: [FieldsCiTestResults]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(fieldsCiTestResults, forKey: "fields[ciTestResults]", explode: false)
            return encoder.items
        }

        public enum FieldsCiTestResults: String, CaseIterable, Codable, Sendable {
            case className
            case destinationTestResults
            case fileSource
            case message
            case name
            case status
        }
    }
}