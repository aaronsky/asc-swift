// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct DeviceResponse: Codable, Equatable, Sendable {
    /// Device
    public var data: Device
    public var links: DocumentLinks

    public init(data: Device, links: DocumentLinks) {
        self.data = data
        self.links = links
    }
}