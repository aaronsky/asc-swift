// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1 {
    public var diagnosticSignatures: DiagnosticSignatures {
        DiagnosticSignatures(path: path + "/diagnosticSignatures")
    }

    public struct DiagnosticSignatures {
        /// Path: `/v1/diagnosticSignatures`
        public let path: String
    }
}