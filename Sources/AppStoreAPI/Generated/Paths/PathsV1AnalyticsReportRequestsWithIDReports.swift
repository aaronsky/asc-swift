// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.AnalyticsReportRequests.WithID {
    public var reports: Reports {
        Reports(path: path + "/reports")
    }

    public struct Reports {
        /// Path: `/v1/analyticsReportRequests/{id}/reports`
        public let path: String

        public func get(filterCategory: [FilterCategory]? = nil, filterName: [String]? = nil, fieldsAnalyticsReports: [FieldsAnalyticsReports]? = nil, limit: Int? = nil) -> Request<AppStoreAPI.AnalyticsReportsResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(filterCategory, filterName, fieldsAnalyticsReports, limit), id: "analyticsReportRequests-reports-get_to_many_related")
        }

        private func makeGetQuery(_ filterCategory: [FilterCategory]?, _ filterName: [String]?, _ fieldsAnalyticsReports: [FieldsAnalyticsReports]?, _ limit: Int?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(filterCategory, forKey: "filter[category]")
            encoder.encode(filterName, forKey: "filter[name]")
            encoder.encode(fieldsAnalyticsReports, forKey: "fields[analyticsReports]")
            encoder.encode(limit, forKey: "limit")
            return encoder.items
        }

        public enum FilterCategory: String, CaseIterable, Codable, Sendable {
            case appUsage = "APP_USAGE"
            case appStoreEngagement = "APP_STORE_ENGAGEMENT"
            case commerce = "COMMERCE"
            case frameworkUsage = "FRAMEWORK_USAGE"
            case performance = "PERFORMANCE"
        }

        public enum FieldsAnalyticsReports: String, CaseIterable, Codable, Sendable {
            case category
            case instances
            case name
        }
    }
}