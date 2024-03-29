// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct PagedDocumentLinks: Codable, Equatable, Sendable {
    public var this: URL
    public var first: URL?
    public var next: URL?

    public init(this: URL, first: URL? = nil, next: URL? = nil) {
        self.this = this
        self.first = first
        self.next = next
    }

    private enum CodingKeys: String, CodingKey {
        case this = "self"
        case first
        case next
    }
}
