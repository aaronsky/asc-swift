import AppStoreConnect
import ArgumentParser
import Foundation
import Utilities

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@main struct RegisterDevice: AsyncParsableCommand {
    @Option var name: String
    @Option var udid: String
    @Option var platform: BundleIDPlatform

    mutating func run() async throws {
        let client = try AppStoreConnectClient(authenticator: EnvAuthenticator())

        let device = try await client.send(
            Resources.v1.devices.post(
                .init(
                    data: .init(
                        attributes: .init(
                            name: name,
                            platform: platform,
                            udid: udid
                        )
                    )
                )
            )
        )

        print(
            "Successfully registered \(device.data.attributes!.name!) (\(device.data.attributes!.model!)) at \(device.data.attributes!.addedDate!)"
        )
    }
}

extension BundleIDPlatform: ExpressibleByArgument {}
