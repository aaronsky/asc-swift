import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension Array where Element == URLQueryItem {
    mutating func appendIfNeeded<S: LosslessStringConvertible>(_ value: S?, forKey key: String) {
        guard let value = value else {
            return
        }
        append(URLQueryItem(name: key, value: String(value)))
    }

    mutating func appendIfNeeded(_ uuid: UUID?, forKey key: String) {
        appendIfNeeded(uuid?.uuidString, forKey: key)
    }

    mutating func appendIfNeeded(_ date: Date?, forKey key: String) {
        guard let date = date else {
            return
        }
        appendIfNeeded(Formatters.iso8601.string(from: date), forKey: key)
    }

    enum ArrayFormat {
        case indices
        case brackets

        func format(for index: Int) -> String {
            switch self {
            case .indices:
                return "[\(index)]"
            case .brackets:
                return "[]"
            }
        }
    }

    mutating func append(_ items: [String], forKey key: String, arrayFormat: ArrayFormat = .brackets) {
        if items.isEmpty {
            return
        } else if items.count == 1 {
            appendIfNeeded(items.first, forKey: key)
        } else {
            append(
                contentsOf:
                    items
                    .enumerated()
                    .map {
                        URLQueryItem(
                            name: "\(key)\(arrayFormat.format(for: $0.offset))",
                            value: $0.element
                        )
                    }
            )
        }
    }

    mutating func append(_ items: [String: String], forKey key: String) {
        append(
            contentsOf: items.map {
                URLQueryItem(
                    name: "\(key)[\($0.key)]",
                    value: $0.value
                )
            }
        )
    }
}
