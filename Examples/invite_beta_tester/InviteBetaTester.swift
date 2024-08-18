import AppStoreAPI
import AppStoreConnect
import ArgumentParser
import Foundation
import Utilities

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

@main struct InviteBetaTester: AsyncParsableCommand {
    enum UserRole: String, ExpressibleByArgument {
        case admin
        case finance
        case accountHolder
        case sales
        case marketing
        case appManager
        case developer
        case accessToReports
        case customerSupport
        case createApps
        case cloudManagedDeveloperID
        case cloudManagedAppDistribution
        case generateIndividualKeys
    }

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

extension UserRole {
    init(_ role: InviteBetaTester.UserRole) {
        switch role {
        case .admin:
            self = .admin
        case .finance:
            self = .finance
        case .accountHolder:
            self = .accountHolder
        case .sales:
            self = .sales
        case .marketing:
            self = .marketing
        case .appManager:
            self = .appManager
        case .developer:
            self = .developer
        case .accessToReports:
            self = .accessToReports
        case .customerSupport:
            self = .customerSupport
        case .createApps:
            self = .createApps
        case .cloudManagedDeveloperID:
            self = .cloudManagedDeveloperID
        case .cloudManagedAppDistribution:
            self = .cloudManagedAppDistribution
        case .generateIndividualKeys:
            self = .generateIndividualKeys
        }
    }
}
