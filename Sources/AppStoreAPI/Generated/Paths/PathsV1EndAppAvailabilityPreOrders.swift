// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1 {
    public var endAppAvailabilityPreOrders: EndAppAvailabilityPreOrders {
        EndAppAvailabilityPreOrders(path: path + "/endAppAvailabilityPreOrders")
    }

    public struct EndAppAvailabilityPreOrders {
        /// Path: `/v1/endAppAvailabilityPreOrders`
        public let path: String

        public func post(_ body: AppStoreAPI.EndAppAvailabilityPreOrderCreateRequest) -> Request<AppStoreAPI.EndAppAvailabilityPreOrderResponse> {
            Request(path: path, method: "POST", body: body, id: "endAppAvailabilityPreOrders-create_instance")
        }
    }
}