// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.CiArtifacts {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/ciArtifacts/{id}`
        public let path: String

        public func get(fieldsCiArtifacts: [FieldsCiArtifacts]? = nil) -> Request<AppStoreAPI.CiArtifactResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsCiArtifacts), id: "ciArtifacts-get_instance")
        }

        private func makeGetQuery(_ fieldsCiArtifacts: [FieldsCiArtifacts]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(fieldsCiArtifacts, forKey: "fields[ciArtifacts]", explode: false)
            return encoder.items
        }

        public enum FieldsCiArtifacts: String, CaseIterable, Codable, Sendable {
            case downloadURL = "downloadUrl"
            case fileName
            case fileSize
            case fileType
        }
    }
}