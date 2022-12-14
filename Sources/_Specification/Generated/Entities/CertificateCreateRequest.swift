// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct CertificateCreateRequest: Codable, Hashable {
    public var data: Data

    public struct Data: Codable, Hashable {
        public var type: `Type`
        public var attributes: Attributes

        public enum `Type`: String, Codable, CaseIterable {
            case certificates
        }

        public struct Attributes: Codable, Hashable {
            public var csrContent: String
            public var certificateType: CertificateType

            public init(csrContent: String, certificateType: CertificateType) {
                self.csrContent = csrContent
                self.certificateType = certificateType
            }
        }

        public init(type: `Type`, attributes: Attributes) {
            self.type = type
            self.attributes = attributes
        }
    }

    public init(data: Data) {
        self.data = data
    }
}
