// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AppClipHeaderImageResponse: Codable, Equatable, Sendable {
    /// AppClipHeaderImage
    public var data: AppClipHeaderImage
    public var included: [AppClipDefaultExperienceLocalization]?
    public var links: DocumentLinks

    public init(data: AppClipHeaderImage, included: [AppClipDefaultExperienceLocalization]? = nil, links: DocumentLinks) {
        self.data = data
        self.included = included
        self.links = links
    }
}
