import Foundation
import XCTest

@testable import AppStoreConnect

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

// This file contains key that I generated solely for mocking purposes. None of these are
// real secrets. If you need to regenerate any of these keys, run this openssl command in a shell
// and copy the contents of key.pem to the string:
//
//   openssl ecparam -name prime256v1 -genkey -noout | openssl pkcs8 -topk8 -nocrypt -out key.pem
//
// This will generate the ASN.1 PKCS#8 representation of the private key needed
// to create a valid token. If you are looking at this test to see how to make a key,
// reference Apple's documentation on this subject instead.
//
// https://developer.apple.com/documentation/appstoreconnectapi/creating_api_keys_for_app_store_connect_api

final class JWTTests: XCTestCase {
    func testToken() throws {
        var jwt = try JWT(
            keyID: "TEST",
            issuerID: "TEST",
            expiryDuration: 20 * 60, // 20 minutes
            privateKey: .init(
                pemRepresentation: """
                -----BEGIN PRIVATE KEY-----
                MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQgg2wUxVlKtf88twNw
                86ZrWxuzZtwOeYylHJsF4mPE4qOhRANCAAS/zi5KmzpwSba4j3y/LjgkC7hzOmez
                gNlQxzOA98JVvq0k3iE3UtY0mBovKEW2T30AQ5VXhZh011wFgfze1xBx
                -----END PRIVATE KEY-----
                """
            ),
            date: { Date(timeIntervalSince1970: 1000) }
        )

        let token = try jwt.token()
        let components = token.components(separatedBy: ".")
        XCTAssertEqual(components.count, 3)

        let cachedToken = try jwt.token()
        XCTAssertEqual(cachedToken, token)
    }

    func testTokenBadPEM() throws {
        XCTAssertThrowsError(
            try JWT(
                keyID: "TEST",
                issuerID: "TEST",
                expiryDuration: 20 * 60, // 20 minutes
                privateKey: .init(
                    pemRepresentation: "TEST"
                ),
                date: { Date(timeIntervalSince1970: 1000) }
            )
        )
    }
}
