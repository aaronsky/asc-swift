// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V2 {
    public var appAvailabilities: AppAvailabilities {
        AppAvailabilities(path: path + "/appAvailabilities")
    }

    public struct AppAvailabilities {
        /// Path: `/v2/appAvailabilities`
        public let path: String

        public func post(_ body: AppStoreAPI.AppAvailabilityV2CreateRequest) -> Request<AppStoreAPI.AppAvailabilityV2Response> {
            Request(path: path, method: "POST", body: body, id: "appAvailabilitiesV2_createInstance")
        }
    }
}
