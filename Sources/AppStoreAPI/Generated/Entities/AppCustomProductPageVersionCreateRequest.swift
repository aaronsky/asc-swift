// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AppCustomProductPageVersionCreateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Sendable {
        public var type: `Type`
        public var attributes: Attributes?
        public var relationships: Relationships

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case appCustomProductPageVersions
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var deepLink: URL?

            public init(deepLink: URL? = nil) {
                self.deepLink = deepLink
            }
        }

        public struct Relationships: Codable, Equatable, Sendable {
            public var appCustomProductPage: AppCustomProductPage
            public var appCustomProductPageLocalizations: AppCustomProductPageLocalizations?

            public struct AppCustomProductPage: Codable, Equatable, Sendable {
                public var data: Data

                public struct Data: Codable, Equatable, Identifiable, Sendable {
                    public var type: `Type`
                    public var id: String

                    public enum `Type`: String, CaseIterable, Codable, Sendable {
                        case appCustomProductPages
                    }

                    public init(type: `Type` = .appCustomProductPages, id: String) {
                        self.type = type
                        self.id = id
                    }
                }

                public init(data: Data) {
                    self.data = data
                }
            }

            public struct AppCustomProductPageLocalizations: Codable, Equatable, Sendable {
                public var data: [Datum]?

                public struct Datum: Codable, Equatable, Identifiable, Sendable {
                    public var type: `Type`
                    public var id: String

                    public enum `Type`: String, CaseIterable, Codable, Sendable {
                        case appCustomProductPageLocalizations
                    }

                    public init(type: `Type` = .appCustomProductPageLocalizations, id: String) {
                        self.type = type
                        self.id = id
                    }
                }

                public init(data: [Datum]? = nil) {
                    self.data = data
                }
            }

            public init(appCustomProductPage: AppCustomProductPage, appCustomProductPageLocalizations: AppCustomProductPageLocalizations? = nil) {
                self.appCustomProductPage = appCustomProductPage
                self.appCustomProductPageLocalizations = appCustomProductPageLocalizations
            }
        }

        public init(type: `Type` = .appCustomProductPageVersions, attributes: Attributes? = nil, relationships: Relationships) {
            self.type = type
            self.attributes = attributes
            self.relationships = relationships
        }
    }

    public init(data: Data) {
        self.data = data
    }
}