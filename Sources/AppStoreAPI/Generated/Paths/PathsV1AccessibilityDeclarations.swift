// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1 {
    public var accessibilityDeclarations: AccessibilityDeclarations {
        AccessibilityDeclarations(path: path + "/accessibilityDeclarations")
    }

    public struct AccessibilityDeclarations {
        /// Path: `/v1/accessibilityDeclarations`
        public let path: String

        public func post(_ body: AppStoreAPI.AccessibilityDeclarationCreateRequest) -> Request<AppStoreAPI.AccessibilityDeclarationResponse> {
            Request(path: path, method: "POST", body: body, id: "accessibilityDeclarations_createInstance")
        }
    }
}
