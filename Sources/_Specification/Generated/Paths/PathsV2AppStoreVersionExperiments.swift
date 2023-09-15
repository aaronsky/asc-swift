// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V2 {
    public var appStoreVersionExperiments: AppStoreVersionExperiments {
        AppStoreVersionExperiments(path: path + "/appStoreVersionExperiments")
    }

    public struct AppStoreVersionExperiments {
        /// Path: `/v2/appStoreVersionExperiments`
        public let path: String

        public func post(_ body: _Specification.AppStoreVersionExperimentV2CreateRequest) -> Request<_Specification.AppStoreVersionExperimentV2Response> {
            Request(path: path, method: "POST", body: body, id: "appStoreVersionExperimentsV2-create_instance")
        }
    }
}