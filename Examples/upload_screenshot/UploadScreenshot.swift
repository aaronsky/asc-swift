import AppStoreAPI
import AppStoreConnect
import ArgumentParser
import Crypto
import Foundation
import Utilities

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

@main struct UploadScreenshot: AsyncParsableCommand {
    enum Platform: String, ExpressibleByArgument {
        case iOS
        case macOS
        case tvOS
        case visionOS
    }

    enum ScreenshotDisplayType: String, ExpressibleByArgument {
        case appIphone67
        case appIphone61
        case appIphone65
        case appIphone58
        case appIphone55
        case appIphone47
        case appIphone40
        case appIphone35
        case appIpadPro3gen129
        case appIpadPro3gen11
        case appIpadPro129
        case appIpad105
        case appIpad97
        case appDesktop
        case appWatchUltra
        case appWatchSeries7
        case appWatchSeries4
        case appWatchSeries3
        case appAppleTv
        case appAppleVisionPro
        case imessageAppIphone67
        case imessageAppIphone61
        case imessageAppIphone65
        case imessageAppIphone58
        case imessageAppIphone55
        case imessageAppIphone47
        case imessageAppIphone40
        case imessageAppIpadPro3gen129
        case imessageAppIpadPro3gen11
        case imessageAppIpadPro129
        case imessageAppIpad105
        case imessageAppIpad97
    }

    @Option var bundleID: String
    @Option var platform: Platform
    @Option var version: String
    @Option var locale: String
    @Option var screenshotType: ScreenshotDisplayType
    @Option(
        name: [.customLong("file"), .customShort("f")],
        completion: .file(),
        transform: URL.init(fileURLWithPath:)
    )
    var screenshotFileURL: URL

    mutating func run() async throws {
        // 0. Open screenshot file for reading
        let screenshotFile = try Data(contentsOf: screenshotFileURL)

        var md5 = Insecure.MD5()
        md5.update(data: screenshotFile)
        let digest = md5.finalize()
        let screenshotFileChecksum = digest.description

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
                    .get(filterPlatform: [.init(platform)], filterVersionString: [version])
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
            // 5. Get all available app screenshot sets from the localization. If a screenshot set for the desired screenshot type already exists, use it. Otherwise, make a new one.
            var screenshotSets: [AppScreenshotSet] = []
            if let related = localization.relationships?.appScreenshotSets?.links?.related {
                let screenshotSetsResponse: AppScreenshotSetsResponse = try await client.send(.get(related))
                screenshotSets.append(
                    contentsOf: screenshotSetsResponse.data.filter {
                        $0.attributes?.screenshotDisplayType == .init(screenshotType)
                    }
                )
            }
            if screenshotSets.isEmpty {
                let newScreenshotSet = try await client.send(
                    Resources.v1.appScreenshotSets.post(
                        .init(
                            data: .init(
                                attributes: .init(screenshotDisplayType: .init(screenshotType)),
                                relationships: .init(
                                    appStoreVersionLocalization: .init(data: .init(id: localization.id))
                                )
                            )
                        )
                    )
                )
                screenshotSets.append(newScreenshotSet.data)
            }

            for screenshotSet in screenshotSets {
                // 6. Reserve an app screenshot in the selected app screenshot set. Tell the API to create a screenshot before uploading the screenshot data.
                print("Reserving space for a new app screenshot.")
                let screenshot =
                    try await client.send(
                        Resources.v1.appScreenshots.post(
                            .init(
                                data: .init(
                                    attributes: .init(
                                        fileSize: screenshotFile.count,
                                        fileName: screenshotFileURL.lastPathComponent
                                    ),
                                    relationships: .init(appScreenshotSet: .init(data: .init(id: screenshotSet.id)))
                                )
                            )
                        )
                    )
                    .data

                guard let uploadOperations = screenshot.attributes?.uploadOperations else { continue }
                print("Uploading \(uploadOperations.count) screenshot components.")

                // 7. Upload each part according to the returned upload operations. The reservation returned uploadOperations, which instructs us how to split the asset into parts. Upload each part individually.
                // Note: To speed up the process, upload multiple parts asynchronously if you have the bandwidth.
                try await withThrowingTaskGroup(of: Void.self) { group in
                    for operation in uploadOperations {
                        group.addTask {
                            try await client.upload(operation: operation, from: screenshotFile)
                        }
                    }
                    try await group.waitForAll()
                }

                // 8. Commit the reservation and provide a checksum. Committing tells App Store Connect the script is finished uploading parts. App Store Connect uses the checksum to ensure the parts were uploaded successfully.
                print("Commit the reservation.")
                _ = try await client.send(
                    Resources.v1.appScreenshots.id(screenshot.id)
                        .patch(
                            .init(
                                data: .init(
                                    id: screenshot.id,
                                    attributes: .init(sourceFileChecksum: screenshotFileChecksum, isUploaded: true)
                                )
                            )
                        )
                )

                // 9. Report success to the caller.
                print(
                    """
                    App Screenshot successfully uploaded to:
                    \(screenshot.links?.this?.absoluteString ?? "<no screenshot url>")
                    You can verify success in App Store Connect or using the API.
                    """
                )
            }
        }
    }
}

