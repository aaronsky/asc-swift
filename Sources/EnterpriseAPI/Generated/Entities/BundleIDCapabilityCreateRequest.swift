// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct BundleIDCapabilityCreateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Sendable {
        public var type: `Type`
        public var attributes: Attributes
        public var relationships: Relationships

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case bundleIDCapabilities = "bundleIdCapabilities"
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var capabilityType: CapabilityType
            public var settings: [CapabilitySetting]?

            public init(capabilityType: CapabilityType, settings: [CapabilitySetting]? = nil) {
                self.capabilityType = capabilityType
                self.settings = settings
            }
        }

        public struct Relationships: Codable, Equatable, Sendable {
            public var bundleID: BundleID

            public struct BundleID: Codable, Equatable, Sendable {
                public var data: Data

                public struct Data: Codable, Equatable, Identifiable, Sendable {
                    public var type: `Type`
                    public var id: String

                    public enum `Type`: String, CaseIterable, Codable, Sendable {
                        case bundleIDs = "bundleIds"
                    }

                    public init(type: `Type` = .bundleIDs, id: String) {
                        self.type = type
                        self.id = id
                    }
                }

                public init(data: Data) {
                    self.data = data
                }
            }

            public init(bundleID: BundleID) {
                self.bundleID = bundleID
            }

            private enum CodingKeys: String, CodingKey {
                case bundleID = "bundleId"
            }
        }

        public init(type: `Type` = .bundleIDCapabilities, attributes: Attributes, relationships: Relationships) {
            self.type = type
            self.attributes = attributes
            self.relationships = relationships
        }
    }

    public init(data: Data) {
        self.data = data
    }
}
