// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct AppCustomProductPageVersionCreateRequest: Codable, Hashable {
    public var data: Data

    public struct Data: Codable, Hashable {
        public var type: `Type`
        public var relationships: Relationships

        public enum `Type`: String, Codable, CaseIterable {
            case appCustomProductPageVersions
        }

        public struct Relationships: Codable, Hashable {
            public var appCustomProductPage: AppCustomProductPage
            public var appCustomProductPageLocalizations: AppCustomProductPageLocalizations?

            public struct AppCustomProductPage: Codable, Hashable {
                public var data: Data

                public struct Data: Codable, Hashable, Identifiable {
                    public var type: `Type`
                    public var id: String

                    public enum `Type`: String, Codable, CaseIterable {
                        case appCustomProductPages
                    }

                    public init(type: `Type`, id: String) {
                        self.type = type
                        self.id = id
                    }
                }

                public init(data: Data) {
                    self.data = data
                }
            }

            public struct AppCustomProductPageLocalizations: Codable, Hashable {
                public var data: [Datum]?

                public struct Datum: Codable, Hashable, Identifiable {
                    public var type: `Type`
                    public var id: String

                    public enum `Type`: String, Codable, CaseIterable {
                        case appCustomProductPageLocalizations
                    }

                    public init(type: `Type`, id: String) {
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

        public init(type: `Type`, relationships: Relationships) {
            self.type = type
            self.relationships = relationships
        }
    }

    public init(data: Data) {
        self.data = data
    }
}
