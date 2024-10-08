// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AppScreenshotSet: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var relationships: Relationships?
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case appScreenshotSets
    }

    public struct Attributes: Codable, Equatable, Sendable {
        public var screenshotDisplayType: ScreenshotDisplayType?

        public init(screenshotDisplayType: ScreenshotDisplayType? = nil) {
            self.screenshotDisplayType = screenshotDisplayType
        }
    }

    public struct Relationships: Codable, Equatable, Sendable {
        public var appStoreVersionLocalization: AppStoreVersionLocalization?
        public var appCustomProductPageLocalization: AppCustomProductPageLocalization?
        public var appStoreVersionExperimentTreatmentLocalization: AppStoreVersionExperimentTreatmentLocalization?
        public var appScreenshots: AppScreenshots?

        public struct AppStoreVersionLocalization: Codable, Equatable, Sendable {
            public var data: Data?

            public struct Data: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case appStoreVersionLocalizations
                }

                public init(type: `Type` = .appStoreVersionLocalizations, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(data: Data? = nil) {
                self.data = data
            }
        }

        public struct AppCustomProductPageLocalization: Codable, Equatable, Sendable {
            public var data: Data?

            public struct Data: Codable, Equatable, Identifiable, Sendable {
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

            public init(data: Data? = nil) {
                self.data = data
            }
        }

        public struct AppStoreVersionExperimentTreatmentLocalization: Codable, Equatable, Sendable {
            public var data: Data?

            public struct Data: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case appStoreVersionExperimentTreatmentLocalizations
                }

                public init(type: `Type` = .appStoreVersionExperimentTreatmentLocalizations, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(data: Data? = nil) {
                self.data = data
            }
        }

        public struct AppScreenshots: Codable, Equatable, Sendable {
            public var links: RelationshipLinks?
            public var meta: PagingInformation?
            public var data: [Datum]?

            public struct Datum: Codable, Equatable, Identifiable, Sendable {
                public var type: `Type`
                public var id: String

                public enum `Type`: String, CaseIterable, Codable, Sendable {
                    case appScreenshots
                }

                public init(type: `Type` = .appScreenshots, id: String) {
                    self.type = type
                    self.id = id
                }
            }

            public init(links: RelationshipLinks? = nil, meta: PagingInformation? = nil, data: [Datum]? = nil) {
                self.links = links
                self.meta = meta
                self.data = data
            }
        }

        public init(appStoreVersionLocalization: AppStoreVersionLocalization? = nil, appCustomProductPageLocalization: AppCustomProductPageLocalization? = nil, appStoreVersionExperimentTreatmentLocalization: AppStoreVersionExperimentTreatmentLocalization? = nil, appScreenshots: AppScreenshots? = nil) {
            self.appStoreVersionLocalization = appStoreVersionLocalization
            self.appCustomProductPageLocalization = appCustomProductPageLocalization
            self.appStoreVersionExperimentTreatmentLocalization = appStoreVersionExperimentTreatmentLocalization
            self.appScreenshots = appScreenshots
        }
    }

    public init(type: `Type` = .appScreenshotSets, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.relationships = relationships
        self.links = links
    }
}
