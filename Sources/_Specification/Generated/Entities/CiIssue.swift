// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation

public struct CiIssue: Codable, Hashable, Identifiable {
    public var type: `Type`
    public var id: String
    public var attributes: Attributes?
    public var links: ResourceLinks

    public enum `Type`: String, Codable, CaseIterable {
        case ciIssues
    }

    public struct Attributes: Codable, Hashable {
        public var issueType: IssueType?
        public var message: String?
        public var fileSource: FileLocation?
        public var category: String?

        public enum IssueType: String, Codable, CaseIterable {
            case analyzerWarning = "ANALYZER_WARNING"
            case error = "ERROR"
            case testFailure = "TEST_FAILURE"
            case warning = "WARNING"
        }

        public init(issueType: IssueType? = nil, message: String? = nil, fileSource: FileLocation? = nil, category: String? = nil) {
            self.issueType = issueType
            self.message = message
            self.fileSource = fileSource
            self.category = category
        }
    }

    public init(type: `Type`, id: String, attributes: Attributes? = nil, links: ResourceLinks) {
        self.type = type
        self.id = id
        self.attributes = attributes
        self.links = links
    }
}
