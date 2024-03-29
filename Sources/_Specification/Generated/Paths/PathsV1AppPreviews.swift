// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1 {
    public var appPreviews: AppPreviews {
        AppPreviews(path: path + "/appPreviews")
    }

    public struct AppPreviews {
        /// Path: `/v1/appPreviews`
        public let path: String

        public func post(_ body: _Specification.AppPreviewCreateRequest) -> Request<_Specification.AppPreviewResponse> {
            Request(path: path, method: "POST", body: body, id: "appPreviews-create_instance")
        }
    }
}
