// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct GameCenterPlayerAchievementSubmission: Codable, Equatable, Identifiable, Sendable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var links: ResourceLinks?

    public enum `Type`: String, CaseIterable, Codable, Sendable {
        case gameCenterPlayerAchievementSubmissions
    }

    public struct Attributes: Codable, Equatable, Sendable {
        public var bundleID: String?
        public var challengeIDs: [String]?
        public var percentageAchieved: Int?
        public var scopedPlayerID: String?
        public var submittedDate: Date?
        public var vendorIdentifier: String?

        public init(bundleID: String? = nil, challengeIDs: [String]? = nil, percentageAchieved: Int? = nil, scopedPlayerID: String? = nil, submittedDate: Date? = nil, vendorIdentifier: String? = nil) {
            self.bundleID = bundleID
            self.challengeIDs = challengeIDs
            self.percentageAchieved = percentageAchieved
            self.scopedPlayerID = scopedPlayerID
            self.submittedDate = submittedDate
            self.vendorIdentifier = vendorIdentifier
        }

        private enum CodingKeys: String, CodingKey {
            case bundleID = "bundleId"
            case challengeIDs = "challengeIds"
            case percentageAchieved
            case scopedPlayerID = "scopedPlayerId"
            case submittedDate
            case vendorIdentifier
        }
    }

    public init(type: `Type` = .gameCenterPlayerAchievementSubmissions, id: String, attributes: Attributes? = nil, links: ResourceLinks? = nil) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.links = links
    }
}
