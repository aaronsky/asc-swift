// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct BetaAppClipInvocationLocalizationResponse: Codable, Equatable, Sendable {
    /// BetaAppClipInvocationLocalization
    public var data: BetaAppClipInvocationLocalization
    public var links: DocumentLinks

    public init(data: BetaAppClipInvocationLocalization, links: DocumentLinks) {
        self.data = data
        self.links = links
    }
}
