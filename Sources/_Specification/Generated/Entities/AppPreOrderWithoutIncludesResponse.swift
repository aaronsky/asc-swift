// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct AppPreOrderWithoutIncludesResponse: Codable, Hashable {
    /// App
    public var data: App
    public var links: DocumentLinks

    public init(data: App, links: DocumentLinks) {
        self.data = data
        self.links = links
    }
}