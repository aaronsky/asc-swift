import Foundation
import XCTest

@testable import AppStoreConnect

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

final class RequestTests: XCTestCase {
    func testURLRequestInitRequest() throws {
        let baseURL = API.appStoreConnect.baseURL
        let mockBody = MockResources.Body(name: "test3", age: 88)
        let encoder = JSONEncoder()
        var mockAuthenticator: Authenticator = MockAuthenticator()

        let request = Request<MockResources.Content>
            .post("test", body: mockBody, headers: ["Test": "test"])
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
        let decoder = JSONDecoder()
        let requestBody = try decoder.decode(MockResources.Body.self, from: XCTUnwrap(urlRequest.httpBody))
        XCTAssertEqual(requestBody, mockBody)
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
