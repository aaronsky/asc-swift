// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AppEventResponse: Codable, Equatable, Sendable {
    /// AppEvent
    public var data: AppEvent
    public var included: [AppEventLocalization]?
    public var links: DocumentLinks

    public init(data: AppEvent, included: [AppEventLocalization]? = nil, links: DocumentLinks) {
        self.data = data
        self.included = included
        self.links = links
    }
}
