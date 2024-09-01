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
    fileprivate static var testSendClosure: Self { .init(string: "https://example.com/test-send-closure")! }
    fileprivate static var testSendClosureError: Self { .init(string: "https://example.com/test-send-closure-error")! }
    fileprivate static var testDownloadClosure: Self { .init(string: "https://example.com/test-download-closure")! }
    fileprivate static var testDownloadClosureError: Self {
        .init(string: "https://example.com/test-download-closure-error")!
    }
    fileprivate static var testUploadClosure: Self { .init(string: "https://example.com/test-upload-closure")! }
    fileprivate static var testUploadClosureError: Self {
        .init(string: "https://example.com/test-upload-closure-error")!
    }
}

class TransportTests: XCTestCase {
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
            .testDownloadAsync: MockData.mockingSuccessNoContent(for:),
            .testDownloadAsyncError: MockData.mockingError(for:),
            .testUploadAsync: MockData.mockingSuccessNoContent(for:),
            .testUploadAsyncError: MockData.mockingError(for:),

            .testSendClosure: MockData.mockingSuccessNoContent(for:),
            .testSendClosureError: MockData.mockingError(for:),
            .testDownloadClosure: MockData.mockingSuccessNoContent(for:),
            .testDownloadClosureError: MockData.mockingError(for:),
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

    func testURLSessionSendRequest() async throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        _ = try await createSession()
            .send(request: .testSendAsync, decoder: decoder)
    }

    func testURLSessionSendRequestFailure() async throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        try await XCTAssertThrowsError(
            await createSession()
                .send(request: .testSendAsyncError, decoder: decoder)
        )
    }

    func testURLSessionDownloadRequest() async throws {
        _ = try await createSession()
            .download(request: .testDownloadAsync)
    }

    func testURLSessionDownloadRequestFailure() async throws {
        try await XCTAssertThrowsError(
            await createSession().download(request: .testDownloadAsyncError)
        )
    }

    func testURLSessionUploadRequest() async throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        _ = try await createSession()
            .upload(request: .testUploadAsync, data: Data(), decoder: decoder)
    }

    func testURLSessionUploadRequestFailure() async throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        try await XCTAssertThrowsError(
            await createSession()
                .upload(request: .testUploadAsyncError, data: Data(), decoder: decoder)
        )
    }
}

#if compiler(<6.0) && (os(Linux) || os(Windows))
    extension TransportTests {
        func testURLSessionSendRequestCompletion() {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
            let expectation = XCTestExpectation(description: "test-send-closure")
            createSession()
                .send(request: .testSendClosure, decoder: decoder) { result in
                    XCTAssertNoThrow({ try result.get() })
                    expectation.fulfill()
                }
        }

        func testURLSessionSendRequestCompletionFailure() {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
            let expectation = XCTestExpectation(description: "test-send-closure-error")
            createSession()
                .send(request: .testSendClosureError, decoder: decoder) { result in
                    expectation.fulfill()
                }
        }

        func testURLSessionDownloadRequestCompletion() {
            let expectation = XCTestExpectation(description: "test-download-closure")
            createSession()
                .download(request: .testDownloadClosure) { result in
                    XCTAssertNoThrow({ try result.get() })
                    expectation.fulfill()
                }
        }

        func testURLSessionDownloadRequestCompletionFailure() {
            let expectation = XCTestExpectation(description: "test-download-closure-error")
            createSession()
                .download(request: .testDownloadClosureError) { result in
                    expectation.fulfill()
                }
        }

        func testURLSessionUploadRequestCompletion() {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
            let expectation = XCTestExpectation(description: "test-upload-closure")
            createSession()
                .upload(request: .testUploadClosure, data: Data(), decoder: decoder) { result in
                    XCTAssertNoThrow({ try result.get() })
                    expectation.fulfill()
                }
        }

        func testURLSessionUploadRequestCompletionFailure() {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
            let expectation = XCTestExpectation(description: "test-upload-closure-error")
            createSession()
                .upload(request: .testUploadClosureError, data: Data(), decoder: decoder) { result in
                    expectation.fulfill()
                }
        }

    }
#endif
