import Foundation
import XCTest

@testable import AppStoreConnect

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@MainActor
class TransportTests: XCTestCase {
    private func createSession(testCase: MockURLProtocol.Case = .success, request: URLRequest) -> URLSession {
        MockURLProtocol.results[request] = Result { try testCase.performRequest(request) }

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]

        return URLSession(configuration: config)
    }

    private class MockURLProtocol: URLProtocol {
        enum Case: Hashable {
            case success
            case error

            func performRequest(_ request: URLRequest) throws -> (Data, URLResponse) {
                switch self {
                case .success:
                    let resp = MockData.mockingSuccessNoContent(for: request)
                    return (resp.data ?? Data(), resp.response)
                case .error:
                    let resp = try MockData.mockingError(for: request)
                    return (resp.data ?? Data(), resp.response)
                }
            }
        }

        typealias RequestHandler = (URLRequest) throws -> (Data, URLResponse)
        static var results: [URLRequest: Result<(Data, URLResponse), Error>] = [:]

        override class func canInit(with request: URLRequest) -> Bool {
            results.keys.contains(request)
        }

        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }

        override func startLoading() {
            DispatchQueue.global().async {
                do {
                    let (data, response) = try MockURLProtocol.results[self.request]!.get()
                    self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                    self.client?.urlProtocol(self, didLoad: data)
                    self.client?.urlProtocolDidFinishLoading(self)
                } catch {
                    self.client?.urlProtocol(self, didFailWithError: error)
                }
            }
        }

        override func stopLoading() {}
    }

    func testURLSessionSendRequest() async throws {
        let request = URLRequest(url: URL())
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        _ = try await createSession(request: request).send(request: request, decoder: decoder)
    }

    func testURLSessionSendRequestFailure() async throws {
        let request = URLRequest(url: URL())
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        try await XCTAssertThrowsError(
            await createSession(testCase: .error, request: request).send(request: request, decoder: decoder)
        )
    }

    func testURLSessionSendRequestClosure() {
        let request = URLRequest(url: URL())
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        let expectation = XCTestExpectation(description: "send request")
        createSession(request: request)
            .send(request: request, decoder: decoder) { result in
                DispatchQueue.main.async {
                    XCTAssertNoThrow({ try result.get() })
                    expectation.fulfill()
                }
            }
    }

    func testURLSessionSendRequestClosureFailure() {
        let request = URLRequest(url: URL())
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        let expectation = XCTestExpectation(description: "send request")
        createSession(testCase: .error, request: request)
            .send(request: request, decoder: decoder) { result in
                DispatchQueue.main.async {
                    XCTAssertThrowsError({ try result.get() })
                    expectation.fulfill()
                }
            }
    }

    func testURLSessionDownloadRequest() async throws {
        let request = URLRequest(url: URL())
        _ = try await createSession(request: request).download(request: request)
    }

    func testURLSessionDownloadRequestFailure() async throws {
        let request = URLRequest(url: URL())
        try await XCTAssertThrowsError(
            await createSession(testCase: .error, request: request).download(request: request)
        )
    }

    func testURLSessionDownloadRequestClosure() {
        let request = URLRequest(url: URL())
        let expectation = XCTestExpectation(description: "download request")
        createSession(request: request)
            .download(request: request) { result in
                XCTAssertNoThrow({ try result.get() })
                expectation.fulfill()
            }
    }

    func testURLSessionDownloadRequestClosureFailure() {
        let request = URLRequest(url: URL())
        let expectation = XCTestExpectation(description: "download request")
        createSession(testCase: .error, request: request)
            .download(request: request) { result in
                DispatchQueue.main.async {
                    XCTAssertThrowsError({ try result.get() })
                    expectation.fulfill()
                }
            }
    }

    func testURLSessionUploadRequest() async throws {
        let request = URLRequest(url: URL())
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        _ = try await createSession(request: request).upload(request: request, data: Data(), decoder: decoder)
    }

    func testURLSessionUploadRequestFailure() async throws {
        let request = URLRequest(url: URL())
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        try await XCTAssertThrowsError(
            await createSession(testCase: .error, request: request).upload(request: request, data: Data(), decoder: decoder)
        )
    }

    func testURLSessionUploadRequestClosure() {
        let request = URLRequest(url: URL())
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        let expectation = XCTestExpectation(description: "upload request")
        createSession(request: request)
            .upload(request: request, data: Data(), decoder: decoder) { result in
                DispatchQueue.main.async {
                    XCTAssertNoThrow({ try result.get() })
                    expectation.fulfill()
                }
            }
    }

    func testURLSessionUploadRequestClosureFailure() {
        let request = URLRequest(url: URL())
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        let expectation = XCTestExpectation(description: "upload request")
        createSession(testCase: .error, request: request)
            .upload(request: request, data: Data(), decoder: decoder) { result in
                DispatchQueue.main.async {
                    XCTAssertThrowsError({ try result.get() })
                    expectation.fulfill()
                }
            }
    }
}
