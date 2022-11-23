import AppStoreConnect
import ArgumentParser
import Foundation
import Utilities

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@main struct InviteBetaTester: AsyncParsableCommand {
    @Option var lastName: String?
    @Option var firstName: String?
    @Option var email: String
    @Option var bundleIDs: [String] = []

    mutating func run() async throws {
        if bundleIDs.isEmpty {
            throw ValidationError("Please provide at least one bundle ID to add a tester to.")
        }

        let client = try AppStoreConnectClient(authenticator: EnvAuthenticator())

        let apps = try await client.send(Resources.v1.apps.get(filterBundleID: bundleIDs)).data

        let testers: [BetaTester]
        let existingTesters = try await client.send(Resources.v1.betaTesters.get(filterEmail: [email]))
        if existingTesters.data.isEmpty {
            let tester = try await client.send(
                Resources.v1.betaTesters.post(
                    .init(
                        data: .init(
                            attributes: .init(
                                firstName: firstName,
                                lastName: lastName,
                                email: email
                            )
                        )
                    )
                )
            )

            testers = [tester.data]
        } else {
            testers = existingTesters.data
        }

        for tester in testers {
            for app in apps {
                _ = try await client.send(
                    Resources.v1.betaTesterInvitations.post(
                        .init(
                            data: .init(
                                relationships: .init(
                                    betaTester: .init(data: .init(id: tester.id)),
                                    app: .init(data: .init(id: app.id))
                                )
                            )
                        )
                    )
                )

                print(
                    "Sent an invitation to \(tester.attributes!.firstName!) \(tester.attributes!.lastName!) at \(tester.attributes!.email!)."
                )
            }
        }
    }
}

extension UserRole: ExpressibleByArgument {}
