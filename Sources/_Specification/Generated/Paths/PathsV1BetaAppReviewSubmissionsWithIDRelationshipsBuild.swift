// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.BetaAppReviewSubmissions.WithID.Relationships {
    public var build: Build {
        Build(path: path + "/build")
    }

    public struct Build {
        /// Path: `/v1/betaAppReviewSubmissions/{id}/relationships/build`
        public let path: String
    }
}
