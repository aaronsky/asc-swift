// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AlternativeDistributionKey: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case alternativeDistributionKeys
    }

    public struct Attributes: Codable, Equatable, Sendable {
        public var publicKey: String?

        public init(publicKey: String? = nil) {
            self.publicKey = publicKey
        }
    }

    public init(type: `Type` = .alternativeDistributionKeys, id: String, attributes: Attributes? = nil, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.links = links
    }
}
