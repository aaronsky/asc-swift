// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.AlternativeDistributionPackages.WithID {
    public var versions: Versions {
        Versions(path: path + "/versions")
    }

    public struct Versions {
        /// Path: `/v1/alternativeDistributionPackages/{id}/versions`
        public let path: String

        public func get(filterState: [FilterState]? = nil, fieldsAlternativeDistributionPackageVariants: [FieldsAlternativeDistributionPackageVariants]? = nil, fieldsAlternativeDistributionPackages: [FieldsAlternativeDistributionPackages]? = nil, fieldsAlternativeDistributionPackageVersions: [FieldsAlternativeDistributionPackageVersions]? = nil, fieldsAlternativeDistributionPackageDeltas: [FieldsAlternativeDistributionPackageDeltas]? = nil, limit: Int? = nil, limitVariants: Int? = nil, limitDeltas: Int? = nil, include: [Include]? = nil) -> Request<_Specification.AlternativeDistributionPackageVersionsResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(filterState, fieldsAlternativeDistributionPackageVariants, fieldsAlternativeDistributionPackages, fieldsAlternativeDistributionPackageVersions, fieldsAlternativeDistributionPackageDeltas, limit, limitVariants, limitDeltas, include), id: "alternativeDistributionPackages-versions-get_to_many_related")
        }

        private func makeGetQuery(_ filterState: [FilterState]?, _ fieldsAlternativeDistributionPackageVariants: [FieldsAlternativeDistributionPackageVariants]?, _ fieldsAlternativeDistributionPackages: [FieldsAlternativeDistributionPackages]?, _ fieldsAlternativeDistributionPackageVersions: [FieldsAlternativeDistributionPackageVersions]?, _ fieldsAlternativeDistributionPackageDeltas: [FieldsAlternativeDistributionPackageDeltas]?, _ limit: Int?, _ limitVariants: Int?, _ limitDeltas: Int?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(filterState, forKey: "filter[state]")
            encoder.encode(fieldsAlternativeDistributionPackageVariants, forKey: "fields[alternativeDistributionPackageVariants]")
            encoder.encode(fieldsAlternativeDistributionPackages, forKey: "fields[alternativeDistributionPackages]")
            encoder.encode(fieldsAlternativeDistributionPackageVersions, forKey: "fields[alternativeDistributionPackageVersions]")
            encoder.encode(fieldsAlternativeDistributionPackageDeltas, forKey: "fields[alternativeDistributionPackageDeltas]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(limitVariants, forKey: "limit[variants]")
            encoder.encode(limitDeltas, forKey: "limit[deltas]")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FilterState: String, CaseIterable, Codable, Sendable {
            case completed = "COMPLETED"
            case replaced = "REPLACED"
        }

        public enum FieldsAlternativeDistributionPackageVariants: String, CaseIterable, Codable, Sendable {
            case alternativeDistributionKeyBlob
            case fileChecksum
            case url
            case urlExpirationDate
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

        public enum FieldsAlternativeDistributionPackageDeltas: String, CaseIterable, Codable, Sendable {
            case alternativeDistributionKeyBlob
            case fileChecksum
            case url
            case urlExpirationDate
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case alternativeDistributionPackage
            case deltas
            case variants
        }
    }
}
