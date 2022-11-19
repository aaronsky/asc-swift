import Foundation
import PackagePlugin

@main
struct Plugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let createAPI = try context.tool(named: "create-api")
        let workingDirectory = context.package.directory.appending("Sources", "AppStoreConnect")

        let process = Process()
        process.currentDirectoryURL = URL(fileURLWithPath: workingDirectory.string)
        process.executableURL = URL(fileURLWithPath: createAPI.path.string)
        process.arguments = [
            "generate",
            "app_store_connect_api_2.1_openapi.json",
            "--config", ".create-api.yml",
            "--output", "Generated",
            "--clean",
        ]

        try process.run()
        process.waitUntilExit()
    }
}
