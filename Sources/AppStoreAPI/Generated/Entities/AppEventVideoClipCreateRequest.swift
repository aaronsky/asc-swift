// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AppEventVideoClipCreateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Sendable {
        public var type: `Type`
        public var attributes: Attributes
        public var relationships: Relationships

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case appEventVideoClips
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var fileSize: Int
            public var fileName: String
            public var previewFrameTimeCode: String?
            public var appEventAssetType: AppEventAssetType

            public init(fileSize: Int, fileName: String, previewFrameTimeCode: String? = nil, appEventAssetType: AppEventAssetType) {
                self.fileSize = fileSize
                self.fileName = fileName
                self.previewFrameTimeCode = previewFrameTimeCode
                self.appEventAssetType = appEventAssetType
            }
        }

        public struct Relationships: Codable, Equatable, Sendable {
            public var appEventLocalization: AppEventLocalization

            public struct AppEventLocalization: Codable, Equatable, Sendable {
                public var data: Data

                public struct Data: Codable, Equatable, Identifiable, Sendable {
                    public var type: `Type`
                    public var id: String

                    public enum `Type`: String, CaseIterable, Codable, Sendable {
                        case appEventLocalizations
                    }

                    public init(type: `Type` = .appEventLocalizations, id: String) {
                        self.type = type
                        self.id = id
                    }
                }

                public init(data: Data) {
                    self.data = data
                }
            }

            public init(appEventLocalization: AppEventLocalization) {
                self.appEventLocalization = appEventLocalization
            }
        }

        public init(type: `Type` = .appEventVideoClips, attributes: Attributes, relationships: Relationships) {
            self.type = type
            self.attributes = attributes
            self.relationships = relationships
        }
    }

    public init(data: Data) {
        self.data = data
    }
}
