import Foundation
import Mocks
import Testing

@testable import AppStoreConnect

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

@Test func urlSessionSendRequest() async throws {
    _ = try await createSession()
        .send(request: .testSendAsync, decoder: JSONDecoder())
}

@Test func urlSessionSendRequestFailure() async throws {
    await #expect(throws: (any Error).self) {
        try await createSession()
            .send(request: .testSendAsyncError, decoder: JSONDecoder())
    }
}

@Test func urlSessionDownloadRequest() async throws {
    _ = try await createSession()
        .download(request: .testDownloadAsync)
}

@Test func urlSessionDownloadRequestFailure() async throws {
    await #expect(throws: (any Error).self) {
        try await createSession().download(request: .testDownloadAsyncError)
    }
}

@Test func urlSessionUploadRequest() async throws {
    _ = try await createSession()
        .upload(request: .testUploadAsync, data: Data(), decoder: JSONDecoder())
}

@Test func urlSessionUploadRequestFailure() async throws {
    await #expect(throws: (any Error).self) {
        try await createSession()
            .upload(request: .testUploadAsyncError, data: Data(), decoder: JSONDecoder())
    }
}

private func createSession() -> URLSession {
    let config = URLSessionConfiguration.ephemeral
    config.protocolClasses = [MockURLProtocol.self]

    return URLSession(configuration: config)
}

private class MockURLProtocol: URLProtocol {
    typealias ResponseMaker = @Sendable (URLRequest) throws -> Response<Data>

    static let knownRequests: [URLRequest: ResponseMaker] = [
        .testSendAsync: MockData.mockingSuccessNoContent(for:),
        .testSendAsyncError: MockData.mockingError(for:),
        .testSendClosure: MockData.mockingSuccessNoContent(for:),
        .testSendClosureError: MockData.mockingError(for:),
        .testDownloadAsync: MockData.mockingSuccessNoContent(for:),
        .testDownloadAsyncError: MockData.mockingError(for:),
        .testDownloadClosure: MockData.mockingSuccessNoContent(for:),
        .testDownloadClosureError: MockData.mockingError(for:),
        .testUploadAsync: MockData.mockingSuccessNoContent(for:),
        .testUploadAsyncError: MockData.mockingError(for:),
        .testUploadClosure: MockData.mockingSuccessNoContent(for:),
        .testUploadClosureError: MockData.mockingError(for:),
    ]

    override class func canInit(with request: URLRequest) -> Bool {
        knownRequests.keys.contains(request)
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        do {
            let response = try MockURLProtocol.knownRequests[request]!(request)
            let (data, urlResponse) = (response.data ?? Data(), response.response)

            self.client?.urlProtocol(self, didReceive: urlResponse, cacheStoragePolicy: .notAllowed)
            self.client?.urlProtocol(self, didLoad: data)
            self.client?.urlProtocolDidFinishLoading(self)
        } catch {
            self.client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {}
}

extension URLRequest {
    fileprivate init?(string urlString: String) {
        guard let url = URL(string: urlString) else { return nil }

        self.init(url: url)
    }

    fileprivate static var testSendAsync: Self { .init(string: "https://example.com/test-send-async")! }
    fileprivate static var testSendAsyncError: Self { .init(string: "https://example.com/test-send-async-error")! }
    fileprivate static var testSendClosure: Self { .init(string: "https://example.com/test-send-closure")! }
    fileprivate static var testSendClosureError: Self { .init(string: "https://example.com/test-send-closure-error")! }
    fileprivate static var testDownloadAsync: Self { .init(string: "https://example.com/test-download-async")! }
    fileprivate static var testDownloadAsyncError: Self {
        .init(string: "https://example.com/test-download-async-error")!
    }
    fileprivate static var testDownloadClosure: Self { .init(string: "https://example.com/test-download-closure")! }
    fileprivate static var testDownloadClosureError: Self {
        .init(string: "https://example.com/test-download-closure-error")!
    }
    fileprivate static var testUploadAsync: Self { .init(string: "https://example.com/test-upload-async")! }
    fileprivate static var testUploadAsyncError: Self { .init(string: "https://example.com/test-upload-async-error")! }
    fileprivate static var testUploadClosure: Self { .init(string: "https://example.com/test-upload-closure")! }
    fileprivate static var testUploadClosureError: Self {
        .init(string: "https://example.com/test-upload-closure-error")!
    }
}
