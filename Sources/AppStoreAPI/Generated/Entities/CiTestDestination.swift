// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct CiTestDestination: Codable, Equatable, Sendable {
    public var deviceTypeName: String?
    public var deviceTypeIdentifier: String?
    public var runtimeName: String?
    public var runtimeIdentifier: String?
    public var kind: CiTestDestinationKind?

    public init(deviceTypeName: String? = nil, deviceTypeIdentifier: String? = nil, runtimeName: String? = nil, runtimeIdentifier: String? = nil, kind: CiTestDestinationKind? = nil) {
        self.deviceTypeName = deviceTypeName
        self.deviceTypeIdentifier = deviceTypeIdentifier
        self.runtimeName = runtimeName
        self.runtimeIdentifier = runtimeIdentifier
        self.kind = kind
    }
}
