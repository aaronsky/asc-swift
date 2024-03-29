// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1 {
    public var appClipHeaderImages: AppClipHeaderImages {
        AppClipHeaderImages(path: path + "/appClipHeaderImages")
    }

    public struct AppClipHeaderImages {
        /// Path: `/v1/appClipHeaderImages`
        public let path: String

        public func post(_ body: _Specification.AppClipHeaderImageCreateRequest) -> Request<_Specification.AppClipHeaderImageResponse> {
            Request(path: path, method: "POST", body: body, id: "appClipHeaderImages-create_instance")
        }
    }
}
