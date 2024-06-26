// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1 {
    public var gameCenterMatchmakingRuleSets: GameCenterMatchmakingRuleSets {
        GameCenterMatchmakingRuleSets(path: path + "/gameCenterMatchmakingRuleSets")
    }

    public struct GameCenterMatchmakingRuleSets {
        /// Path: `/v1/gameCenterMatchmakingRuleSets`
        public let path: String

        public func get(fieldsGameCenterMatchmakingRuleSets: [FieldsGameCenterMatchmakingRuleSets]? = nil, limit: Int? = nil, include: [Include]? = nil, fieldsGameCenterMatchmakingQueues: [FieldsGameCenterMatchmakingQueues]? = nil, fieldsGameCenterMatchmakingTeams: [FieldsGameCenterMatchmakingTeams]? = nil, fieldsGameCenterMatchmakingRules: [FieldsGameCenterMatchmakingRules]? = nil, limitMatchmakingQueues: Int? = nil, limitRules: Int? = nil, limitTeams: Int? = nil) -> Request<_Specification.GameCenterMatchmakingRuleSetsResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsGameCenterMatchmakingRuleSets, limit, include, fieldsGameCenterMatchmakingQueues, fieldsGameCenterMatchmakingTeams, fieldsGameCenterMatchmakingRules, limitMatchmakingQueues, limitRules, limitTeams), id: "gameCenterMatchmakingRuleSets-get_collection")
        }

        private func makeGetQuery(_ fieldsGameCenterMatchmakingRuleSets: [FieldsGameCenterMatchmakingRuleSets]?, _ limit: Int?, _ include: [Include]?, _ fieldsGameCenterMatchmakingQueues: [FieldsGameCenterMatchmakingQueues]?, _ fieldsGameCenterMatchmakingTeams: [FieldsGameCenterMatchmakingTeams]?, _ fieldsGameCenterMatchmakingRules: [FieldsGameCenterMatchmakingRules]?, _ limitMatchmakingQueues: Int?, _ limitRules: Int?, _ limitTeams: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(fieldsGameCenterMatchmakingRuleSets, forKey: "fields[gameCenterMatchmakingRuleSets]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(include, forKey: "include")
            encoder.encode(fieldsGameCenterMatchmakingQueues, forKey: "fields[gameCenterMatchmakingQueues]")
            encoder.encode(fieldsGameCenterMatchmakingTeams, forKey: "fields[gameCenterMatchmakingTeams]")
            encoder.encode(fieldsGameCenterMatchmakingRules, forKey: "fields[gameCenterMatchmakingRules]")
            encoder.encode(limitMatchmakingQueues, forKey: "limit[matchmakingQueues]")
            encoder.encode(limitRules, forKey: "limit[rules]")
            encoder.encode(limitTeams, forKey: "limit[teams]")
            return encoder.items
        }

        public enum FieldsGameCenterMatchmakingRuleSets: String, CaseIterable, Codable, Sendable {
            case matchmakingQueues
            case maxPlayers
            case minPlayers
            case referenceName
            case ruleLanguageVersion
            case rules
            case teams
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case matchmakingQueues
            case rules
            case teams
        }

        public enum FieldsGameCenterMatchmakingQueues: String, CaseIterable, Codable, Sendable {
            case classicMatchmakingBundleIDs = "classicMatchmakingBundleIds"
            case experimentRuleSet
            case referenceName
            case ruleSet
        }

        public enum FieldsGameCenterMatchmakingTeams: String, CaseIterable, Codable, Sendable {
            case maxPlayers
            case minPlayers
            case referenceName
            case ruleSet
        }

        public enum FieldsGameCenterMatchmakingRules: String, CaseIterable, Codable, Sendable {
            case description
            case expression
            case referenceName
            case ruleSet
            case type
            case weight
        }

        public func post(_ body: _Specification.GameCenterMatchmakingRuleSetCreateRequest) -> Request<_Specification.GameCenterMatchmakingRuleSetResponse> {
            Request(path: path, method: "POST", body: body, id: "gameCenterMatchmakingRuleSets-create_instance")
        }
    }
}
