// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct BetaAppClipInvocationUpdateRequest: Codable, Hashable {
    public var data: Data

    public struct Data: Codable, Hashable, Identifiable {
        public var type: `Type`
        public var id: String
        public var attributes: Attributes?

        public enum `Type`: String, Codable, CaseIterable {
            case betaAppClipInvocations
        }

        public struct Attributes: Codable, Hashable {
            public var url: URL?

            public init(url: URL? = nil) {
                self.url = url
            }
        }

        public init(type: `Type`, id: String, attributes: Attributes? = nil) {
            self.type = type
            self.id = id
            self.attributes = attributes
        }
    }

    public init(data: Data) {
        self.data = data
    }
}
