// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct BetaLicenseAgreementWithoutIncludesResponse: Codable, Equatable, Sendable {
    /// BetaLicenseAgreement
    public var data: BetaLicenseAgreement
    public var links: DocumentLinks

    public init(data: BetaLicenseAgreement, links: DocumentLinks) {
        self.data = data
        self.links = links
    }
}
