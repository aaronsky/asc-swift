// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct EndUserLicenseAgreementWithoutIncludesResponse: Codable, Equatable, Sendable {
    /// EndUserLicenseAgreement
    public var data: EndUserLicenseAgreement
    public var links: DocumentLinks

    public init(data: EndUserLicenseAgreement, links: DocumentLinks) {
        self.data = data
        self.links = links
    }
}