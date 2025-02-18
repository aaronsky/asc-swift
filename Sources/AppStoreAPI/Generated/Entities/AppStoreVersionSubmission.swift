// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AppStoreVersionSubmission: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var relationships: Relationships?
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case appStoreVersionSubmissions
    }

    public struct Relationships: Codable, Equatable, Sendable {
        public var appStoreVersion: AppStoreVersion?

        public struct AppStoreVersion: Codable, Equatable, Sendable {
            public var data: Data?

            public struct Data: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case appStoreVersions
                }

                public init(type: `Type` = .appStoreVersions, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(data: Data? = nil) {
                self.data = data
            }
        }

        public init(appStoreVersion: AppStoreVersion? = nil) {
            self.appStoreVersion = appStoreVersion
        }
    }

    public init(type: `Type` = .appStoreVersionSubmissions, id: String, relationships: Relationships? = nil, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.relationships = relationships
        self.links = links
    }
}
