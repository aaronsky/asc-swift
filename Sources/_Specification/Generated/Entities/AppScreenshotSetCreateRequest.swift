// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct AppScreenshotSetCreateRequest: Codable, Hashable {
    public var data: Data

    public struct Data: Codable, Hashable {
        public var type: `Type`
        public var attributes: Attributes
        public var relationships: Relationships?

        public enum `Type`: String, Codable, CaseIterable {
            case appScreenshotSets
        }

        public struct Attributes: Codable, Hashable {
            public var screenshotDisplayType: ScreenshotDisplayType

            public init(screenshotDisplayType: ScreenshotDisplayType) {
                self.screenshotDisplayType = screenshotDisplayType
            }
        }

        public struct Relationships: Codable, Hashable {
            public var appStoreVersionLocalization: AppStoreVersionLocalization?
            public var appCustomProductPageLocalization: AppCustomProductPageLocalization?
            public var appStoreVersionExperimentTreatmentLocalization: AppStoreVersionExperimentTreatmentLocalization?

            public struct AppStoreVersionLocalization: Codable, Hashable {
                public var data: Data?

                public struct Data: Codable, Hashable, Identifiable {
                    public var type: `Type`
                    public var id: String

                    public enum `Type`: String, Codable, CaseIterable {
                        case appStoreVersionLocalizations
                    }

                    public init(type: `Type`, id: String) {
                        self.type = type
                        self.id = id
                    }
                }

                public init(data: Data? = nil) {
                    self.data = data
                }
            }

            public struct AppCustomProductPageLocalization: Codable, Hashable {
                public var data: Data?

                public struct Data: Codable, Hashable, Identifiable {
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

                public init(data: Data? = nil) {
                    self.data = data
                }
            }

            public struct AppStoreVersionExperimentTreatmentLocalization: Codable, Hashable {
                public var data: Data?

                public struct Data: Codable, Hashable, Identifiable {
                    public var type: `Type`
                    public var id: String

                    public enum `Type`: String, Codable, CaseIterable {
                        case appStoreVersionExperimentTreatmentLocalizations
                    }

                    public init(type: `Type`, id: String) {
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
