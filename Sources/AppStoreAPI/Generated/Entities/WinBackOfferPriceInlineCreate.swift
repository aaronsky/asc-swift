// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct WinBackOfferPriceInlineCreate: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case winBackOfferPrices
    }

    public init(type: `Type` = .winBackOfferPrices, id: String? = nil) {
        self.type = type
        self.id = id
    }
}