// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct BuildIndividualTestersLinkagesResponse: Codable, Equatable, Sendable {
    public var data: [Datum]
    public var links: PagedDocumentLinks
    public var meta: PagingInformation?

    public struct Datum: Codable, Equatable, Identifiable, Sendable {
        public var type: `Type`
        public var id: String

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case betaTesters
        }

        public init(type: `Type` = .betaTesters, id: String) {
            self.type = type
            self.id = id
        }
    }

    public init(data: [Datum], links: PagedDocumentLinks, meta: PagingInformation? = nil) {
        self.data = data
        self.links = links
        self.meta = meta
    }
}