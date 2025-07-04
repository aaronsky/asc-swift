// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect

public struct AccessibilityDeclarationUpdateRequest: Codable, Equatable, Sendable {
    public var data: Data

    public struct Data: Codable, Equatable, Identifiable, Sendable {
        public var type: `Type`
        public var id: String
        public var attributes: Attributes?

        public enum `Type`: String, CaseIterable, Codable, Sendable {
            case accessibilityDeclarations
        }

        public struct Attributes: Codable, Equatable, Sendable {
            public var isPublish: Bool?
            public var isSupportsAudioDescriptions: Bool?
            public var isSupportsCaptions: Bool?
            public var isSupportsDarkInterface: Bool?
            public var isSupportsDifferentiateWithoutColorAlone: Bool?
            public var isSupportsLargerText: Bool?
            public var isSupportsReducedMotion: Bool?
            public var isSupportsSufficientContrast: Bool?
            public var isSupportsVoiceControl: Bool?
            public var isSupportsVoiceover: Bool?

            public init(isPublish: Bool? = nil, isSupportsAudioDescriptions: Bool? = nil, isSupportsCaptions: Bool? = nil, isSupportsDarkInterface: Bool? = nil, isSupportsDifferentiateWithoutColorAlone: Bool? = nil, isSupportsLargerText: Bool? = nil, isSupportsReducedMotion: Bool? = nil, isSupportsSufficientContrast: Bool? = nil, isSupportsVoiceControl: Bool? = nil, isSupportsVoiceover: Bool? = nil) {
                self.isPublish = isPublish
                self.isSupportsAudioDescriptions = isSupportsAudioDescriptions
                self.isSupportsCaptions = isSupportsCaptions
                self.isSupportsDarkInterface = isSupportsDarkInterface
                self.isSupportsDifferentiateWithoutColorAlone = isSupportsDifferentiateWithoutColorAlone
                self.isSupportsLargerText = isSupportsLargerText
                self.isSupportsReducedMotion = isSupportsReducedMotion
                self.isSupportsSufficientContrast = isSupportsSufficientContrast
                self.isSupportsVoiceControl = isSupportsVoiceControl
                self.isSupportsVoiceover = isSupportsVoiceover
            }

            private enum CodingKeys: String, CodingKey {
                case isPublish = "publish"
                case isSupportsAudioDescriptions = "supportsAudioDescriptions"
                case isSupportsCaptions = "supportsCaptions"
                case isSupportsDarkInterface = "supportsDarkInterface"
                case isSupportsDifferentiateWithoutColorAlone = "supportsDifferentiateWithoutColorAlone"
                case isSupportsLargerText = "supportsLargerText"
                case isSupportsReducedMotion = "supportsReducedMotion"
                case isSupportsSufficientContrast = "supportsSufficientContrast"
                case isSupportsVoiceControl = "supportsVoiceControl"
                case isSupportsVoiceover = "supportsVoiceover"
            }
        }

        public init(type: `Type` = .accessibilityDeclarations, id: String, attributes: Attributes? = nil) {
            self.type = type
            self.id = id
            self.attributes = attributes
        }
    }

    public init(data: Data) {
        self.data = data
    }
}
