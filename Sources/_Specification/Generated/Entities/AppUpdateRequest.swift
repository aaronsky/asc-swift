// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct AppUpdateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Identifiable, Sendable {
        public var type: `Type`
        public var id: String
        public var attributes: Attributes?

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case apps
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var bundleID: String?
            public var primaryLocale: String?
            public var subscriptionStatusURL: URL?
            public var subscriptionStatusURLVersion: SubscriptionStatusURLVersion?
            public var subscriptionStatusURLForSandbox: URL?
            public var subscriptionStatusURLVersionForSandbox: SubscriptionStatusURLVersion?
            public var contentRightsDeclaration: ContentRightsDeclaration?

            public enum ContentRightsDeclaration: String, CaseIterable, Codable, Sendable {
                case doesNotUseThirdPartyContent = "DOES_NOT_USE_THIRD_PARTY_CONTENT"
                case usesThirdPartyContent = "USES_THIRD_PARTY_CONTENT"
            }

            public init(bundleID: String? = nil, primaryLocale: String? = nil, subscriptionStatusURL: URL? = nil, subscriptionStatusURLVersion: SubscriptionStatusURLVersion? = nil, subscriptionStatusURLForSandbox: URL? = nil, subscriptionStatusURLVersionForSandbox: SubscriptionStatusURLVersion? = nil, contentRightsDeclaration: ContentRightsDeclaration? = nil) {
                self.bundleID = bundleID
                self.primaryLocale = primaryLocale
                self.subscriptionStatusURL = subscriptionStatusURL
                self.subscriptionStatusURLVersion = subscriptionStatusURLVersion
                self.subscriptionStatusURLForSandbox = subscriptionStatusURLForSandbox
                self.subscriptionStatusURLVersionForSandbox = subscriptionStatusURLVersionForSandbox
                self.contentRightsDeclaration = contentRightsDeclaration
            }

            private enum CodingKeys: String, CodingKey {
                case bundleID = "bundleId"
                case primaryLocale
                case subscriptionStatusURL = "subscriptionStatusUrl"
                case subscriptionStatusURLVersion = "subscriptionStatusUrlVersion"
                case subscriptionStatusURLForSandbox = "subscriptionStatusUrlForSandbox"
                case subscriptionStatusURLVersionForSandbox = "subscriptionStatusUrlVersionForSandbox"
                case contentRightsDeclaration
            }
        }

        public init(type: `Type` = .apps, id: String, attributes: Attributes? = nil) {
            self.type = type
            self.id = id
            self.attributes = attributes
        }
    }

    public init(data: Data) {
        self.data = data
    }
}
