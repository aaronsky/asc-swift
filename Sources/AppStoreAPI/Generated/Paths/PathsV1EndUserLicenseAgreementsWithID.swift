// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.EndUserLicenseAgreements {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/endUserLicenseAgreements/{id}`
        public let path: String

        public func get(fieldsEndUserLicenseAgreements: [FieldsEndUserLicenseAgreements]? = nil, include: [Include]? = nil, fieldsTerritories: [FieldsTerritories]? = nil, limitTerritories: Int? = nil) -> Request<AppStoreAPI.EndUserLicenseAgreementResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsEndUserLicenseAgreements, include, fieldsTerritories, limitTerritories), id: "endUserLicenseAgreements-get_instance")
        }

        private func makeGetQuery(_ fieldsEndUserLicenseAgreements: [FieldsEndUserLicenseAgreements]?, _ include: [Include]?, _ fieldsTerritories: [FieldsTerritories]?, _ limitTerritories: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsEndUserLicenseAgreements, forKey: "fields[endUserLicenseAgreements]")
            encoder.encode(include, forKey: "include")
            encoder.encode(fieldsTerritories, forKey: "fields[territories]")
            encoder.encode(limitTerritories, forKey: "limit[territories]")
            return encoder.items
        }

        public enum FieldsEndUserLicenseAgreements: String, CaseIterable, Codable, Sendable {
            case agreementText
            case app
            case territories
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case app
            case territories
        }

        public enum FieldsTerritories: String, CaseIterable, Codable, Sendable {
            case currency
        }

        public func patch(_ body: AppStoreAPI.EndUserLicenseAgreementUpdateRequest) -> Request<AppStoreAPI.EndUserLicenseAgreementResponse> {
            Request(path: path, method: "PATCH", body: body, id: "endUserLicenseAgreements-update_instance")
        }

        public var delete: Request<Void> {
            Request(path: path, method: "DELETE", id: "endUserLicenseAgreements-delete_instance")
        }
    }
}