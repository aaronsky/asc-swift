// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AppClipDefaultExperienceUpdateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Identifiable, Sendable {
        public var type: `Type`
        public var id: String
        public var attributes: Attributes?
        public var relationships: Relationships?

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case appClipDefaultExperiences
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var action: AppClipAction?

            public init(action: AppClipAction? = nil) {
                self.action = action
            }
        }

        public struct Relationships: Codable, Equatable, Sendable {
            public var releaseWithAppStoreVersion: ReleaseWithAppStoreVersion?

            public struct ReleaseWithAppStoreVersion: Codable, Equatable, Sendable {
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

            public init(releaseWithAppStoreVersion: ReleaseWithAppStoreVersion? = nil) {
                self.releaseWithAppStoreVersion = releaseWithAppStoreVersion
            }
        }

        public init(type: `Type` = .appClipDefaultExperiences, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil) {
            self.type = type
            self.id = id
            self.attributes = attributes
            self.relationships = relationships
        }
    }

    public init(data: Data) {
        self.data = data
    }
}
