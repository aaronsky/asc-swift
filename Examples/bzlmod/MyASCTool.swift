import AppStoreAPI
import AppStoreConnect
import EnterpriseAPI
import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

@main
public struct MyASCTool {
    static func main() async throws {
        let client = try AppStoreConnectClient(
            authenticator: JWT(
                keyID: "...",
                issuerID: "...",
                expiryDuration: 20 * 60, // 20 minutes
                privateKey: JWT.PrivateKey(contentsOf: URL(filePath: "..."))
            )
        )

        let apps = try await client.send(Resources.v1.apps.get())

        print(apps)
    }
}