// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swift-format-ignore-file

import Foundation
import AppStoreConnect
import URLQueryEncoder

extension Resources.V1.CiProducts.WithID {
    public var primaryRepositories: PrimaryRepositories {
        PrimaryRepositories(path: path + "/primaryRepositories")
    }

    public struct PrimaryRepositories {
        /// Path: `/v1/ciProducts/{id}/primaryRepositories`
        public let path: String

        public func get(filterID: [String]? = nil, fieldsScmRepositories: [FieldsScmRepositories]? = nil, fieldsScmProviders: [FieldsScmProviders]? = nil, fieldsScmGitReferences: [FieldsScmGitReferences]? = nil, limit: Int? = nil, include: [Include]? = nil) -> Request<AppStoreAPI.ScmRepositoriesResponse> {
            Request(path: path, method: "GET", query: makeGetQuery(filterID, fieldsScmRepositories, fieldsScmProviders, fieldsScmGitReferences, limit, include), id: "ciProducts_primaryRepositories_getToManyRelated")
        }

        private func makeGetQuery(_ filterID: [String]?, _ fieldsScmRepositories: [FieldsScmRepositories]?, _ fieldsScmProviders: [FieldsScmProviders]?, _ fieldsScmGitReferences: [FieldsScmGitReferences]?, _ limit: Int?, _ include: [Include]?) -> [(String, String?)] {
            let encoder = URLQueryEncoder(explode: false)
            encoder.encode(filterID, forKey: "filter[id]")
            encoder.encode(fieldsScmRepositories, forKey: "fields[scmRepositories]")
            encoder.encode(fieldsScmProviders, forKey: "fields[scmProviders]")
            encoder.encode(fieldsScmGitReferences, forKey: "fields[scmGitReferences]")
            encoder.encode(limit, forKey: "limit")
            encoder.encode(include, forKey: "include")
            return encoder.items
        }

        public enum FieldsScmRepositories: String, CaseIterable, Codable, Sendable {
            case lastAccessedDate
            case httpCloneURL = "httpCloneUrl"
            case sshCloneURL = "sshCloneUrl"
            case ownerName
            case repositoryName
            case scmProvider
            case defaultBranch
            case gitReferences
            case pullRequests
        }

        public enum FieldsScmProviders: String, CaseIterable, Codable, Sendable {
            case scmProviderType
            case url
            case repositories
        }

        public enum FieldsScmGitReferences: String, CaseIterable, Codable, Sendable {
            case name
            case canonicalName
            case isDeleted
            case kind
            case repository
        }

        public enum Include: String, CaseIterable, Codable, Sendable {
            case scmProvider
            case defaultBranch
        }
    }
}
