// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct ActorResponse: Codable, Hashable {
    /// Actor
    public var data: Actor
    public var links: DocumentLinks

    public init(data: Actor, links: DocumentLinks) {
        self.data = data
        self.links = links
    }
}