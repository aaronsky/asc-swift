import Foundation
import Mocks
import Testing

@testable import AppStoreConnect

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

@Test func urlRequestInitRequest() throws {
    let baseURL = API.appStoreConnect.baseURL
    let mockBody = MockResources.Body(name: "test3", age: 88)
    let encoder = JSONEncoder()
    var mockAuthenticator: any Authenticator = MockAuthenticator()

    let request = Request<MockResources.Content>
        .post("test", body: mockBody, headers: ["Test": "test"])
    let urlRequest = try URLRequest(request: request, encoder: encoder, authenticator: &mockAuthenticator)
    #expect(urlRequest.url == baseURL.appendingPathComponent("test"))
    #expect(urlRequest.httpMethod == "POST")
    #expect(
        urlRequest.allHTTPHeaderFields == [
            "Authorization": "Bearer TEST",
            "Content-Type": "application/json",
            "Test": "test",
        ]
    )
    let decoder = JSONDecoder()
    let requestBody = try decoder.decode(MockResources.Body.self, from: #require(urlRequest.httpBody))
    #expect(requestBody == mockBody)
}

@Test func requestShorthandMethods() {
    #expect(Request<Void>.get("test").method == "GET")
    #expect(Request<Void>.get(URL()).method == "GET")
    #expect(Request<Void>.post("test").method == "POST")
    #expect(Request<Void>.post(URL()).method == "POST")
    #expect(Request<Void>.put("test").method == "PUT")
    #expect(Request<Void>.put(URL()).method == "PUT")
    #expect(Request<Void>.patch("test").method == "PATCH")
    #expect(Request<Void>.patch(URL()).method == "PATCH")
    #expect(Request<Void>.delete("test").method == "DELETE")
    #expect(Request<Void>.delete(URL()).method == "DELETE")
    #expect(Request<Void>.options("test").method == "OPTIONS")
    #expect(Request<Void>.options(URL()).method == "OPTIONS")
    #expect(Request<Void>.head("test").method == "HEAD")
    #expect(Request<Void>.head(URL()).method == "HEAD")
    #expect(Request<Void>.trace("test").method == "TRACE")
    #expect(Request<Void>.trace(URL()).method == "TRACE")
}
