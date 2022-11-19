import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// A container for JSON-like data.
@dynamicMemberLookup
public enum JSONValue: Equatable, Hashable, Sendable {
    case null
    case bool(Bool)
    case number(Double)
    case string(String)
    indirect case array([JSONValue])
    indirect case object([String: JSONValue])
}

extension JSONValue {
    public subscript(dynamicMember key: JSONValue) -> JSONValue? {
        self[key]
    }

    public subscript(_ key: JSONValue) -> JSONValue? {
        if case .number(let key) = key {
            return self[Int(key)]
        } else if case .string(let key) = key {
            return self[key]
        }
        return nil
    }

    public subscript(_ index: Int) -> JSONValue? {
        guard case .array(let array) = self else {
            return nil
        }
        return array[index]
    }

    public subscript(_ key: String) -> JSONValue? {
        guard case .object(let object) = self else {
            return nil
        }
        return object[key]
    }
}

extension JSONValue: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .null:
            try container.encodeNil()
        case .bool(let boolValue):
            try container.encode(boolValue)
        case .number(let doubleValue):
            try container.encode(doubleValue)
        case .string(let stringValue):
            try container.encode(stringValue)
        case .array(let arrayValue):
            try container.encode(arrayValue)
        case .object(let objectValue):
            try container.encode(objectValue)
        }
    }
}

extension JSONValue: Decodable {
    public init(
        from decoder: Decoder
    ) throws {
        let singleValueContainer = try decoder.singleValueContainer()

        if singleValueContainer.decodeNil() {
            self = .null
        } else if let boolValue = try? singleValueContainer.decode(Bool.self) {
            self = .bool(boolValue)
        } else if let doubleValue = try? singleValueContainer.decode(Double.self) {
            self = .number(doubleValue)
        } else if let stringValue = try? singleValueContainer.decode(String.self) {
            self = .string(stringValue)
        } else if let arrayValue = try? singleValueContainer.decode([JSONValue].self) {
            self = .array(arrayValue)
        } else if let objectValue = try? singleValueContainer.decode([String: JSONValue].self) {
            self = .object(objectValue)
        } else {
            throw DecodingError.dataCorruptedError(
                in: singleValueContainer,
                debugDescription: "invalid JSON structure or the input was not JSON"
            )
        }
    }
}

extension JSONValue: ExpressibleByNilLiteral {
    public init(
        nilLiteral: Void
    ) {
        self = .null
    }
}

extension JSONValue: ExpressibleByBooleanLiteral {
    public init(
        booleanLiteral value: BooleanLiteralType
    ) {
        self = .bool(value)
    }
}

extension JSONValue: ExpressibleByIntegerLiteral {
    public init(
        integerLiteral value: IntegerLiteralType
    ) {
        self = .number(Double(value))
    }
}

extension JSONValue: ExpressibleByFloatLiteral {
    public init(
        floatLiteral value: FloatLiteralType
    ) {
        self = .number(value)
    }
}

extension JSONValue: ExpressibleByStringLiteral {
    public init(
        stringLiteral value: StringLiteralType
    ) {
        self = .string(value)
    }
}

extension JSONValue: ExpressibleByArrayLiteral {
    public init(
        arrayLiteral elements: JSONValue...
    ) {
        self = .array(elements)
    }
}

extension JSONValue: ExpressibleByDictionaryLiteral {
    public init(
        dictionaryLiteral elements: (String, JSONValue)...
    ) {
        self = .object(Dictionary(uniqueKeysWithValues: elements))
    }
}
