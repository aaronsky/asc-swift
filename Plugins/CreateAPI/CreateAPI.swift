import Foundation
import PackagePlugin

@main
struct Plugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let createAPI = try context.tool(named: "create-api")
        let workingDirectory = context.package.directory.appending("Sources", "_Specification")
        let specPath = arguments[0]

        let process = Process()
        process.currentDirectoryURL = URL(fileURLWithPath: workingDirectory.string)
        process.executableURL = URL(fileURLWithPath: createAPI.path.string)
        process.arguments = [
            "generate", specPath,
            "--config", ".create-api.yml",
            "--output", "Generated",
            "--clean",
        ]

        try process.run()
        process.waitUntilExit()
    }
}
