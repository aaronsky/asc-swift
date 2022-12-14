// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct BetaTesterCreateRequest: Codable, Hashable {
    public var data: Data

    public struct Data: Codable, Hashable {
        public var type: `Type`
        public var attributes: Attributes
        public var relationships: Relationships?

        public enum `Type`: String, Codable, CaseIterable {
            case betaTesters
        }

        public struct Attributes: Codable, Hashable {
            public var firstName: String?
            public var lastName: String?
            public var email: String

            public init(firstName: String? = nil, lastName: String? = nil, email: String) {
                self.firstName = firstName
                self.lastName = lastName
                self.email = email
            }
        }

        public struct Relationships: Codable, Hashable {
            public var betaGroups: BetaGroups?
            public var builds: Builds?

            public struct BetaGroups: Codable, Hashable {
                public var data: [Datum]?

                public struct Datum: Codable, Hashable, Identifiable {
                    public var type: `Type`
                    public var id: String

                    public enum `Type`: String, Codable, CaseIterable {
                        case betaGroups
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

            public struct Builds: Codable, Hashable {
                public var data: [Datum]?

                public struct Datum: Codable, Hashable, Identifiable {
                    public var type: `Type`
                    public var id: String

                    public enum `Type`: String, Codable, CaseIterable {
                        case builds
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

            public init(betaGroups: BetaGroups? = nil, builds: Builds? = nil) {
                self.betaGroups = betaGroups
                self.builds = builds
            }
        }

        public init(type: `Type`, attributes: Attributes, relationships: Relationships? = nil) {
            self.type = type
            self.attributes = attributes
            self.relationships = relationships
        }
    }

    public init(data: Data) {
        self.data = data
    }
}
