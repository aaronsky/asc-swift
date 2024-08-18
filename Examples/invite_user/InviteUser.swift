import AppStoreAPI
import AppStoreConnect
import ArgumentParser
import EnterpriseAPI
import Foundation
import Utilities

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

@main struct InviteUser: AsyncParsableCommand {
    enum API: String, ExpressibleByArgument {
        case appStore
        case enterprise
    }

    enum UserRole: String, ExpressibleByArgument {
        case admin
        case accountHolder
        case developer
    }

    @Option var api: API = .appStore
    @Option var lastName: String
    @Option var firstName: String
    @Option var email: String
    @Option var roles: [UserRole] = []
    @Flag var allAppsVisible = false
    @Flag var provisioningAllowed = false
    @Flag var cancel = false

    mutating func run() async throws {
        let api: AppStoreConnect.API
        switch self.api {
        case .appStore:
            api = .appStoreConnect
        case .enterprise:
            api = .enterpriseProgram
        }
        let client = try AppStoreConnectClient(authenticator: EnvAuthenticator(api: api))

        if cancel {
            try await cancelUserInvitation(client)
        } else {
            try await inviteUser(client)
        }
    }

    private func inviteUser(_ client: AppStoreConnectClient) async throws {
        switch api {
        case .appStore:
            try await inviteAppStoreUser(client)
        case .enterprise:
            try await inviteEnterpriseUser(client)
        }
    }

    private func inviteAppStoreUser(_ client: AppStoreConnectClient) async throws {
        let invitation = try await client.send(
            AppStoreAPI.Resources.v1.userInvitations.post(
                .init(
                    data: .init(
                        attributes: .init(
                            email: email,
                            firstName: firstName,
                            lastName: lastName,
                            roles: roles.compactMap(AppStoreAPI.UserRole.init)
                        )
                    )
                )
            )
        )

        print(
            "Sent an invitation to \(invitation.data.attributes!.firstName!) \(invitation.data.attributes!.lastName!) at \(invitation.data.attributes!.email!). They should check their email and confirm the invitation before it expires at \(invitation.data.attributes!.expirationDate!)."
        )
    }

    private func inviteEnterpriseUser(_ client: AppStoreConnectClient) async throws {
        let invitation = try await client.send(
            EnterpriseAPI.Resources.userInvitations.post(
                .init(
                    data: .init(
                        attributes: .init(
                            email: email,
                            firstName: firstName,
                            lastName: lastName,
                            roles: roles.compactMap(EnterpriseAPI.UserRole.init)
                        )
                    )
                )
            )
        )

        print(
            "Sent an invitation to \(invitation.data.attributes!.firstName!) \(invitation.data.attributes!.lastName!) at \(invitation.data.attributes!.email!). They should check their email and confirm the invitation before it expires at \(invitation.data.attributes!.expirationDate!)."
        )
    }

    private func cancelUserInvitation(_ client: AppStoreConnectClient) async throws {
        switch api {
        case .appStore:
            try await cancelAppStoreUserInvitation(client)
        case .enterprise:
            try await cancelEnterpriseUserInvitation(client)
        }
    }

    private func cancelAppStoreUserInvitation(_ client: AppStoreConnectClient) async throws {
        let invitations = try await client.send(AppStoreAPI.Resources.v1.userInvitations.get(filterEmail: [email]))
        let invitation = invitations.data.first!

        try await client.send(AppStoreAPI.Resources.v1.userInvitations.id(invitation.id).delete)

        print(
            "Cancelled the invitation issued for \(invitation.attributes!.firstName!) \(invitation.attributes!.lastName!) at \(invitation.attributes!.email!)"
        )
    }

    private func cancelEnterpriseUserInvitation(_ client: AppStoreConnectClient) async throws {
        let invitations = try await client.send(EnterpriseAPI.Resources.userInvitations.get(filterEmail: [email]))
        let invitation = invitations.data.first!

        try await client.send(EnterpriseAPI.Resources.userInvitations.id(invitation.id).delete)

        print(
            "Cancelled the invitation issued for \(invitation.attributes!.firstName!) \(invitation.attributes!.lastName!) at \(invitation.attributes!.email!)"
        )
    }
}

extension AppStoreAPI.UserRole {
    init?(_ role: InviteUser.UserRole) {
        switch role {
        case .admin:
            self = .admin
        case .accountHolder:
            self = .accountHolder
        case .developer:
            self = .developer
        }
    }
}

extension EnterpriseAPI.UserRole {
    init?(_ role: InviteUser.UserRole) {
        switch role {
        case .admin:
            self = .admin
        case .accountHolder:
            self = .accountHolder
        case .developer:
            self = .developer
        }
    }
}
