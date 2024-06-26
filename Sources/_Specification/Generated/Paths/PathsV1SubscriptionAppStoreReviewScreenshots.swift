// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import URLQueryEncoder

extension Resources.V1 {
    public var subscriptionAppStoreReviewScreenshots: SubscriptionAppStoreReviewScreenshots {
        SubscriptionAppStoreReviewScreenshots(path: path + "/subscriptionAppStoreReviewScreenshots")
    }

    public struct SubscriptionAppStoreReviewScreenshots {
        /// Path: `/v1/subscriptionAppStoreReviewScreenshots`
        public let path: String

        public func post(_ body: _Specification.SubscriptionAppStoreReviewScreenshotCreateRequest) -> Request<_Specification.SubscriptionAppStoreReviewScreenshotResponse> {
            Request(path: path, method: "POST", body: body, id: "subscriptionAppStoreReviewScreenshots-create_instance")
        }
    }
}
