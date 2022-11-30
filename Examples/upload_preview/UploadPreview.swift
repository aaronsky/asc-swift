import AppStoreConnect
import ArgumentParser
import Crypto
import Foundation
import Utilities

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@main struct UploadPreview: AsyncParsableCommand {
    @Option var bundleID: String
    @Option var platform: Resources.V1.Apps.WithID.AppStoreVersions.FilterPlatform
    @Option var version: String
    @Option var locale: String
    @Option var previewType: PreviewType
    @Option(
        name: [.customLong("file"), .customShort("f")],
        completion: .file(),
        transform: URL.init(fileURLWithPath:)
    )
    var previewFileURL: URL

    mutating func run() async throws {
        // 0. Open preview file for reading
        let previewFile = try Data(contentsOf: previewFileURL)

        var md5 = Insecure.MD5()
        md5.update(data: previewFile)
        let digest = md5.finalize()
        let previewFileChecksum = digest.description

        // 1. Create the App Store Connect client
        let client = try AppStoreConnectClient(authenticator: EnvAuthenticator())

        // 2. Look up the app by bundle ID.
        let app = try await client
            .send(
                Resources.v1.apps.get(
                    filterBundleID: [bundleID]
                )
            )
            .data.first!

        // 3. Look up the version version by platform and version number.
        let version = try await client
            .send(
                Resources.v1.apps.id(app.id).appStoreVersions
                    .get(filterPlatform: [platform], filterVersionString: [version])
            )
            .data.first!

        // 4. Get all localizations for the version and look for the requested locale.
        let localizations: [AppStoreVersionLocalization]
        let existingLocalizations =
            try await client.send(Resources.v1.appStoreVersions.id(version.id).appStoreVersionLocalizations.get()).data
            .filter { $0.attributes?.locale == locale }
        // 4a. If the requested localization does not exist, create it. Localized attributes are copied from the primary locale so there's no need to worry about them here.
        if existingLocalizations.isEmpty {
            let newLocalization = try await client.send(
                Resources.v1.appStoreVersionLocalizations.post(
                    .init(
                        data: .init(
                            attributes: .init(locale: locale),
                            relationships: .init(appStoreVersion: .init(data: .init(id: version.id)))
                        )
                    )
                )
            )
            localizations = [newLocalization.data]
        } else {
            localizations = existingLocalizations
        }

        for localization in localizations {
            // 5. Get all available app preview sets from the localization. If a preview set for the desired preview type already exists, use it. Otherwise, make a new one.
            var previewSets: [AppPreviewSet] = []
            if let related = localization.relationships?.appPreviewSets?.links?.related {
                let previewSetsResponse: AppPreviewSetsResponse = try await client.send(.get(related))
                previewSets.append(
                    contentsOf: previewSetsResponse.data.filter { $0.attributes?.previewType == previewType }
                )
            }
            if previewSets.isEmpty {
                let newPreviewSet = try await client.send(
                    Resources.v1.appPreviewSets.post(
                        .init(
                            data: .init(
                                attributes: .init(previewType: previewType),
                                relationships: .init(
                                    appStoreVersionLocalization: .init(data: .init(id: localization.id))
                                )
                            )
                        )
                    )
                )
                previewSets.append(newPreviewSet.data)
            }

            for previewSet in previewSets {
                // 6. Reserve an app preview in the selected app preview set. Tell the API to create a preview before uploading the preview data.
                print("Reserving space for a new app preview.")
                let preview =
                    try await client.send(
                        Resources.v1.appPreviews.post(
                            .init(
                                data: .init(
                                    attributes: .init(
                                        fileSize: previewFile.count,
                                        fileName: previewFileURL.lastPathComponent
                                    ),
                                    relationships: .init(appPreviewSet: .init(data: .init(id: previewSet.id)))
                                )
                            )
                        )
                    )
                    .data

                guard let uploadOperations = preview.attributes?.uploadOperations else { continue }
                print("Uploading \(uploadOperations.count) preview components.")

                // 7. Upload each part according to the returned upload operations. The reservation returned uploadOperations, which instructs us how to split the asset into parts. Upload each part individually.
                // Note: To speed up the process, upload multiple parts asynchronously if you have the bandwidth.
                try await withThrowingTaskGroup(of: Void.self) { group in
                    for operation in uploadOperations {
                        group.addTask {
                            try await client.upload(operation: operation, from: previewFile)
                        }
                    }
                    try await group.waitForAll()
                }

                // 8. Commit the reservation and provide a checksum. Committing tells App Store Connect the script is finished uploading parts. App Store Connect uses the checksum to ensure the parts were uploaded successfully.
                print("Commit the reservation.")
                _ = try await client.send(
                    Resources.v1.appPreviews.id(preview.id)
                        .patch(
                            .init(
                                data: .init(
                                    id: preview.id,
                                    attributes: .init(sourceFileChecksum: previewFileChecksum, isUploaded: true)
                                )
                            )
                        )
                )

                // 9. Report success to the caller.
                print(
                    """
                    App Preview successfully uploaded to:
                    \(preview.links.this)
                    You can verify success in App Store Connect or using the API.
                    """
                )
            }
        }
    }
}

extension Resources.V1.Apps.WithID.AppStoreVersions.FilterPlatform: ExpressibleByArgument {}
extension PreviewType: ExpressibleByArgument {}
