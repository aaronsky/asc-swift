// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AppStoreReviewDetailUpdateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Identifiable, Sendable {
        public var type: `Type`
        public var id: String
        public var attributes: Attributes?

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case appStoreReviewDetails
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var contactFirstName: String?
            public var contactLastName: String?
            public var contactPhone: String?
            public var contactEmail: String?
            public var demoAccountName: String?
            public var demoAccountPassword: String?
            public var isDemoAccountRequired: Bool?
            public var notes: String?

            public init(contactFirstName: String? = nil, contactLastName: String? = nil, contactPhone: String? = nil, contactEmail: String? = nil, demoAccountName: String? = nil, demoAccountPassword: String? = nil, isDemoAccountRequired: Bool? = nil, notes: String? = nil) {
                self.contactFirstName = contactFirstName
                self.contactLastName = contactLastName
                self.contactPhone = contactPhone
                self.contactEmail = contactEmail
                self.demoAccountName = demoAccountName
                self.demoAccountPassword = demoAccountPassword
                self.isDemoAccountRequired = isDemoAccountRequired
                self.notes = notes
            }

            private enum CodingKeys: String, CodingKey {
                case contactFirstName
                case contactLastName
                case contactPhone
                case contactEmail
                case demoAccountName
                case demoAccountPassword
                case isDemoAccountRequired = "demoAccountRequired"
                case notes
            }
        }

        public init(type: `Type` = .appStoreReviewDetails, id: String, attributes: Attributes? = nil) {
            self.type = type
            self.id = id
            self.attributes = attributes
        }
    }

    public init(data: Data) {
        self.data = data
    }
}