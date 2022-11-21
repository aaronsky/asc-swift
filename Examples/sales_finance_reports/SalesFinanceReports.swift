import AppStoreConnect
import ArgumentParser
import Foundation
import Utilities

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@main struct SalesFinanceReports: AsyncParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "A utility for downloading sales and finance reports.",
        version: "0.1.0",
        subcommands: [Sales.self, Finance.self],
        defaultSubcommand: Sales.self
    )

    struct Options: ParsableArguments {
        @Option var vendorNumber: String
        @Option var reportDate: String
        @Option(
            completion: .directory,
            transform: URL.init(fileURLWithPath:)
        )
        var output: URL
    }

    struct Sales: AsyncParsableCommand {
        @OptionGroup var options: Options

        mutating func run() async throws {
            let client = try AppStoreConnectClient(authenticator: EnvAuthenticator())

            let url = try await client.download(
                Resources.v1.salesReports.get(
                    filterFrequency: [.weekly],
                    filterReportDate: [options.reportDate],
                    filterReportSubType: [.summary],
                    filterReportType: [.sales],
                    filterVendorNumber: [options.vendorNumber]
                )
            )

            print("Wrote sales report to \(url)")
        }
    }

    struct Finance: AsyncParsableCommand {
        @OptionGroup var options: Options

        mutating func run() async throws {
            let client = try AppStoreConnectClient(authenticator: EnvAuthenticator())

            let url = try await client.download(
                Resources.v1.financeReports.get(
                    filterRegionCode: ["US"],
                    filterReportDate: [options.reportDate],
                    filterReportType: [.financial],
                    filterVendorNumber: [options.vendorNumber]
                )
            )

            print("Wrote finance report to \(url)")
        }
    }
}
