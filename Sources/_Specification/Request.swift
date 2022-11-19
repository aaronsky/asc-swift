import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct Request<Response> {
    public var method: String
    public var url: String
    public var query: [(String, String?)]?
    public var body: (any Encodable)?
    public var headers: [String: String]?
    public var id: String?

    public init(
        method: String,
        url: String,
        query: [(String, String?)]? = nil,
        body: (any Encodable)? = nil,
        headers: [String: String]? = nil,
        id: String? = nil
    ) {
        self.method = method
        self.url = url
        self.query = query
        self.headers = headers
        self.body = body
        self.id = id
    }
}

extension Request {
    public static func get(
        _ url: String,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "GET", url: url, query: query, headers: headers)
    }

    public static func post(
        _ url: String,
        query: [(String, String?)]? = nil,
        body: Encodable? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "POST", url: url, query: query, body: body, headers: headers)
    }

    public static func put(
        _ url: String,
        query: [(String, String?)]? = nil,
        body: Encodable? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "PUT", url: url, query: query, body: body, headers: headers)
    }

    public static func patch(
        _ url: String,
        query: [(String, String?)]? = nil,
        body: Encodable? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "PATCH", url: url, query: query, body: body, headers: headers)
    }

    public static func delete(
        _ url: String,
        query: [(String, String?)]? = nil,
        body: Encodable? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "DELETE", url: url, query: query, body: body, headers: headers)
    }

    public static func options(
        _ url: String,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "OPTIONS", url: url, query: query, headers: headers)
    }

    public static func head(
        _ url: String,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "HEAD", url: url, query: query, headers: headers)
    }

    public static func trace(
        _ url: String,
        query: [(String, String?)]? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        .init(method: "TRACE", url: url, query: query, headers: headers)
    }
}
