import Foundation
import XCTest

@testable import AppStoreConnect

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class RequestTests: XCTestCase {
    func testURLRequestInitRequest() throws {
        let baseURL = URL()
        let mockBody = MockResources.Body(name: "test3", age: 88)
        let encoder = JSONEncoder()
        let mockBodyEncoded = try encoder.encode(mockBody)
        var mockAuthenticator: Authenticator = MockAuthenticator()

        let request = Request<MockResources.Content>
            .post("test", baseURL: baseURL, body: mockBody, headers: ["Test": "test"])
        let urlRequest = try URLRequest(request: request, encoder: encoder, authenticator: &mockAuthenticator)
        XCTAssertEqual(urlRequest.url, baseURL.appendingPathComponent("test"))
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertEqual(
            urlRequest.allHTTPHeaderFields,
            [
                "Authorization": "Bearer TEST",
                "Content-Type": "application/json",
                "Test": "test",
            ]
        )
        XCTAssertEqual(urlRequest.httpBody, mockBodyEncoded)
    }

    func testURLRequestInitUploadOperation() throws {
        let encoder = JSONEncoder()
        var mockAuthenticator: Authenticator = MockAuthenticator()

        let goodUploadOperation = UploadOperation(
            method: "GET",
            url: "test",
            length: 64,
            offset: 0,
            requestHeaders: [
                .init(name: "Test", value: "test"),
                .init(name: "Test2", value: nil),
            ]
        )
        let goodUploadOperationNoHeaders = UploadOperation(
            method: "GET",
            url: "test",
            length: 64,
            offset: 0,
            requestHeaders: [
                .init(name: nil, value: "test")
            ]
        )
        let badUploadOperation = UploadOperation()

        let goodRequest = try URLRequest(
            uploadOperation: goodUploadOperation,
            encoder: encoder,
            authenticator: &mockAuthenticator
        )
        XCTAssertEqual(
            goodRequest.allHTTPHeaderFields,
            [
                "Authorization": "Bearer TEST",
                "Test": "test",
            ]
        )

        let goodRequestNoHeaders = try URLRequest(
            uploadOperation: goodUploadOperationNoHeaders,
            encoder: encoder,
            authenticator: &mockAuthenticator
        )
        XCTAssertEqual(
            goodRequestNoHeaders.allHTTPHeaderFields,
            ["Authorization": "Bearer TEST"]
        )

        XCTAssertThrowsError(
            try URLRequest(
                uploadOperation: badUploadOperation,
                encoder: encoder,
                authenticator: &mockAuthenticator
            )
        ) { error in
            XCTAssertEqual(
                error as? UploadOperation.Error,
                UploadOperation.Error.missingDestination(
                    url: nil,
                    method: nil
                )
            )
        }
    }

    func testRequestShorthandMethods() {
        XCTAssertEqual(Request<Void>.get("test").method, "GET")
        XCTAssertEqual(Request<Void>.get(URL()).method, "GET")
        XCTAssertEqual(Request<Void>.post("test").method, "POST")
        XCTAssertEqual(Request<Void>.post(URL()).method, "POST")
        XCTAssertEqual(Request<Void>.put("test").method, "PUT")
        XCTAssertEqual(Request<Void>.put(URL()).method, "PUT")
        XCTAssertEqual(Request<Void>.patch("test").method, "PATCH")
        XCTAssertEqual(Request<Void>.patch(URL()).method, "PATCH")
        XCTAssertEqual(Request<Void>.delete("test").method, "DELETE")
        XCTAssertEqual(Request<Void>.delete(URL()).method, "DELETE")
        XCTAssertEqual(Request<Void>.options("test").method, "OPTIONS")
        XCTAssertEqual(Request<Void>.options(URL()).method, "OPTIONS")
        XCTAssertEqual(Request<Void>.head("test").method, "HEAD")
        XCTAssertEqual(Request<Void>.head(URL()).method, "HEAD")
        XCTAssertEqual(Request<Void>.trace("test").method, "TRACE")
        XCTAssertEqual(Request<Void>.trace(URL()).method, "TRACE")
    }
}
