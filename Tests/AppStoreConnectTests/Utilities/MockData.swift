import Foundation

@testable import AppStoreConnect

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct MockResources {
    struct Content: Codable, Equatable {
        var name: String
        var age: Int
    }

    var content = Content(name: "test", age: 10)

    struct PagedContent: Codable, Equatable {
        var name: String
        var age: Int
        var links: PagedDocumentLinks?
    }

    var pagedContentFirst = PagedContent(
        name: "test",
        age: 10,
        links: PagedDocumentLinks(
            this: URL(string: "test")!,
            first: URL(string: "test")!,
            next: URL(string: "test2")!
        )
    )
    var pagedContentNext = PagedContent(
        name: "test",
        age: 10,
        links: PagedDocumentLinks(
            this: URL(string: "test2")!,
            first: URL(string: "test")!,
            next: URL(string: "test3")!
        )
    )
    var pagedContentLast = PagedContent(
        name: "test",
        age: 10,
        links: PagedDocumentLinks(
            this: URL(string: "test3")!,
            first: URL(string: "test")!,
            next: nil
        )
    )

    struct Body: Codable, Equatable {
        var name: String
        var age: Int
    }
    var body = Body(name: "testIn", age: 45)

    var downloadURL = URL(string: "https://apple.com/hello-app-store")!

    var uploadOperationSingle = UploadOperation(
        method: "POST",
        url: "test",
        length: 64,
        offset: 0,
        requestHeaders: nil
    )
    var uploadOperationMultipart = [
        UploadOperation(
            method: "POST",
            url: "test",
            length: 32,
            offset: 0,
            requestHeaders: nil
        ),
        UploadOperation(
            method: "POST",
            url: "test",
            length: 32,
            offset: 32,
            requestHeaders: nil
        ),
        UploadOperation(
            method: "POST",
            url: "test",
            length: 16,
            offset: 64,
            requestHeaders: nil
        ),
    ]

    init() {}
}

enum MockData {
    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
}

extension MockData {
    static func mockingSuccess<Content: Codable>(with content: Content, url: URL = URL()) throws -> Response<Data> {
        let data = try MockData.encoder.encode(content)
        return .init(data: data, response: urlResponse(for: url, statusCode: 200), statusCode: 200, rate: nil)
    }

    static func mockingSuccessNoContent(url: URL = URL()) -> Response<Data> {
        return .init(data: nil, response: urlResponse(for: url, statusCode: 200), statusCode: 200, rate: nil)
    }

    static func mockingSuccessNoContent(for request: URLRequest) -> Response<Data> {
        return .init(data: nil, response: urlResponse(for: request.url!, statusCode: 200), statusCode: 200, rate: nil)
    }

    static func mockingSuccessDownload(to fileURL: URL, for url: URL = URL()) -> Response<URL> {
        return .init(fileURL: fileURL, response: urlResponse(for: url, statusCode: 200), statusCode: 200, rate: nil)
    }

    static func mockingSuccessUpload(for url: URL = URL()) -> Response<Data> {
        return .init(data: nil, response: urlResponse(for: url, statusCode: 200), statusCode: 200, rate: nil)
    }

    static func mockingIncompatibleResponse(for url: URL = URL()) -> Response<Data> {
        return .init(data: nil, response: urlResponse(for: url, statusCode: -128), statusCode: -128, rate: nil)
    }

    static func mockingUnsuccessfulResponse(for url: URL = URL()) -> Response<Data> {
        let json = """
            {"errors":[{"code":"test","status":400,"title":"test","detail":"test"}]}
            """
            .data(using: .utf8)

        return .init(data: json, response: urlResponse(for: url, statusCode: 400), statusCode: 400, rate: nil)
    }

    static func mockingError(for request: URLRequest) throws -> Response<Data> {
        throw URLError(.badURL)
    }

    static func mockingError(_ error: any Error) throws -> Response<Data> {
        throw error
    }

    private static func urlResponse(for url: URL, statusCode: Int) -> URLResponse {
        HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: "HTTP/1.1",
            headerFields: [
                "X-Rate-Limit": "user-hour-lim:2500;user-hour-rem:10;a:b:c;d:e;;"
            ]
        )!
    }
}
