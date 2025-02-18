// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct BetaGroupsResponse: Codable, Equatable, Sendable {
    public var data: [BetaGroup]
    public var included: [IncludedItem]?
    public var links: PagedDocumentLinks
    public var meta: PagingInformation?

    public enum IncludedItem: Codable, Equatable, Sendable {
        case app(App)
        case build(Build)
        case betaTester(BetaTester)
        case betaRecruitmentCriterion(BetaRecruitmentCriterion)

        public init(from decoder: any Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let value = try? container.decode(App.self) {
                self = .app(value)
            } else if let value = try? container.decode(Build.self) {
                self = .build(value)
            } else if let value = try? container.decode(BetaTester.self) {
                self = .betaTester(value)
            } else if let value = try? container.decode(BetaRecruitmentCriterion.self) {
                self = .betaRecruitmentCriterion(value)
            } else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Data could not be decoded as any of the expected types (App, Build, BetaTester, BetaRecruitmentCriterion)."
                )
            }
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .app(let value): try container.encode(value)
            case .build(let value): try container.encode(value)
            case .betaTester(let value): try container.encode(value)
            case .betaRecruitmentCriterion(let value): try container.encode(value)
            }
        }
    }

    public init(data: [BetaGroup], included: [IncludedItem]? = nil, links: PagedDocumentLinks, meta: PagingInformation? = nil) {
        self.data = data
        self.included = included
        self.links = links
        self.meta = meta
    }
}
