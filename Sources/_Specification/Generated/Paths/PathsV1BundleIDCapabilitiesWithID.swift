// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.BundleIDCapabilities {
    public func id(_ id: String) -> WithID {
        WithID(path: "\(path)/\(id)")
    }

    public struct WithID {
        /// Path: `/v1/bundleIdCapabilities/{id}`
        public let path: String

        public func patch(_ body: _Specification.BundleIDCapabilityUpdateRequest) -> Request<_Specification.BundleIDCapabilityResponse> {
            Request(path: path, method: "PATCH", body: body, id: "bundleIdCapabilities-update_instance")
        }

        public var delete: Request<Void> {
            Request(path: path, method: "DELETE", id: "bundleIdCapabilities-delete_instance")
        }
    }
}
