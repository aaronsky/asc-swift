import Foundation
import Mocks
import XCTest

@testable import AppStoreConnect

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

extension URLRequest {
    fileprivate init?(string urlString: String) {
        guard let url = URL(string: urlString) else { return nil }

        self.init(url: url)
    }

    fileprivate static var testSendAsync: Self { .init(string: "https://example.com/test-send-async")! }
    fileprivate static var testSendAsyncError: Self { .init(string: "https://example.com/test-send-async-error")! }
    fileprivate static var testDownloadAsync: Self { .init(string: "https://example.com/test-download-async")! }
    fileprivate static var testDownloadAsyncError: Self {
        .init(string: "https://example.com/test-download-async-error")!
    }
    fileprivate static var testUploadAsync: Self { .init(string: "https://example.com/test-upload-async")! }
    fileprivate static var testUploadAsyncError: Self { .init(string: "https://example.com/test-upload-async-error")! }
}

class TransportTests: XCTestCase {
    private static func createSession() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]

        return URLSession(configuration: config)
    }

    private class MockURLProtocol: URLProtocol {
        typealias ResponseMaker = @Sendable (URLRequest) throws -> Response<Data>

        static let knownRequests: [URLRequest: ResponseMaker] = [
            .testSendAsync: MockData.mockingSuccessNoContent(for:),
            .testSendAsyncError: MockData.mockingError(for:),
            .testDownloadAsync: MockData.mockingSuccessNoContent(for:),
            .testDownloadAsyncError: MockData.mockingError(for:),
            .testUploadAsync: MockData.mockingSuccessNoContent(for:),
            .testUploadAsyncError: MockData.mockingError(for:),
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

    func testURLSessionSendRequest() async throws {
        _ = try await Self.createSession()
            .send(request: .testSendAsync, decoder: JSONDecoder())
    }

    func testURLSessionSendRequestFailure() async throws {
        try await XCTAssertThrowsError(
            await Self.createSession()
                .send(request: .testSendAsyncError, decoder: JSONDecoder())
        )
    }

    func testURLSessionDownloadRequest() async throws {
        _ = try await Self.createSession()
            .download(request: .testDownloadAsync)
    }

    func testURLSessionDownloadRequestFailure() async throws {
        try await XCTAssertThrowsError(
            await Self.createSession().download(request: .testDownloadAsyncError)
        )
    }

    func testURLSessionUploadRequest() async throws {
        _ = try await Self.createSession()
            .upload(request: .testUploadAsync, data: Data(), decoder: JSONDecoder())
    }

    func testURLSessionUploadRequestFailure() async throws {
        try await XCTAssertThrowsError(
            await Self.createSession()
                .upload(request: .testUploadAsyncError, data: Data(), decoder: JSONDecoder())
        )
    }
}
