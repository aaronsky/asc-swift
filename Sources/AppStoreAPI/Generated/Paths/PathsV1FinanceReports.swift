// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1 {
    public var financeReports: FinanceReports {
        FinanceReports(path: path + "/financeReports")
    }

    public struct FinanceReports {
        /// Path: `/v1/financeReports`
        public let path: String

        public func get(filterRegionCode: [String], filterReportDate: [String], filterReportType: [FilterReportType], filterVendorNumber: [String]) -> Request<Data> {
            Request(path: path, method: "GET", query: makeGetQuery(filterRegionCode, filterReportDate, filterReportType, filterVendorNumber), id: "financeReports-get_collection")
        }

        private func makeGetQuery(_ filterRegionCode: [String], _ filterReportDate: [String], _ filterReportType: [FilterReportType], _ filterVendorNumber: [String]) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(filterRegionCode, forKey: "filter[regionCode]")
            encoder.encode(filterReportDate, forKey: "filter[reportDate]")
            encoder.encode(filterReportType, forKey: "filter[reportType]")
            encoder.encode(filterVendorNumber, forKey: "filter[vendorNumber]")
            return encoder.items
        }

        public enum FilterReportType: String, CaseIterable, Codable, Sendable {
            case financial = "FINANCIAL"
            case financeDetail = "FINANCE_DETAIL"
        }
    }
}