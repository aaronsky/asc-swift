// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources {
    public static var profiles: Profiles {
        Profiles(path: "/v1/profiles")
    }

    public struct Profiles {
        /// Path: `/v1/profiles`
        public let path: String

        /// List and Download Profiles
        public func get(filterName: [String]? = nil, filterProfileState: [FilterProfileState]? = nil, filterProfileType: [FilterProfileType]? = nil, filterID: [String]? = nil, sort: [Sort]? = nil, fieldsProfiles: [FieldsProfiles]? = nil, limit: Int? = nil, include: [Include]? = nil, fieldsCertificates: [FieldsCertificates]? = nil, fieldsDevices: [FieldsDevices]? = nil, fieldsBundleIDs: [FieldsBundleIDs]? = nil, limitCertificates: Int? = nil, limitDevices: Int? = nil) -> Request<EnterpriseAPI.ProfilesResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(filterName, filterProfileState, filterProfileType, filterID, sort, fieldsProfiles, limit, include, fieldsCertificates, fieldsDevices, fieldsBundleIDs, limitCertificates, limitDevices), id: "profiles-get_collection")
        }

        private func makeGetQuery(_ filterName: [String]?, _ filterProfileState: [FilterProfileState]?, _ filterProfileType: [FilterProfileType]?, _ filterID: [String]?, _ sort: [Sort]?, _ fieldsProfiles: [FieldsProfiles]?, _ limit: Int?, _ include: [Include]?, _ fieldsCertificates: [FieldsCertificates]?, _ fieldsDevices: [FieldsDevices]?, _ fieldsBundleIDs: [FieldsBundleIDs]?, _ limitCertificates: Int?, _ limitDevices: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(filterName, forKey: "filter[name]")
            encoder.encode(filterProfileState, forKey: "filter[profileState]")
            encoder.encode(filterProfileType, forKey: "filter[profileType]")
            encoder.encode(filterID, forKey: "filter[id]")
            encoder.encode(sort, forKey: "sort")
            encoder.encode(fieldsProfiles, forKey: "fields[profiles]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(include, forKey: "include")
            encoder.encode(fieldsCertificates, forKey: "fields[certificates]")
            encoder.encode(fieldsDevices, forKey: "fields[devices]")
            encoder.encode(fieldsBundleIDs, forKey: "fields[bundleIds]")
            encoder.encode(limitCertificates, forKey: "limit[certificates]")
            encoder.encode(limitDevices, forKey: "limit[devices]")
            return encoder.items
        }

        public enum FilterProfileState: String, CaseIterable, Codable, Sendable {
            case active = "ACTIVE"
            case invalid = "INVALID"
        }

        public enum FilterProfileType: String, CaseIterable, Codable, Sendable {
            case iOSAppDevelopment = "IOS_APP_DEVELOPMENT"
            case iOSAppStore = "IOS_APP_STORE"
            case iOSAppAdhoc = "IOS_APP_ADHOC"
            case iOSAppInhouse = "IOS_APP_INHOUSE"
            case macAppDevelopment = "MAC_APP_DEVELOPMENT"
            case macAppStore = "MAC_APP_STORE"
            case macAppDirect = "MAC_APP_DIRECT"
            case tvOSAppDevelopment = "TVOS_APP_DEVELOPMENT"
            case tvOSAppStore = "TVOS_APP_STORE"
            case tvOSAppAdhoc = "TVOS_APP_ADHOC"
            case tvOSAppInhouse = "TVOS_APP_INHOUSE"
            case macCatalystAppDevelopment = "MAC_CATALYST_APP_DEVELOPMENT"
            case macCatalystAppStore = "MAC_CATALYST_APP_STORE"
            case macCatalystAppDirect = "MAC_CATALYST_APP_DIRECT"
        }

        public enum Sort: String, CaseIterable, Codable, Sendable {
            case id
            case minusID = "-id"
            case name
            case minusName = "-name"
            case profileState
            case minusProfileState = "-profileState"
            case profileType
            case minusProfileType = "-profileType"
        }

        public enum FieldsProfiles: String, CaseIterable, Codable, Sendable {
            case bundleID = "bundleId"
            case certificates
            case createdDate
            case devices
            case expirationDate
            case name
            case platform
            case profileContent
            case profileState
            case profileType
            case uuid
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case bundleID = "bundleId"
            case certificates
            case devices
        }

        public enum FieldsCertificates: String, CaseIterable, Codable, Sendable {
            case certificateContent
            case certificateType
            case csrContent
            case displayName
            case expirationDate
            case name
            case passTypeID = "passTypeId"
            case platform
            case serialNumber
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

        public enum FieldsBundleIDs: String, CaseIterable, Codable, Sendable {
            case bundleIDCapabilities = "bundleIdCapabilities"
            case identifier
            case name
            case platform
            case profiles
            case seedID = "seedId"
        }

        /// Create a Profile
        public func post(_ body: EnterpriseAPI.ProfileCreateRequest) -> Request<EnterpriseAPI.ProfileResponse> {
            Request(path: path, method: "POST", body: body, id: "profiles-create_instance")
        }
    }
}
