// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct GameCenterGroupCreateRequest: Codable, Hashable {
    public var data: Data

    public struct Data: Codable, Hashable {
        public var type: `Type`
        public var attributes: Attributes?

        public enum `Type`: String, Codable, CaseIterable {
            case gameCenterGroups
        }

        public struct Attributes: Codable, Hashable {
            public var referenceName: String?

            public init(referenceName: String? = nil) {
                self.referenceName = referenceName
            }
        }

        public init(type: `Type`, attributes: Attributes? = nil) {
            self.type = type
            self.attributes = attributes
        }
    }

    public init(data: Data) {
        self.data = data
    }
}