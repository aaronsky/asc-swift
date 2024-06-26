// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.GameCenterMatchmakingRules.WithID.Metrics {
    public var matchmakingBooleanRuleResults: MatchmakingBooleanRuleResults {
        MatchmakingBooleanRuleResults(path: path + "/matchmakingBooleanRuleResults")
    }

    public struct MatchmakingBooleanRuleResults {
        /// Path: `/v1/gameCenterMatchmakingRules/{id}/metrics/matchmakingBooleanRuleResults`
        public let path: String

        public func get(limit: Int? = nil, granularity: Granularity, groupBy: [GroupBy]? = nil, filterResult: String? = nil, filterGameCenterMatchmakingQueue: String? = nil, sort: [Sort]? = nil) -> Request<_Specification.GameCenterMatchmakingBooleanRuleResultsV1MetricResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(limit, granularity, groupBy, filterResult, filterGameCenterMatchmakingQueue, sort), id: "gameCenterMatchmakingRules-matchmakingBooleanRuleResults-get_metrics")
        }

        private func makeGetQuery(_ limit: Int?, _ granularity: Granularity, _ groupBy: [GroupBy]?, _ filterResult: String?, _ filterGameCenterMatchmakingQueue: String?, _ sort: [Sort]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(limit, forKey: "limit")
            encoder.encode(granularity, forKey: "granularity")
            encoder.encode(groupBy, forKey: "groupBy")
            encoder.encode(filterResult, forKey: "filter[result]")
            encoder.encode(filterGameCenterMatchmakingQueue, forKey: "filter[gameCenterMatchmakingQueue]")
            encoder.encode(sort, forKey: "sort")
            return encoder.items
        }

        public enum Granularity: String, CaseIterable, Codable, Sendable {
            case p1d = "P1D"
            case pt1h = "PT1H"
            case pt15m = "PT15M"
        }

        public enum GroupBy: String, CaseIterable, Codable, Sendable {
            case gameCenterMatchmakingQueue
            case result
        }

        public enum Sort: String, CaseIterable, Codable, Sendable {
            case count
            case minuscount = "-count"
        }
    }
}
