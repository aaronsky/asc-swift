// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AppScreenshotCreateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Sendable {
        public var type: `Type`
        public var attributes: Attributes
        public var relationships: Relationships

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case appScreenshots
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var fileSize: Int
            public var fileName: String

            public init(fileSize: Int, fileName: String) {
                self.fileSize = fileSize
                self.fileName = fileName
            }
        }

        public struct Relationships: Codable, Equatable, Sendable {
            public var appScreenshotSet: AppScreenshotSet

            public struct AppScreenshotSet: Codable, Equatable, Sendable {
                public var data: Data

                public struct Data: Codable, Equatable, Identifiable, Sendable {
                    public var type: `Type`
                    public var id: String

                    public enum `Type`: String, CaseIterable, Codable, Sendable {
                        case appScreenshotSets
                    }

                    public init(type: `Type` = .appScreenshotSets, id: String) {
                        self.type = type
                        self.id = id
                    }
                }

                public init(data: Data) {
                    self.data = data
                }
            }

            public init(appScreenshotSet: AppScreenshotSet) {
                self.appScreenshotSet = appScreenshotSet
            }
        }

        public init(type: `Type` = .appScreenshots, attributes: Attributes, relationships: Relationships) {
            self.type = type
            self.attributes = attributes
            self.relationships = relationships
        }
    }

    public init(data: Data) {
        self.data = data
    }
}
