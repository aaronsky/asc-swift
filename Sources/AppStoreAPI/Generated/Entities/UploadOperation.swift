// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct UploadOperation: Codable, Equatable, Sendable {
    public var method: String?
    public var url: String?
    public var length: Int?
    public var offset: Int?
    public var requestHeaders: [HTTPHeader]?

    public init(method: String? = nil, url: String? = nil, length: Int? = nil, offset: Int? = nil, requestHeaders: [HTTPHeader]? = nil) {
        self.method = method
        self.url = url
        self.length = length
        self.offset = offset
        self.requestHeaders = requestHeaders
    }
}