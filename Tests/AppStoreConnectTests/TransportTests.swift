#if canImport(Testing)
    import Foundation
    import Mocks
    import Testing

    @testable import AppStoreConnect

    #if canImport(FoundationNetworking)
        import FoundationNetworking
    #endif

    struct TransportTests {
        let session: URLSession

        init() {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [MockURLProtocol.self]
            session = URLSession(configuration: configuration)
        }

        @Test func urlSessionSendRequest() async throws {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
            _ = try await session.send(request: .testSendAsync, decoder: decoder)
        }

        @Test func urlSessionSendRequestFailure() async throws {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
            await #expect(throws: (any Error).self) {
                try await session.send(request: .testSendAsyncError, decoder: decoder)
            }
        }

        @Test func urlSessionSendRequestCompletion() async throws {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
            await confirmation("test-send-closure") { fulfill in
                session.send(request: .testSendClosure, decoder: decoder) { result in
                    #expect(throws: Never.self) { try result.get() }
                    fulfill()
                }
            }
        }

        @Test func urlSessionSendRequestCompletionFailure() {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
            await confirmation("test-send-closure-error") { fulfill in
                session.send(request: .testSendClosureError, decoder: decoder) { result in
                    fulfill()
                }
            }
        }

        @Test func urlSessionDownloadRequest() async throws {
            _ = try await session.download(request: .testDownloadAsync)
        }

        @Test func urlSessionDownloadRequestFailure() async throws {
            await #expect(throws: (any Error).self) {
                try await session.download(request: .testDownloadAsyncError)
            }
        }

        @Test func urlSessionDownloadRequestCompletion() {
            await confirmation("test-download-closure") { fulfill in
                session.download(request: .testDownloadClosure) { result in
                    #expect(throws: Never.self) { try result.get() }
                    fulfill()
                }
            }
        }

        @Test func urlSessionDownloadRequestCompletionFailure() {
            await confirmation("test-download-closure-error") { fulfill in
                session.download(request: .testDownloadClosureError) { result in
                    fulfill()
                }
            }
        }

        @Test func urlSessionUploadRequest() async throws {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
            _ = try await session.upload(request: .testUploadAsync, data: Data(), decoder: decoder)
        }

        @Test func urlSessionUploadRequestFailure() async throws {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
            await #expect(throws: (any Error).self) {
                try await session.upload(request: .testUploadAsyncError, data: Data(), decoder: decoder)
            }
        }

        @Test func urlSessionUploadRequestCompletion() {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
            await confirmation("test-upload-closure") { fulfill in
                session.upload(request: .testUploadClosure, data: Data(), decoder: decoder) { result in
                    #expect(throws: Never.self) { try result.get() }
                    fulfill()
                }
            }
        }

        @Test func urlSessionUploadRequestCompletionFailure() {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom(decodeISO8601Date(with:))
            await confirmation("test-upload-closure-error") { fulfill in
                session.upload(request: .testUploadClosureError, data: Data(), decoder: decoder) { result in
                    fulfill()
                }
            }
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
    }

    extension URLRequest {
        fileprivate init?(string urlString: String) {
            guard let url = URL(string: urlString) else { return nil }

            self.init(url: url)
        }

        fileprivate static var testSendAsync: Self { .init(string: "https://example.com/test-send-async")! }
        fileprivate static var testSendAsyncError: Self { .init(string: "https://example.com/test-send-async-error")! }
        fileprivate static var testSendClosure: Self { .init(string: "https://example.com/test-send-closure")! }
        fileprivate static var testSendClosureError: Self {
            .init(string: "https://example.com/test-send-closure-error")!
        }
        fileprivate static var testDownloadAsync: Self { .init(string: "https://example.com/test-download-async")! }
        fileprivate static var testDownloadAsyncError: Self {
            .init(string: "https://example.com/test-download-async-error")!
        }
        fileprivate static var testDownloadClosure: Self { .init(string: "https://example.com/test-download-closure")! }
        fileprivate static var testDownloadClosureError: Self {
            .init(string: "https://example.com/test-download-closure-error")!
        }
        fileprivate static var testUploadAsync: Self { .init(string: "https://example.com/test-upload-async")! }
        fileprivate static var testUploadAsyncError: Self {
            .init(string: "https://example.com/test-upload-async-error")!
        }
        fileprivate static var testUploadClosure: Self { .init(string: "https://example.com/test-upload-closure")! }
        fileprivate static var testUploadClosureError: Self {
            .init(string: "https://example.com/test-upload-closure-error")!
        }
    }
#endif
