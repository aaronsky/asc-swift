import Foundation
import XCTest

@testable import AppStoreConnect

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class TransportTests: XCTestCase {
    private func createSession(request: URLRequest, response: (URLRequest) throws -> Response<Data>) -> URLSession {
        MockURLProtocol.results[request] = Result {
            let resp = try response(request)
            return (resp.data ?? Data(), resp.response)
        }

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]

        return URLSession(configuration: config)
    }

    private class MockURLProtocol: URLProtocol {
        static var results: [URLRequest: Result<(Data, URLResponse), Error>] = [:]

        override class func canInit(with request: URLRequest) -> Bool {
            results.keys.contains(request)
        }

        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }

        override func startLoading() {
            let result = MockURLProtocol.results[request]!
            do {
                let (data, response) = try result.get()
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
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
        _ = try await createSession(request: request, response: MockData.mockingSuccessNoContent(for:))
            .send(request: request, decoder: decoder)
    }

    func testURLSessionSendRequestFailure() async throws {
        let request = URLRequest(url: URL(string: "https://example.com/test-send-async-error")!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        try await XCTAssertThrowsError(
            await createSession(request: request, response: MockData.mockingError(for:))
                .send(request: request, decoder: decoder)
        )
    }

    func testURLSessionSendRequestCompletion() {
        let request = URLRequest(url: URL(string: "https://example.com/test-send-closure")!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        let expectation = XCTestExpectation(description: "test-send-closure")
        createSession(request: request, response: MockData.mockingSuccessNoContent(for:))
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
        createSession(request: request, response: MockData.mockingError(for:))
            .send(request: request, decoder: decoder) { result in
                expectation.fulfill()
            }
    }

    func testURLSessionDownloadRequest() async throws {
        let request = URLRequest(url: URL(string: "https://example.com/test-download-async")!)
        _ = try await createSession(request: request, response: MockData.mockingSuccessNoContent(for:))
            .download(request: request)
    }

    func testURLSessionDownloadRequestFailure() async throws {
        let request = URLRequest(url: URL(string: "https://example.com/test-download-async-error")!)
        try await XCTAssertThrowsError(
            await createSession(request: request, response: MockData.mockingError(for:)).download(request: request)
        )
    }

    func testURLSessionDownloadRequestCompletion() {
        let request = URLRequest(url: URL(string: "https://example.com/test-download-closure")!)
        let expectation = XCTestExpectation(description: "test-download-closure")
        createSession(request: request, response: MockData.mockingSuccessNoContent(for:))
            .download(request: request) { result in
                XCTAssertNoThrow({ try result.get() })
                expectation.fulfill()
            }
    }

    func testURLSessionDownloadRequestCompletionFailure() {
        let request = URLRequest(url: URL(string: "https://example.com/test-download-closure-error")!)
        let expectation = XCTestExpectation(description: "test-download-closure-error")
        createSession(request: request, response: MockData.mockingError(for:))
            .download(request: request) { result in
                expectation.fulfill()
            }
    }

    func testURLSessionUploadRequest() async throws {
        let request = URLRequest(url: URL(string: "https://example.com/test-upload-async")!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        _ = try await createSession(request: request, response: MockData.mockingSuccessNoContent(for:))
            .upload(request: request, data: Data(), decoder: decoder)
    }

    func testURLSessionUploadRequestFailure() async throws {
        let request = URLRequest(url: URL(string: "https://example.com/test-upload-async-error")!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        try await XCTAssertThrowsError(
            await createSession(request: request, response: MockData.mockingError(for:))
                .upload(request: request, data: Data(), decoder: decoder)
        )
    }

    func testURLSessionUploadRequestCompletion() {
        let request = URLRequest(url: URL(string: "https://example.com/test-upload-closure")!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        let expectation = XCTestExpectation(description: "test-upload-closure")
        createSession(request: request, response: MockData.mockingSuccessNoContent(for:))
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
        createSession(request: request, response: MockData.mockingError(for:))
            .upload(request: request, data: Data(), decoder: decoder) { result in
                expectation.fulfill()
            }
    }
}
