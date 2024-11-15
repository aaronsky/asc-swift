// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct MarketplaceSearchDetailUpdateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Identifiable, Sendable {
        public var type: `Type`
        public var id: String
        public var attributes: Attributes?

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case marketplaceSearchDetails
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var catalogURL: URL?

            public init(catalogURL: URL? = nil) {
                self.catalogURL = catalogURL
            }

            private enum CodingKeys: String, CodingKey {
                case catalogURL = "catalogUrl"
            }
        }

        public init(type: `Type` = .marketplaceSearchDetails, id: String, attributes: Attributes? = nil) {
            self.type = type
            self.id = id
            self.attributes = attributes
        }
    }

    public init(data: Data) {
        self.data = data
    }
}
