// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AppCustomProductPageLocalizationCreateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Sendable {
        public var type: `Type`
        public var attributes: Attributes
        public var relationships: Relationships

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case appCustomProductPageLocalizations
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var locale: String
            public var promotionalText: String?

            public init(locale: String, promotionalText: String? = nil) {
                self.locale = locale
                self.promotionalText = promotionalText
            }
        }

        public struct Relationships: Codable, Equatable, Sendable {
            public var appCustomProductPageVersion: AppCustomProductPageVersion

            public struct AppCustomProductPageVersion: Codable, Equatable, Sendable {
                public var data: Data

                public struct Data: Codable, Equatable, Identifiable, Sendable {
                    public var type: `Type`
                    public var id: String

                    public enum `Type`: String, CaseIterable, Codable, Sendable {
                        case appCustomProductPageVersions
                    }

                    public init(type: `Type` = .appCustomProductPageVersions, id: String) {
                        self.type = type
                        self.id = id
                    }
                }

                public init(data: Data) {
                    self.data = data
                }
            }

            public init(appCustomProductPageVersion: AppCustomProductPageVersion) {
                self.appCustomProductPageVersion = appCustomProductPageVersion
            }
        }

        public init(type: `Type` = .appCustomProductPageLocalizations, attributes: Attributes, relationships: Relationships) {
            self.type = type
            self.attributes = attributes
            self.relationships = relationships
        }
    }

    public init(data: Data) {
        self.data = data
    }
}
