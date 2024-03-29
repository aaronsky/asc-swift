// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.AppStoreVersions.WithID.Relationships {
    public var build: Build {
        Build(path: path + "/build")
    }

    public struct Build {
        /// Path: `/v1/appStoreVersions/{id}/relationships/build`
        public let path: String

        public var get: Request<_Specification.AppStoreVersionBuildLinkageResponse> {
            Request(path: path, method: "GET", id: "appStoreVersions-build-get_to_one_relationship")
        }

        public func patch(_ body: _Specification.AppStoreVersionBuildLinkageRequest) -> Request<Void> {
            Request(path: path, method: "PATCH", body: body, id: "appStoreVersions-build-update_to_one_relationship")
        }
    }
}
