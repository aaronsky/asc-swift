// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct PromotedPurchaseUpdateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Identifiable, Sendable {
        public var type: `Type`
        public var id: String
        public var attributes: Attributes?

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case promotedPurchases
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var isVisibleForAllUsers: Bool?
            public var isEnabled: Bool?

            public init(isVisibleForAllUsers: Bool? = nil, isEnabled: Bool? = nil) {
                self.isVisibleForAllUsers = isVisibleForAllUsers
                self.isEnabled = isEnabled
            }

            private enum CodingKeys: String, CodingKey {
                case isVisibleForAllUsers = "visibleForAllUsers"
                case isEnabled = "enabled"
            }
        }

        public init(type: `Type` = .promotedPurchases, id: String, attributes: Attributes? = nil) {
            self.type = type
            self.id = id
            self.attributes = attributes
        }
    }

    public init(data: Data) {
        self.data = data
    }
}