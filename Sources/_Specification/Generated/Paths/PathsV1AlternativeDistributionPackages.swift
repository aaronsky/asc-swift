// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1 {
    public var alternativeDistributionPackages: AlternativeDistributionPackages {
        AlternativeDistributionPackages(path: path + "/alternativeDistributionPackages")
    }

    public struct AlternativeDistributionPackages {
        /// Path: `/v1/alternativeDistributionPackages`
        public let path: String

        public func post(_ body: _Specification.AlternativeDistributionPackageCreateRequest) -> Request<_Specification.AlternativeDistributionPackageResponse> {
            Request(path: path, method: "POST", body: body, id: "alternativeDistributionPackages-create_instance")
        }
    }
}