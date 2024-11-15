// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct CiProductResponse: Codable, Equatable, Sendable {
    /// CiProduct
    public var data: CiProduct
    public var included: [IncludedItem]?
    public var links: DocumentLinks

    public enum IncludedItem: Codable, Equatable, Sendable {
        case app(App)
        case bundleID(BundleID)
        case scmRepository(ScmRepository)

        public init(from decoder: any Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let value = try? container.decode(App.self) {
                self = .app(value)
            } else if let value = try? container.decode(BundleID.self) {
                self = .bundleID(value)
            } else if let value = try? container.decode(ScmRepository.self) {
                self = .scmRepository(value)
            } else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Data could not be decoded as any of the expected types (App, BundleID, ScmRepository)."
                )
            }
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .app(let value): try container.encode(value)
            case .bundleID(let value): try container.encode(value)
            case .scmRepository(let value): try container.encode(value)
            }
        }
    }

    public init(data: CiProduct, included: [IncludedItem]? = nil, links: DocumentLinks) {
        self.data = data
        self.included = included
        self.links = links
    }
}
