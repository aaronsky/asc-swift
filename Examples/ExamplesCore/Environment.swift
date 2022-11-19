import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct Environment {
    public enum FileParserError: Error, CustomStringConvertible {
        case unreadableEntry(ParseContext)

        public var description: String {
            switch self {
            case .unreadableEntry(let context):
                return """
                    \(context.url.relativePath):\(context.line): Unreadable entry in "\(context.content)"
                    """
            }
        }

        public struct ParseContext: Equatable {
            public var content: String
            public var line: Int
            public var url: URL
        }
    }

    public var url: URL
    public var processInfo: ProcessInfo
    public private(set) var loadedEnvironment: [String: String] = [:]

    @discardableResult
    public init(
        contentsOf url: URL? = nil,
        processInfo: ProcessInfo = .processInfo
    ) throws {
        self.url = url ?? .currentDirectory().appending(path: ".env")
        self.processInfo = processInfo
        do {
            try reloadEnvironmentFile()
        } catch {
            print("*** WARNING: Error while parsing \(self.url.relativePath):", error)
        }
    }

    public subscript(name: String) -> String? {
        get {
            loadedEnvironment[name] ?? processInfo.environment[name]
        }
        set {
            guard let newValue = newValue else { return }
            loadedEnvironment[name] = newValue
        }
    }

    public subscript(name: String, default defaultValue: @autoclosure () -> String) -> String {
        get {
            loadedEnvironment[name] ?? processInfo.environment[name, default: defaultValue()]
        }
        set {
            loadedEnvironment[name] = newValue
        }
    }

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
