import Foundation
import Mocks
import XCTest

@testable import AppStoreConnect

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

class TransportTests: XCTestCase {
    private func createSession() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]

        return URLSession(configuration: config)
    }

    private class MockURLProtocol: URLProtocol {
        typealias ResponseMaker = @Sendable (URLRequest) throws -> Response<Data>

        static let knownRequests: [URLRequest: ResponseMaker] = [
            URLRequest(url: URL(string: "https://example.com/test-send-async")!): MockData.mockingSuccessNoContent(
                for:),
            URLRequest(url: URL(string: "https://example.com/test-send-async-error")!): MockData.mockingError(for:),
            URLRequest(url: URL(string: "https://example.com/test-send-closure")!): MockData.mockingSuccessNoContent(
                for:),
            URLRequest(url: URL(string: "https://example.com/test-send-closure-error")!): MockData.mockingError(for:),
            URLRequest(url: URL(string: "https://example.com/test-download-async")!): MockData.mockingSuccessNoContent(
                for:),
            URLRequest(url: URL(string: "https://example.com/test-download-async-error")!): MockData.mockingError(for:),
            URLRequest(url: URL(string: "https://example.com/test-download-closure")!): MockData
                .mockingSuccessNoContent(for:),
            URLRequest(url: URL(string: "https://example.com/test-download-closure-error")!): MockData.mockingError(
                for:),
            URLRequest(url: URL(string: "https://example.com/test-upload-async")!): MockData.mockingSuccessNoContent(
                for:),
            URLRequest(url: URL(string: "https://example.com/test-upload-async-error")!): MockData.mockingError(for:),
            URLRequest(url: URL(string: "https://example.com/test-upload-closure")!): MockData.mockingSuccessNoContent(
                for:),
            URLRequest(url: URL(string: "https://example.com/test-upload-closure-error")!): MockData.mockingError(for:),
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
        let request = URLRequest(url: URL(string: "https://example.com/test-send-async")!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        _ = try await createSession()
            .send(request: request, decoder: decoder)
    }

    func testURLSessionSendRequestFailure() async throws {
        let request = URLRequest(url: URL(string: "https://example.com/test-send-async-error")!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        try await XCTAssertThrowsError(
            await createSession()
                .send(request: request, decoder: decoder)
        )
    }

    func testURLSessionSendRequestCompletion() {
        let request = URLRequest(url: URL(string: "https://example.com/test-send-closure")!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        let expectation = XCTestExpectation(description: "test-send-closure")
        createSession()
            .send(request: request, decoder: decoder) { result in
                XCTAssertNoThrow({ try result.get() })
                expectation.fulfill()
            }
    }

    func testURLSessionSendRequestCompletionFailure() {
        let request = URLRequest(url: URL(string: "https://example.com/test-send-closure-error")!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        let expectation = XCTestExpectation(description: "test-send-closure-error")
        createSession()
            .send(request: request, decoder: decoder) { result in
                expectation.fulfill()
            }
    }

    func testURLSessionDownloadRequest() async throws {
        let request = URLRequest(url: URL(string: "https://example.com/test-download-async")!)
        _ = try await createSession()
            .download(request: request)
    }

    func testURLSessionDownloadRequestFailure() async throws {
        let request = URLRequest(url: URL(string: "https://example.com/test-download-async-error")!)
        try await XCTAssertThrowsError(
            await createSession().download(request: request)
        )
    }

    func testURLSessionDownloadRequestCompletion() {
        let request = URLRequest(url: URL(string: "https://example.com/test-download-closure")!)
        let expectation = XCTestExpectation(description: "test-download-closure")
        createSession()
            .download(request: request) { result in
                XCTAssertNoThrow({ try result.get() })
                expectation.fulfill()
            }
    }

    func testURLSessionDownloadRequestCompletionFailure() {
        let request = URLRequest(url: URL(string: "https://example.com/test-download-closure-error")!)
        let expectation = XCTestExpectation(description: "test-download-closure-error")
        createSession()
            .download(request: request) { result in
                expectation.fulfill()
            }
    }

    func testURLSessionUploadRequest() async throws {
        let request = URLRequest(url: URL(string: "https://example.com/test-upload-async")!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        _ = try await createSession()
            .upload(request: request, data: Data(), decoder: decoder)
    }

    func testURLSessionUploadRequestFailure() async throws {
        let request = URLRequest(url: URL(string: "https://example.com/test-upload-async-error")!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        try await XCTAssertThrowsError(
            await createSession()
                .upload(request: request, data: Data(), decoder: decoder)
        )
    }

    func testURLSessionUploadRequestCompletion() {
        let request = URLRequest(url: URL(string: "https://example.com/test-upload-closure")!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        let expectation = XCTestExpectation(description: "test-upload-closure")
        createSession()
            .upload(request: request, data: Data(), decoder: decoder) { result in
                XCTAssertNoThrow({ try result.get() })
                expectation.fulfill()
            }
    }

    func testURLSessionUploadRequestCompletionFailure() {
        let request = URLRequest(url: URL(string: "https://example.com/test-upload-closure-error")!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        let expectation = XCTestExpectation(description: "test-upload-closure-error")
        createSession()
            .upload(request: request, data: Data(), decoder: decoder) { result in
                expectation.fulfill()
            }
    }
}
