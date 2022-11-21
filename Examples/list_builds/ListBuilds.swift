import AppStoreConnect
import ArgumentParser
import Foundation
import Utilities

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@main struct ListBuilds: AsyncParsableCommand {
    @Option var bundleID: String

    mutating func run() async throws {
        let client = try AppStoreConnectClient(authenticator: EnvAuthenticator())

        let app = try await client
            .send(
                Resources.v1.apps.get(
                    filterBundleID: [bundleID]
                )
            )
            .data.first!

        for try await builds in await client.pages(Resources.v1.builds.get(filterApp: [app.id])) {
            for build in builds.data {
                print(build.attributes!.version!)
            }
        }
    }
}
