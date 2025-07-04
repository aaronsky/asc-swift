// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.BetaBuildLocalizations.WithID.Relationships {
    public var build: Build {
        Build(path: path + "/build")
    }

    public struct Build {
        /// Path: `/v1/betaBuildLocalizations/{id}/relationships/build`
        public let path: String

        public var get: Request<AppStoreAPI.BetaBuildLocalizationBuildLinkageResponse> {
            Request(path: path, method: "GET", id: "betaBuildLocalizations_build_getToOneRelationship")
        }
    }
}
