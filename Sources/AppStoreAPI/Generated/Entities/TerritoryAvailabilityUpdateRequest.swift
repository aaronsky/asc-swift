// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct TerritoryAvailabilityUpdateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Identifiable, Sendable {
        public var type: `Type`
        public var id: String
        public var attributes: Attributes?

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case territoryAvailabilities
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var isAvailable: Bool?
            public var releaseDate: String?
            public var isPreOrderEnabled: Bool?

            public init(isAvailable: Bool? = nil, releaseDate: String? = nil, isPreOrderEnabled: Bool? = nil) {
                self.isAvailable = isAvailable
                self.releaseDate = releaseDate
                self.isPreOrderEnabled = isPreOrderEnabled
            }

            private enum CodingKeys: String, CodingKey {
                case isAvailable = "available"
                case releaseDate
                case isPreOrderEnabled = "preOrderEnabled"
            }
        }

        public init(type: `Type` = .territoryAvailabilities, id: String, attributes: Attributes? = nil) {
            self.type = type
            self.id = id
            self.attributes = attributes
        }
    }

    public init(data: Data) {
        self.data = data
    }
}
