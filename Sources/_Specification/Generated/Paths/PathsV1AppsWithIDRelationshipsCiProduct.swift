// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1.Apps.WithID.Relationships {
    public var ciProduct: CiProduct {
        CiProduct(path: path + "/ciProduct")
    }

    public struct CiProduct {
        /// Path: `/v1/apps/{id}/relationships/ciProduct`
        public let path: String
    }
}
