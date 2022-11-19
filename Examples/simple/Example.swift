import AppStoreConnect
import ExamplesCore
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@main struct Example {
    static func main() async throws {
        let env = try Environment()

        let keyID = env["ASC_KEY_ID", default: "..."]
        let issuerID = env["ASC_ISSUER_ID", default: "..."]
        let privateKeyPath = env["ASC_PRIVATE_KEY_PATH", default: "..."]
        let privateKey = try Data(contentsOf: URL(filePath: privateKeyPath))
        let client = AppStoreConnectClient(
            authenticator: JWT(
                keyID: keyID,
                issuerID: issuerID,
                expiryDuration: 20 * 60,
                privateKey: privateKey
            )
        )

        let apps = try await client.send(Resources.v1.apps.get())
        print(apps)
    }
}
