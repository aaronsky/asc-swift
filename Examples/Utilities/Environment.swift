import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

/// Environment wrapper that loads values from a local file, falling back on a `ProcessInfo`.
public struct Environment {
    /// Error that is thrown if the environment file cannot be loaded.
    public enum FileParserError: Error, CustomStringConvertible {
        /// An error that describes a line in the environment file that cannot be parsed.
        case unreadableEntry(ParseContext)

        /// A textual representation of this error.
        public var description: String {
            switch self {
            case .unreadableEntry(let context):
                return """
                    \(context.url.relativePath):\(context.line): Unreadable entry in "\(context.content)"
                    """
            }
        }

        /// Context for the error thrown.
        public struct ParseContext: Equatable {
            /// The content of the line the error occurred at.
            public var content: String
            /// The line number.
            public var line: Int
            /// URL to the local file.
            public var url: URL
        }
    }

    /// URL to the local file.
    public var url: URL
    /// Reference to the current process.
    public var processInfo: ProcessInfo
    private var loadedEnvironment: [String: String] = [:]

    /// Creates an environment out of the loaded file, falling back on the current process' environment.
    /// - Parameters:
    ///   - url: URL to the local file.
    ///   - processInfo: The current process.
    /// - Throws: ``FileParserError`` if the file could not be loaded or parsed.
    public init(
        contentsOf url: URL? = nil,
        processInfo: ProcessInfo = .processInfo
    ) throws {
        self.url =
            url
            ?? URL(
                fileURLWithPath: ".env",
                relativeTo: URL(
                    fileURLWithPath: FileManager.default.currentDirectoryPath,
                    isDirectory: true
                )
            )
        self.processInfo = processInfo
        do {
            try reloadEnvironmentFile()
        } catch {
            print("*** WARNING: Error while parsing \(self.url.relativePath):", error)
        }
    }

    /// Get or set the environment.
    /// - Parameter name: Name of the environment variable.
    public subscript(name: String) -> String? {
        get {
            loadedEnvironment[name] ?? processInfo.environment[name]
        }
        set {
            guard let newValue = newValue else { return }
            loadedEnvironment[name] = newValue
        }
    }

    /// Get or set the environment.
    ///
    /// Returns a default value if the variable name is not present in the environment.
    /// - Parameters:
    ///   - name: Name of the environment variable.
    ///   - defaultValue: The default value to use if the variable is unset.
    public subscript(name: String, default defaultValue: @autoclosure () -> String) -> String {
        get {
            loadedEnvironment[name] ?? processInfo.environment[name, default: defaultValue()]
        }
        set {
            loadedEnvironment[name] = newValue
        }
    }

    /// Refreshes the environment variable list from the local file.
    /// - Throws: ``FileParserError`` if the file could not be loaded or parsed.
    public mutating func reloadEnvironmentFile() throws {
        let contents = try String(contentsOf: url, encoding: .utf8)
        for (index, line) in contents.split(separator: "\n").enumerated() {
            let components =
                line
                .split(separator: "=")
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

            guard components.count == 2 else {
                throw FileParserError.unreadableEntry(
                    FileParserError.ParseContext(
                        content: String(line),
                        line: index + 1,
                        url: url
                    )
                )
            }

            self[components[0]] = components[1]
        }
    }
}
