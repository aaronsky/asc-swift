// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.AnalyticsReportInstances.WithID.Relationships {
    public var segments: Segments {
        Segments(path: path + "/segments")
    }

    public struct Segments {
        /// Path: `/v1/analyticsReportInstances/{id}/relationships/segments`
        public let path: String
    }
}