// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct User: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case users
    }

    public struct Attributes: Codable, Equatable, Sendable {
        public var username: String?
        public var firstName: String?
        public var lastName: String?
        public var roles: [UserRole]?

        public init(username: String? = nil, firstName: String? = nil, lastName: String? = nil, roles: [UserRole]? = nil) {
            self.username = username
            self.firstName = firstName
            self.lastName = lastName
            self.roles = roles
        }
    }

    public init(type: `Type` = .users, id: String, attributes: Attributes? = nil, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.links = links
    }
}
