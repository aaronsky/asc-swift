// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.BetaGroups.WithID {
    public var betaRecruitmentCriterionCompatibleBuildCheck: BetaRecruitmentCriterionCompatibleBuildCheck {
        BetaRecruitmentCriterionCompatibleBuildCheck(path: path + "/betaRecruitmentCriterionCompatibleBuildCheck")
    }

    public struct BetaRecruitmentCriterionCompatibleBuildCheck {
        /// Path: `/v1/betaGroups/{id}/betaRecruitmentCriterionCompatibleBuildCheck`
        public let path: String

        public func get(fieldsBetaRecruitmentCriterionCompatibleBuildChecks: [FieldsBetaRecruitmentCriterionCompatibleBuildChecks]? = nil) -> Request<AppStoreAPI.BetaRecruitmentCriterionCompatibleBuildCheckResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(fieldsBetaRecruitmentCriterionCompatibleBuildChecks), id: "betaGroups_betaRecruitmentCriterionCompatibleBuildCheck_getToOneRelated")
        }

        private func makeGetQuery(_ fieldsBetaRecruitmentCriterionCompatibleBuildChecks: [FieldsBetaRecruitmentCriterionCompatibleBuildChecks]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(fieldsBetaRecruitmentCriterionCompatibleBuildChecks, forKey: "fields[betaRecruitmentCriterionCompatibleBuildChecks]", explode: false)
            return encoder.items
        }

        public enum FieldsBetaRecruitmentCriterionCompatibleBuildChecks: String, CaseIterable, Codable, Sendable {
            case hasCompatibleBuild
        }
    }
}
