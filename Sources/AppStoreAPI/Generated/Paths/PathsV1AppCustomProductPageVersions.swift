// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1 {
    public var appCustomProductPageVersions: AppCustomProductPageVersions {
        AppCustomProductPageVersions(path: path + "/appCustomProductPageVersions")
    }

    public struct AppCustomProductPageVersions {
        /// Path: `/v1/appCustomProductPageVersions`
        public let path: String

        public func post(_ body: AppStoreAPI.AppCustomProductPageVersionCreateRequest) -> Request<AppStoreAPI.AppCustomProductPageVersionResponse> {
            Request(path: path, method: "POST", body: body, id: "appCustomProductPageVersions-create_instance")
        }
    }
}