// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct CiWorkflow: Codable, Hashable, Identifiable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var relationships: Relationships?
    public var links: ResourceLinks

    public enum `Type`: String, Codable, CaseIterable {
        case ciWorkflows
    }

    public struct Attributes: Codable, Hashable {
        public var name: String?
        public var description: String?
        public var branchStartCondition: CiBranchStartCondition?
        public var tagStartCondition: CiTagStartCondition?
        public var pullRequestStartCondition: CiPullRequestStartCondition?
        public var scheduledStartCondition: CiScheduledStartCondition?
        public var actions: [CiAction]?
        public var isEnabled: Bool?
        public var isLockedForEditing: Bool?
        public var isClean: Bool?
        public var containerFilePath: String?
        public var lastModifiedDate: Date?

        public init(name: String? = nil, description: String? = nil, branchStartCondition: CiBranchStartCondition? = nil, tagStartCondition: CiTagStartCondition? = nil, pullRequestStartCondition: CiPullRequestStartCondition? = nil, scheduledStartCondition: CiScheduledStartCondition? = nil, actions: [CiAction]? = nil, isEnabled: Bool? = nil, isLockedForEditing: Bool? = nil, isClean: Bool? = nil, containerFilePath: String? = nil, lastModifiedDate: Date? = nil) {
            self.name = name
            self.description = description
            self.branchStartCondition = branchStartCondition
            self.tagStartCondition = tagStartCondition
            self.pullRequestStartCondition = pullRequestStartCondition
            self.scheduledStartCondition = scheduledStartCondition
            self.actions = actions
            self.isEnabled = isEnabled
            self.isLockedForEditing = isLockedForEditing
            self.isClean = isClean
            self.containerFilePath = containerFilePath
            self.lastModifiedDate = lastModifiedDate
        }

        private enum CodingKeys: String, CodingKey {
            case name
            case description
            case branchStartCondition
            case tagStartCondition
            case pullRequestStartCondition
            case scheduledStartCondition
            case actions
            case isEnabled
            case isLockedForEditing
            case isClean = "clean"
            case containerFilePath
            case lastModifiedDate
        }
    }

    public struct Relationships: Codable, Hashable {
        public var product: Product?
        public var repository: Repository?
        public var xcodeVersion: XcodeVersion?
        public var macOsVersion: MacOsVersion?

        public struct Product: Codable, Hashable {
            public var links: Links?
            public var data: Data?

            public struct Links: Codable, Hashable {
                public var this: URL?
                public var related: URL?

                public init(this: URL? = nil, related: URL? = nil) {
                    self.this = this
                    self.related = related
                }

                private enum CodingKeys: String, CodingKey {
                    case this = "self"
                    case related
                }
            }

            public struct Data: Codable, Hashable, Identifiable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, Codable, CaseIterable {
                    case ciProducts
                }

                public init(type: `Type`, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: Links? = nil, data: Data? = nil) {
                self.links = links
                self.data = data
            }
        }

        public struct Repository: Codable, Hashable {
            public var links: Links?
            public var data: Data?

            public struct Links: Codable, Hashable {
                public var this: URL?
                public var related: URL?

                public init(this: URL? = nil, related: URL? = nil) {
                    self.this = this
                    self.related = related
                }

                private enum CodingKeys: String, CodingKey {
                    case this = "self"
                    case related
                }
            }

            public struct Data: Codable, Hashable, Identifiable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, Codable, CaseIterable {
                    case scmRepositories
                }

                public init(type: `Type`, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: Links? = nil, data: Data? = nil) {
                self.links = links
                self.data = data
            }
        }

        public struct XcodeVersion: Codable, Hashable {
            public var links: Links?
            public var data: Data?

            public struct Links: Codable, Hashable {
                public var this: URL?
                public var related: URL?

                public init(this: URL? = nil, related: URL? = nil) {
                    self.this = this
                    self.related = related
                }

                private enum CodingKeys: String, CodingKey {
                    case this = "self"
                    case related
                }
            }

            public struct Data: Codable, Hashable, Identifiable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, Codable, CaseIterable {
                    case ciXcodeVersions
                }

                public init(type: `Type`, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: Links? = nil, data: Data? = nil) {
                self.links = links
                self.data = data
            }
        }

        public struct MacOsVersion: Codable, Hashable {
            public var links: Links?
            public var data: Data?

            public struct Links: Codable, Hashable {
                public var this: URL?
                public var related: URL?

                public init(this: URL? = nil, related: URL? = nil) {
                    self.this = this
                    self.related = related
                }

                private enum CodingKeys: String, CodingKey {
                    case this = "self"
                    case related
                }
            }

            public struct Data: Codable, Hashable, Identifiable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, Codable, CaseIterable {
                    case ciMacOsVersions
                }

                public init(type: `Type`, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: Links? = nil, data: Data? = nil) {
                self.links = links
                self.data = data
            }
        }

        public init(product: Product? = nil, repository: Repository? = nil, xcodeVersion: XcodeVersion? = nil, macOsVersion: MacOsVersion? = nil) {
            self.product = product
            self.repository = repository
            self.xcodeVersion = xcodeVersion
            self.macOsVersion = macOsVersion
        }
    }

    public init(type: `Type`, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil, links: ResourceLinks) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.relationships = relationships
        self.links = links
    }
}
