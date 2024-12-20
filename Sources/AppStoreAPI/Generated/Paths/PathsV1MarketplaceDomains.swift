// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1 {
    public var marketplaceDomains: MarketplaceDomains {
        MarketplaceDomains(path: path + "/marketplaceDomains")
    }

    public struct MarketplaceDomains {
        /// Path: `/v1/marketplaceDomains`
        public let path: String

        public func get(fieldsMarketplaceDomains: [FieldsMarketplaceDomains]? = nil, limit: Int? = nil) -> Request<AppStoreAPI.MarketplaceDomainsResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsMarketplaceDomains, limit), id: "marketplaceDomains_getCollection")
        }

        private func makeGetQuery(_ fieldsMarketplaceDomains: [FieldsMarketplaceDomains]?, _ limit: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(fieldsMarketplaceDomains, forKey: "fields[marketplaceDomains]", explode: false)
            encoder.encode(limit, forKey: "limit")
            return encoder.items
        }

        public enum FieldsMarketplaceDomains: String, CaseIterable, Codable, Sendable {
            case domain
            case referenceName
            case createdDate
        }

        public func post(_ body: AppStoreAPI.MarketplaceDomainCreateRequest) -> Request<AppStoreAPI.MarketplaceDomainResponse> {
            Request(path: path, method: "POST", body: body, id: "marketplaceDomains_createInstance")
        }
    }
}
