// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct FileLocation: Codable, Equatable, Sendable {
    public var path: String?
    public var lineNumber: Int?

    public init(path: String? = nil, lineNumber: Int? = nil) {
        self.path = path
        self.lineNumber = lineNumber
    }
}