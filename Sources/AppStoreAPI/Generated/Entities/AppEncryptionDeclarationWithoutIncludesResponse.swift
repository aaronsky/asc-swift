// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AppEncryptionDeclarationWithoutIncludesResponse: Codable, Equatable, Sendable {
    /// AppEncryptionDeclaration
    public var data: AppEncryptionDeclaration
    public var links: DocumentLinks

    public init(data: AppEncryptionDeclaration, links: DocumentLinks) {
        self.data = data
        self.links = links
    }
}