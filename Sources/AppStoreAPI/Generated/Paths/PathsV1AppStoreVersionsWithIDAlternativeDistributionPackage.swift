// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.AppStoreVersions.WithID {
    public var alternativeDistributionPackage: AlternativeDistributionPackage {
        AlternativeDistributionPackage(path: path + "/alternativeDistributionPackage")
    }

    public struct AlternativeDistributionPackage {
        /// Path: `/v1/appStoreVersions/{id}/alternativeDistributionPackage`
        public let path: String

        public func get(fieldsAlternativeDistributionPackages: [FieldsAlternativeDistributionPackages]? = nil, fieldsAlternativeDistributionPackageVersions: [FieldsAlternativeDistributionPackageVersions]? = nil, limitVersions: Int? = nil, include: [Include]? = nil) -> Request<AppStoreAPI.AlternativeDistributionPackageResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsAlternativeDistributionPackages, fieldsAlternativeDistributionPackageVersions, limitVersions, include), id: "appStoreVersions-alternativeDistributionPackage-get_to_one_related")
        }

        private func makeGetQuery(_ fieldsAlternativeDistributionPackages: [FieldsAlternativeDistributionPackages]?, _ fieldsAlternativeDistributionPackageVersions: [FieldsAlternativeDistributionPackageVersions]?, _ limitVersions: Int?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsAlternativeDistributionPackages, forKey: "fields[alternativeDistributionPackages]")
            encoder.encode(fieldsAlternativeDistributionPackageVersions, forKey: "fields[alternativeDistributionPackageVersions]")
            encoder.encode(limitVersions, forKey: "limit[versions]")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsAlternativeDistributionPackages: String, CaseIterable, Codable, Sendable {
            case appStoreVersion
            case versions
        }

        public enum FieldsAlternativeDistributionPackageVersions: String, CaseIterable, Codable, Sendable {
            case alternativeDistributionPackage
            case deltas
            case fileChecksum
            case state
            case url
            case urlExpirationDate
            case variants
            case version
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case versions
        }
    }
}