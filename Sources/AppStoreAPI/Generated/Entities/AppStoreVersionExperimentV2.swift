// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AppStoreVersionExperimentV2: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var relationships: Relationships?
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case appStoreVersionExperiments
    }

    public struct Attributes: Codable, Equatable, Sendable {
        public var name: String?
        public var platform: Platform?
        public var trafficProportion: Int?
        public var state: State?
        public var isReviewRequired: Bool?
        public var startDate: Date?
        public var endDate: Date?

        public enum State: String, CaseIterable, Codable, Sendable {
            case prepareForSubmission = "PREPARE_FOR_SUBMISSION"
            case readyForReview = "READY_FOR_REVIEW"
            case waitingForReview = "WAITING_FOR_REVIEW"
            case inReview = "IN_REVIEW"
            case accepted = "ACCEPTED"
            case approved = "APPROVED"
            case rejected = "REJECTED"
            case completed = "COMPLETED"
            case stopped = "STOPPED"
        }

        public init(name: String? = nil, platform: Platform? = nil, trafficProportion: Int? = nil, state: State? = nil, isReviewRequired: Bool? = nil, startDate: Date? = nil, endDate: Date? = nil) {
            self.name = name
            self.platform = platform
            self.trafficProportion = trafficProportion
            self.state = state
            self.isReviewRequired = isReviewRequired
            self.startDate = startDate
            self.endDate = endDate
        }

        private enum CodingKeys: String, CodingKey {
            case name
            case platform
            case trafficProportion
            case state
            case isReviewRequired = "reviewRequired"
            case startDate
            case endDate
        }
    }

    public struct Relationships: Codable, Equatable, Sendable {
        public var app: App?
        public var latestControlVersion: LatestControlVersion?
        public var controlVersions: ControlVersions?
        public var appStoreVersionExperimentTreatments: AppStoreVersionExperimentTreatments?

        public struct App: Codable, Equatable, Sendable {
            public var links: Links?
            public var data: Data?

            public struct Links: Codable, Equatable, Sendable {
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

            public struct Data: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case apps
                }

                public init(type: `Type` = .apps, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: Links? = nil, data: Data? = nil) {
                self.links = links
                self.data = data
            }
        }

        public struct LatestControlVersion: Codable, Equatable, Sendable {
            public var links: Links?
            public var data: Data?

            public struct Links: Codable, Equatable, Sendable {
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

            public init(links: Links? = nil, data: Data? = nil) {
                self.links = links
                self.data = data
            }
        }

        public struct ControlVersions: Codable, Equatable, Sendable {
            public var links: Links?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Links: Codable, Equatable, Sendable {
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

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
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

            public init(links: Links? = nil, meta: PagingInformation? = nil, data: [Datum]? = nil) {
                self.links = links
                self.meta = meta
                self.data = data
            }
        }

        public struct AppStoreVersionExperimentTreatments: Codable, Equatable, Sendable {
            public var links: Links?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Links: Codable, Equatable, Sendable {
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

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case appStoreVersionExperimentTreatments
                }

                public init(type: `Type` = .appStoreVersionExperimentTreatments, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: Links? = nil, meta: PagingInformation? = nil, data: [Datum]? = nil) {
                self.links = links
                self.meta = meta
                self.data = data
            }
        }

        public init(app: App? = nil, latestControlVersion: LatestControlVersion? = nil, controlVersions: ControlVersions? = nil, appStoreVersionExperimentTreatments: AppStoreVersionExperimentTreatments? = nil) {
            self.app = app
            self.latestControlVersion = latestControlVersion
            self.controlVersions = controlVersions
            self.appStoreVersionExperimentTreatments = appStoreVersionExperimentTreatments
        }
    }

    public init(type: `Type` = .appStoreVersionExperiments, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.relationships = relationships
        self.links = links
    }
}