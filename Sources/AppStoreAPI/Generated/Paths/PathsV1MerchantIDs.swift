// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1 {
    public var merchantIDs: MerchantIDs {
        MerchantIDs(path: path + "/merchantIds")
    }

    public struct MerchantIDs {
        /// Path: `/v1/merchantIds`
        public let path: String

        public func get(filterName: [String]? = nil, filterIdentifier: [String]? = nil, sort: [Sort]? = nil, fieldsMerchantIDs: [FieldsMerchantIDs]? = nil, fieldsCertificates: [FieldsCertificates]? = nil, limit: Int? = nil, include: [Include]? = nil, limitCertificates: Int? = nil) -> Request<AppStoreAPI.MerchantIDsResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(filterName, filterIdentifier, sort, fieldsMerchantIDs, fieldsCertificates, limit, include, limitCertificates), id: "merchantIds_getCollection")
        }

        private func makeGetQuery(_ filterName: [String]?, _ filterIdentifier: [String]?, _ sort: [Sort]?, _ fieldsMerchantIDs: [FieldsMerchantIDs]?, _ fieldsCertificates: [FieldsCertificates]?, _ limit: Int?, _ include: [Include]?, _ limitCertificates: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(filterName, forKey: "filter[name]")
            encoder.encode(filterIdentifier, forKey: "filter[identifier]")
            encoder.encode(sort, forKey: "sort")
            encoder.encode(fieldsMerchantIDs, forKey: "fields[merchantIds]")
            encoder.encode(fieldsCertificates, forKey: "fields[certificates]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(include, forKey: "include")
            encoder.encode(limitCertificates, forKey: "limit[certificates]")
            return encoder.items
        }

        public enum Sort: String, CaseIterable, Codable, Sendable {
            case name
            case minusName = "-name"
            case identifier
            case minusIdentifier = "-identifier"
        }

        public enum FieldsMerchantIDs: String, CaseIterable, Codable, Sendable {
            case name
            case identifier
            case certificates
        }

        public enum FieldsCertificates: String, CaseIterable, Codable, Sendable {
            case name
            case certificateType
            case displayName
            case serialNumber
            case platform
            case expirationDate
            case certificateContent
            case activated
            case passTypeID = "passTypeId"
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case certificates
        }

        public func post(_ body: AppStoreAPI.MerchantIDCreateRequest) -> Request<AppStoreAPI.MerchantIDResponse> {
            Request(path: path, method: "POST", body: body, id: "merchantIds_createInstance")
        }
    }
}
