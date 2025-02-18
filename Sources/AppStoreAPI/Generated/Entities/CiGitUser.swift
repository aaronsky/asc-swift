// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct CiGitUser: Codable, Equatable, Sendable {
    public var displayName: String?
    public var avatarURL: URL?

    public init(displayName: String? = nil, avatarURL: URL? = nil) {
        self.displayName = displayName
        self.avatarURL = avatarURL
    }

    private enum CodingKeys: String, CodingKey {
        case displayName
        case avatarURL = "avatarUrl"
    }
}
