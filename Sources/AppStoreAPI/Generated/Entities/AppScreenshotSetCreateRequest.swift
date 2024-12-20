// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AppScreenshotSetCreateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Sendable {
        public var type: `Type`
        public var attributes: Attributes
        public var relationships: Relationships?

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case appScreenshotSets
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var screenshotDisplayType: ScreenshotDisplayType

            public init(screenshotDisplayType: ScreenshotDisplayType) {
                self.screenshotDisplayType = screenshotDisplayType
            }
        }

        public struct Relationships: Codable, Equatable, Sendable {
            public var appStoreVersionLocalization: AppStoreVersionLocalization?
            public var appCustomProductPageLocalization: AppCustomProductPageLocalization?
            public var appStoreVersionExperimentTreatmentLocalization: AppStoreVersionExperimentTreatmentLocalization?

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

            public init(appStoreVersionLocalization: AppStoreVersionLocalization? = nil, appCustomProductPageLocalization: AppCustomProductPageLocalization? = nil, appStoreVersionExperimentTreatmentLocalization: AppStoreVersionExperimentTreatmentLocalization? = nil) {
                self.appStoreVersionLocalization = appStoreVersionLocalization
                self.appCustomProductPageLocalization = appCustomProductPageLocalization
                self.appStoreVersionExperimentTreatmentLocalization = appStoreVersionExperimentTreatmentLocalization
            }
        }

        public init(type: `Type` = .appScreenshotSets, attributes: Attributes, relationships: Relationships? = nil) {
            self.type = type
            self.attributes = attributes
            self.relationships = relationships
        }
    }

    public init(data: Data) {
        self.data = data
    }
}
