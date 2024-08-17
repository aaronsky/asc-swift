import Foundation
import PackagePlugin

@main
struct Plugin: CommandPlugin {
    enum Error: Swift.Error {
        case mismatchedFileContents([URL])
    }

    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let createAPI = try context.tool(named: "create-api")
        let executableURL = URL(filePath: createAPI.path.string)

        let packageURL = URL(filePath: context.package.directory.string)
        let configURL = packageURL.appending(components: "Plugins", "CreateAPI", ".create-api.yml")

        var argExtractor = ArgumentExtractor(arguments)
        let specURLs = argExtractor.extractOption(named: "spec").map { URL(filePath: $0, relativeTo: packageURL) }
        let specTargetURLs = specURLs.map { $0.deletingLastPathComponent() }

        if specURLs.isEmpty {
            print("no specs to generate for")
            return
        }

        for specURL in specURLs {
            let specDirectoryURL = specURL.deletingLastPathComponent()
            let moduleName = specDirectoryURL.lastPathComponent
            let outputURL = specDirectoryURL.appending(component: "Generated")

            let createAPIArguments = [
                "generate",
                specURL.path,
                "--config",
                configURL.path,
                "--config-option",
                "module=\(moduleName)",
                "--output",
                outputURL.path,
                "--clean",
            ]

            let process = Process()
            process.executableURL = executableURL
            process.currentDirectoryURL = packageURL
            process.arguments = createAPIArguments

            try process.run()
            process.waitUntilExit()
        }

        let sharedFiles = [
            "Generated/Entities/ErrorLinks.swift",
            "Generated/Entities/ErrorResponse.swift",
            "Generated/Entities/ErrorSourceParameter.swift",
            "Generated/Entities/ErrorSourcePointer.swift",
            "Generated/Entities/PagedDocumentLinks.swift",
            "Generated/Extensions/AnyJSON.swift",
        ]

        for sharedFile in sharedFiles {
            let compareURLs = specTargetURLs.map { URL(filePath: sharedFile, relativeTo: $0) }

            let fileSet: Set<Data> = try compareURLs.reduce(into: []) { acc, curr in
                try acc.insert(Data(contentsOf: curr))
            }

            if fileSet.count > 1 {
                throw Error.mismatchedFileContents(compareURLs)
            }

            var contents = String(data: fileSet.first!, encoding: .utf8)!
            contents = contents.replacingOccurrences(of: "import AppStoreConnect\n", with: "")

            let src = compareURLs.first!
            let dest = packageURL.appending(components: "Sources", "AppStoreConnect", "Entities", src.lastPathComponent)

            try? FileManager.default.removeItem(at: src)
            try? FileManager.default.removeItem(at: dest)

            try contents.write(to: dest, atomically: true, encoding: .utf8)
        }

        let deleteFiles = [
            "Generated/Extensions/StringCodingKey.swift"
        ]

        for delete in deleteFiles {
            for targetURL in specTargetURLs {
                try FileManager.default.removeItem(at: URL(filePath: delete, relativeTo: targetURL))
            }
        }
    }
}
