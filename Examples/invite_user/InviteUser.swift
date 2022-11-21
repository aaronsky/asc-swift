import AppStoreConnect
import ArgumentParser
import Foundation
import Utilities

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@main struct InviteUser: AsyncParsableCommand {
    @Option var lastName: String
    @Option var firstName: String
    @Option var email: String
    @Option var roles: [UserRole] = []
    @Flag var allAppsVisible = false
    @Flag var provisioningAllowed = false
    @Flag var cancel = false

    mutating func run() async throws {
        let client = try AppStoreConnectClient(authenticator: EnvAuthenticator())

        if cancel {
            try await cancelUserInvitation(client)
        } else {
            try await inviteUser(client)
        }
    }

    private func inviteUser(_ client: AppStoreConnectClient) async throws {
        let invitation = try await client.send(
            Resources.v1.userInvitations.post(
                .init(
                    data: .init(
                        type: .userInvitations,
                        attributes: .init(
                            email: email,
                            firstName: firstName,
                            lastName: lastName,
                            roles: roles
                        )
                    )
                )
            )
        )

        print(
            "Sent an invitation to \(localizedName(firstName: invitation.data.attributes?.firstName, lastName: invitation.data.attributes?.lastName)) at \(invitation.data.attributes!.email!). They should check their email and confirm the invitation before it expires at \(invitation.data.attributes!.expirationDate!)."
        )
    }

    private func cancelUserInvitation(_ client: AppStoreConnectClient) async throws {
        let invitations = try await client.send(Resources.v1.userInvitations.get(filterEmail: [email]))
        let invitation = invitations.data.first!

        try await client.send(Resources.v1.userInvitations.id(invitation.id).delete)

        print(
            "Cancelled the invitation issued for \(localizedName(firstName: invitation.attributes?.firstName, lastName: invitation.attributes?.lastName)) at \(invitation.attributes!.email!)"
        )
    }

    private func localizedName(firstName: String?, lastName: String?) -> String {
        let nameFormatter = PersonNameComponentsFormatter()
        var nameComponents = PersonNameComponents()
        nameComponents.givenName = firstName
        nameComponents.familyName = lastName
        return nameFormatter.string(from: nameComponents)
    }
}

extension UserRole: ExpressibleByArgument {}
