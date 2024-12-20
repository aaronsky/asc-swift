// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct UserUpdateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Identifiable, Sendable {
        public var type: `Type`
        public var id: String
        public var attributes: Attributes?

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case users
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var roles: [UserRole]?

            public init(roles: [UserRole]? = nil) {
                self.roles = roles
            }
        }

        public init(type: `Type` = .users, id: String, attributes: Attributes? = nil) {
            self.type = type
            self.id = id
            self.attributes = attributes
        }
    }

    public init(data: Data) {
        self.data = data
    }
}
