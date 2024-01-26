// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.GameCenterMatchmakingRules.WithID.Metrics {
    public var matchmakingRuleErrors: MatchmakingRuleErrors {
        MatchmakingRuleErrors(path: path + "/matchmakingRuleErrors")
    }

    public struct MatchmakingRuleErrors {
        /// Path: `/v1/gameCenterMatchmakingRules/{id}/metrics/matchmakingRuleErrors`
        public let path: String

        public func get(limit: Int? = nil, granularity: Granularity, groupBy: [GroupBy]? = nil, filterGameCenterMatchmakingQueue: String? = nil, sort: [Sort]? = nil) -> Request<_Specification.GameCenterMatchmakingRuleErrorsV1MetricResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(limit, granularity, groupBy, filterGameCenterMatchmakingQueue, sort), id: "gameCenterMatchmakingRules-matchmakingRuleErrors-get_metrics")
        }

        private func makeGetQuery(_ limit: Int?, _ granularity: Granularity, _ groupBy: [GroupBy]?, _ filterGameCenterMatchmakingQueue: String?, _ sort: [Sort]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(limit, forKey: "limit")
            encoder.encode(granularity, forKey: "granularity")
            encoder.encode(groupBy, forKey: "groupBy")
            encoder.encode(filterGameCenterMatchmakingQueue, forKey: "filter[gameCenterMatchmakingQueue]")
            encoder.encode(sort, forKey: "sort")
            return encoder.items
        }

        public enum Granularity: String, Codable, CaseIterable {
            case p1d = "P1D"
            case pt1h = "PT1H"
            case pt15m = "PT15M"
        }

        public enum GroupBy: String, Codable, CaseIterable {
            case gameCenterMatchmakingQueue
        }

        public enum Sort: String, Codable, CaseIterable {
            case count
            case minuscount = "-count"
        }
    }
}