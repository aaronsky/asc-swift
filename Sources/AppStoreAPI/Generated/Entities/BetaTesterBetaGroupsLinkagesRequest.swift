// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct BetaTesterBetaGroupsLinkagesRequest: Codable, Equatable, Sendable {
    public var data: [Datum]

    public struct Datum: Codable, Equatable, Identifiable, Sendable {
        public var type: `Type`
        public var id: String

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case betaGroups
        }

        public init(type: `Type` = .betaGroups, id: String) {
            self.type = type
            self.id = id
        }
    }

    public init(data: [Datum]) {
        self.data = data
    }
}