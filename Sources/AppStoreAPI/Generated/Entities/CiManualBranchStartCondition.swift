// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct CiManualBranchStartCondition: Codable, Equatable, Sendable {
    public var source: CiBranchPatterns?

    public init(source: CiBranchPatterns? = nil) {
        self.source = source
    }
}