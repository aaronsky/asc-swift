// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.InAppPurchasePriceSchedules.WithID.Relationships {
    public var baseTerritory: BaseTerritory {
        BaseTerritory(path: path + "/baseTerritory")
    }

    public struct BaseTerritory {
        /// Path: `/v1/inAppPurchasePriceSchedules/{id}/relationships/baseTerritory`
        public let path: String

        public var get: Request<AppStoreAPI.InAppPurchasePriceScheduleBaseTerritoryLinkageResponse> {
            Request(path: path, method: "GET", id: "inAppPurchasePriceSchedules_baseTerritory_getToOneRelationship")
        }
    }
}
