// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct EndUserLicenseAgreementUpdateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Identifiable, Sendable {
        public var type: `Type`
        public var id: String
        public var attributes: Attributes?
        public var relationships: Relationships?

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case endUserLicenseAgreements
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var agreementText: String?

            public init(agreementText: String? = nil) {
                self.agreementText = agreementText
            }
        }

        public struct Relationships: Codable, Equatable, Sendable {
            public var territories: Territories?

            public struct Territories: Codable, Equatable, Sendable {
                public var data: [Datum]?

                public struct Datum: Codable, Equatable, Identifiable, Sendable {
                    public var type: `Type`
                    public var id: String

                    public enum `Type`: String, CaseIterable, Codable, Sendable {
                        case territories
                    }

                    public init(type: `Type` = .territories, id: String) {
                        self.type = type
                        self.id = id
                    }
                }

                public init(data: [Datum]? = nil) {
                    self.data = data
                }
            }

            public init(territories: Territories? = nil) {
                self.territories = territories
            }
        }

        public init(type: `Type` = .endUserLicenseAgreements, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil) {
            self.type = type
            self.id = id
            self.attributes = attributes
            self.relationships = relationships
        }
    }

    public init(data: Data) {
        self.data = data
    }
}