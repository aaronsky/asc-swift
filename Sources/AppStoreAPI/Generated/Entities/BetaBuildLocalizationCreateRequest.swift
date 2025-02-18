// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct BetaBuildLocalizationCreateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Sendable {
        public var type: `Type`
        public var attributes: Attributes
        public var relationships: Relationships

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case betaBuildLocalizations
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var whatsNew: String?
            public var locale: String

            public init(whatsNew: String? = nil, locale: String) {
                self.whatsNew = whatsNew
                self.locale = locale
            }
        }

        public struct Relationships: Codable, Equatable, Sendable {
            public var build: Build

            public struct Build: Codable, Equatable, Sendable {
                public var data: Data

                public struct Data: Codable, Equatable, Identifiable, Sendable {
                    public var type: `Type`
                    public var id: String

                    public enum `Type`: String, CaseIterable, Codable, Sendable {
                        case builds
                    }

                    public init(type: `Type` = .builds, id: String) {
                        self.type = type
                        self.id = id
                    }
                }

                public init(data: Data) {
                    self.data = data
                }
            }

            public init(build: Build) {
                self.build = build
            }
        }

        public init(type: `Type` = .betaBuildLocalizations, attributes: Attributes, relationships: Relationships) {
            self.type = type
            self.attributes = attributes
            self.relationships = relationships
        }
    }

    public init(data: Data) {
        self.data = data
    }
}
