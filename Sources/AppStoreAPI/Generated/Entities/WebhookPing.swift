// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct WebhookPing: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case webhookPings
    }

    public init(type: `Type` = .webhookPings, id: String, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.links = links
    }
}
