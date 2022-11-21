import Foundation
import XCTest

@testable import AppStoreConnect

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class TransportTests: XCTestCase {
    private func createSession(testCase: MockURLProtocol.Case = .success) -> URLSession {
        MockURLProtocol.requestHandler = testCase.requestHandler

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]

        return URLSession(configuration: config)
    }

    private class MockURLProtocol: URLProtocol {
        enum Case {
            case success
            case error

            var requestHandler: RequestHandler {
                { request in
                    let resp: Response<Data>
                    switch self {
                    case .success:
                        resp = MockData.mockingSuccessNoContent(for: request)
                    case .error:
                        resp = try MockData.mockingError(for: request)
                    }
                    return (resp.data ?? Data(), resp.response)
                }
            }
        }

        typealias RequestHandler = (URLRequest) throws -> (Data, URLResponse)
        static var requestHandler: RequestHandler?

        override class func canInit(with request: URLRequest) -> Bool {
            return true
        }

        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }

        override func startLoading() {
            guard let handler = MockURLProtocol.requestHandler else {
                return
            }
            do {
                let (data, response) = try handler(request)
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocolDidFinishLoading(self)
            } catch {
                client?.urlProtocol(self, didFailWithError: error)
            }
        }

        override func stopLoading() {}
    }
}

// MARK: - Async/Await-based Requests

extension TransportTests {
    func testURLSessionSendRequest() async throws {
        let request = URLRequest(url: URL())
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        _ = try await createSession().send(request: request, decoder: decoder)
    }

    func testURLSessionSendRequestFailure() async {
        let request = URLRequest(url: URL())
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        try await XCTAssertThrowsError(
            await createSession(testCase: .error).send(request: request, decoder: decoder)
        )
    }

    func testURLSessionDownloadRequest() async throws {
        let request = URLRequest(url: URL())
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        _ = try await createSession().download(request: request)
    }

    func testURLSessionDownloadRequestFailure() async {
        let request = URLRequest(url: URL())
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        try await XCTAssertThrowsError(
            await createSession(testCase: .error).download(request: request)
        )
    }

    func testURLSessionUploadRequest() async throws {
        let request = URLRequest(url: URL())
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        _ = try await createSession().upload(request: request, data: Data(), decoder: decoder)
    }

    func testURLSessionUploadRequestFailure() async {
        let request = URLRequest(url: URL())
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
        try await XCTAssertThrowsError(
            await createSession(testCase: .error).upload(request: request, data: Data(), decoder: decoder)
        )
    }
}
