// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.AppStoreVersionExperimentTreatments.WithID {
    public var appStoreVersionExperimentTreatmentLocalizations: AppStoreVersionExperimentTreatmentLocalizations {
        AppStoreVersionExperimentTreatmentLocalizations(path: path + "/appStoreVersionExperimentTreatmentLocalizations")
    }

    public struct AppStoreVersionExperimentTreatmentLocalizations {
        /// Path: `/v1/appStoreVersionExperimentTreatments/{id}/appStoreVersionExperimentTreatmentLocalizations`
        public let path: String

        public func get(filterLocale: [String]? = nil, fieldsAppScreenshotSets: [FieldsAppScreenshotSets]? = nil, fieldsAppStoreVersionExperimentTreatments: [FieldsAppStoreVersionExperimentTreatments]? = nil, fieldsAppStoreVersionExperimentTreatmentLocalizations: [FieldsAppStoreVersionExperimentTreatmentLocalizations]? = nil, fieldsAppPreviewSets: [FieldsAppPreviewSets]? = nil, limit: Int? = nil, limitAppScreenshotSets: Int? = nil, limitAppPreviewSets: Int? = nil, include: [Include]? = nil) -> Request<AppStoreAPI.AppStoreVersionExperimentTreatmentLocalizationsResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(filterLocale, fieldsAppScreenshotSets, fieldsAppStoreVersionExperimentTreatments, fieldsAppStoreVersionExperimentTreatmentLocalizations, fieldsAppPreviewSets, limit, limitAppScreenshotSets, limitAppPreviewSets, include), id: "appStoreVersionExperimentTreatments-appStoreVersionExperimentTreatmentLocalizations-get_to_many_related")
        }

        private func makeGetQuery(_ filterLocale: [String]?, _ fieldsAppScreenshotSets: [FieldsAppScreenshotSets]?, _ fieldsAppStoreVersionExperimentTreatments: [FieldsAppStoreVersionExperimentTreatments]?, _ fieldsAppStoreVersionExperimentTreatmentLocalizations: [FieldsAppStoreVersionExperimentTreatmentLocalizations]?, _ fieldsAppPreviewSets: [FieldsAppPreviewSets]?, _ limit: Int?, _ limitAppScreenshotSets: Int?, _ limitAppPreviewSets: Int?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(filterLocale, forKey: "filter[locale]")
            encoder.encode(fieldsAppScreenshotSets, forKey: "fields[appScreenshotSets]")
            encoder.encode(fieldsAppStoreVersionExperimentTreatments, forKey: "fields[appStoreVersionExperimentTreatments]")
            encoder.encode(fieldsAppStoreVersionExperimentTreatmentLocalizations, forKey: "fields[appStoreVersionExperimentTreatmentLocalizations]")
            encoder.encode(fieldsAppPreviewSets, forKey: "fields[appPreviewSets]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(limitAppScreenshotSets, forKey: "limit[appScreenshotSets]")
            encoder.encode(limitAppPreviewSets, forKey: "limit[appPreviewSets]")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsAppScreenshotSets: String, CaseIterable, Codable, Sendable {
            case appCustomProductPageLocalization
            case appScreenshots
            case appStoreVersionExperimentTreatmentLocalization
            case appStoreVersionLocalization
            case screenshotDisplayType
        }

        public enum FieldsAppStoreVersionExperimentTreatments: String, CaseIterable, Codable, Sendable {
            case appIcon
            case appIconName
            case appStoreVersionExperiment
            case appStoreVersionExperimentTreatmentLocalizations
            case appStoreVersionExperimentV2
            case name
            case promotedDate
        }

        public enum FieldsAppStoreVersionExperimentTreatmentLocalizations: String, CaseIterable, Codable, Sendable {
            case appPreviewSets
            case appScreenshotSets
            case appStoreVersionExperimentTreatment
            case locale
        }

        public enum FieldsAppPreviewSets: String, CaseIterable, Codable, Sendable {
            case appCustomProductPageLocalization
            case appPreviews
            case appStoreVersionExperimentTreatmentLocalization
            case appStoreVersionLocalization
            case previewType
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case appPreviewSets
            case appScreenshotSets
            case appStoreVersionExperimentTreatment
        }
    }
}