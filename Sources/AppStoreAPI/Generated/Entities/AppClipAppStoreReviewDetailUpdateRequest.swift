// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AppClipAppStoreReviewDetailUpdateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Identifiable, Sendable {
        public var type: `Type`
        public var id: String
        public var attributes: Attributes?

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case appClipAppStoreReviewDetails
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var invocationURLs: [URL]?

            public init(invocationURLs: [URL]? = nil) {
                self.invocationURLs = invocationURLs
            }

            private enum CodingKeys: String, CodingKey {
                case invocationURLs = "invocationUrls"
            }
        }

        public init(type: `Type` = .appClipAppStoreReviewDetails, id: String, attributes: Attributes? = nil) {
            self.type = type
            self.id = id
            self.attributes = attributes
        }
    }

    public init(data: Data) {
        self.data = data
    }
}