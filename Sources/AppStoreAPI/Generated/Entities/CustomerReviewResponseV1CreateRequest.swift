// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct CustomerReviewResponseV1CreateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Sendable {
        public var type: `Type`
        public var attributes: Attributes
        public var relationships: Relationships

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case customerReviewResponses
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var responseBody: String

            public init(responseBody: String) {
                self.responseBody = responseBody
            }
        }

        public struct Relationships: Codable, Equatable, Sendable {
            public var review: Review

            public struct Review: Codable, Equatable, Sendable {
                public var data: Data

                public struct Data: Codable, Equatable, Identifiable, Sendable {
                    public var type: `Type`
                    public var id: String

                    public enum `Type`: String, CaseIterable, Codable, Sendable {
                        case customerReviews
                    }

                    public init(type: `Type` = .customerReviews, id: String) {
                        self.type = type
                        self.id = id
                    }
                }

                public init(data: Data) {
                    self.data = data
                }
            }

            public init(review: Review) {
                self.review = review
            }
        }

        public init(type: `Type` = .customerReviewResponses, attributes: Attributes, relationships: Relationships) {
            self.type = type
            self.attributes = attributes
            self.relationships = relationships
        }
    }

    public init(data: Data) {
        self.data = data
    }
}