extension Resources.V1.Apps.WithID.AppStoreVersions.FilterPlatform {
    init(_ platform: UploadScreenshot.Platform) {
        switch platform {
        case .iOS:
            self = .ios
        case .macOS:
            self = .macOs
        case .tvOS:
            self = .tvOs
        case .visionOS:
            self = .visionOs
        }
    }
}

extension ScreenshotDisplayType {
    init(_ screenshotType: UploadScreenshot.ScreenshotDisplayType) {
        switch screenshotType {
        case .appIphone67:
            self = .appIphone67
        case .appIphone61:
            self = .appIphone61
        case .appIphone65:
            self = .appIphone65
        case .appIphone58:
            self = .appIphone58
        case .appIphone55:
            self = .appIphone55
        case .appIphone47:
            self = .appIphone47
        case .appIphone40:
            self = .appIphone40
        case .appIphone35:
            self = .appIphone35
        case .appIpadPro3gen129:
            self = .appIpadPro3gen129
        case .appIpadPro3gen11:
            self = .appIpadPro3gen11
        case .appIpadPro129:
            self = .appIpadPro129
        case .appIpad105:
            self = .appIpad105
        case .appIpad97:
            self = .appIpad97
        case .appDesktop:
            self = .appDesktop
        case .appWatchUltra:
            self = .appWatchUltra
        case .appWatchSeries7:
            self = .appWatchSeries7
        case .appWatchSeries4:
            self = .appWatchSeries4
        case .appWatchSeries3:
            self = .appWatchSeries3
        case .appAppleTv:
            self = .appAppleTv
        case .appAppleVisionPro:
            self = .appAppleVisionPro
        case .imessageAppIphone67:
            self = .imessageAppIphone67
        case .imessageAppIphone61:
            self = .imessageAppIphone61
        case .imessageAppIphone65:
            self = .imessageAppIphone65
        case .imessageAppIphone58:
            self = .imessageAppIphone58
        case .imessageAppIphone55:
            self = .imessageAppIphone55
        case .imessageAppIphone47:
            self = .imessageAppIphone47
        case .imessageAppIphone40:
            self = .imessageAppIphone40
        case .imessageAppIpadPro3gen129:
            self = .imessageAppIpadPro3gen129
        case .imessageAppIpadPro3gen11:
            self = .imessageAppIpadPro3gen11
        case .imessageAppIpadPro129:
            self = .imessageAppIpadPro129
        case .imessageAppIpad105:
            self = .imessageAppIpad105
        case .imessageAppIpad97:
            self = .imessageAppIpad97
        }
    }
}
