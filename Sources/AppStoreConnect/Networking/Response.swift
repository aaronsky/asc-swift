import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

/// Typealias for the status code returned by the App Store Connect API.
public typealias StatusCode = Int

/// Response from sending a ``Request``.
public struct Response<Received: Equatable & Sendable>: Equatable, Sendable {
    /// Raw data returned by the ``Transport``.
    let data: Received?
    /// Response returned by the ``Transport``.
    let response: URLResponse
    /// Status code found on the ``response``.
    let statusCode: StatusCode
    /// ``ErrorResponse`` object that could be extracted from the data, if possible.
    let errorResponse: ErrorResponse?
    /// Information about the rate limit and remaining calls allowed for this client within the current period.
    let rate: Rate?

    /// Creates a response that contains ``Data``.
    /// - Parameters:
    ///   - data: Data from the ``Transport``.
    ///   - response: Response from the ``Transport``.
    ///   - statusCode: Status code found on the ``response``.
    ///   - rate: The rate limit metadata provided with the ``response``.
    ///   - decoder: A decoder that can be used to parse an ``ErrorResponse`` object, in case one exists.
    init(
        data: Received?,
        response: URLResponse,
        statusCode: StatusCode,
        rate: Rate?,
        decoder: JSONDecoder
    ) where Received == Data {
        var errorResponse: ErrorResponse?
        if let data = data {
            errorResponse = try? decoder.decode(ErrorResponse.self, from: data)
        }

        self.init(data: data, response: response, statusCode: statusCode, rate: rate, errorResponse: errorResponse)
    }

    /// Creates a response that contains a ``URL``.
    /// - Parameters:
    ///   - fileURL: URL to an on-disk file downloaded by the ``Transport``.
    ///   - response: Response from the ``Transport``.
    ///   - statusCode: Status code found on the ``response``.
    ///   - rate: The rate limit metadata provided with the ``response``.
    init(
        fileURL: Received?,
        response: URLResponse,
        statusCode: StatusCode,
        rate: Rate?
    ) where Received == URL {
        self.init(data: fileURL, response: response, statusCode: statusCode, rate: rate)
    }

    /// Creates a response.
    /// - Parameters:
    ///   - data: Data from the ``Transport``.
    ///   - response: Response from the ``Transport``.
    ///   - statusCode: Status code found on the ``response``.
    ///   - rate: The rate limit metadata provided with the ``response``.
    ///   - errorResponse: ``ErrorResponse`` object that could be extracted from the data, if possible.
    init(
        data: Received?,
        response: URLResponse,
        statusCode: StatusCode,
        rate: Rate?,
        errorResponse: ErrorResponse? = nil
    ) {
        self.data = data
        self.response = response
        self.statusCode = statusCode
        self.rate = rate
        self.errorResponse = errorResponse
    }

    /// Checks the response for any unacceptable properties, such as a non-2XX status code, in order to verify integrity.
    /// - Throws: A ``ResponseError`` if the status code is not indicative of success.
    public func check() throws {
        switch statusCode {
        case 429:
            throw ResponseError.rateLimitExceeded(error: errorResponse, rate: rate, response: response)
        case ..<200, 300...:
            throw ResponseError.requestFailure(error: errorResponse, statusCode: statusCode, response: response)
        default:
            break
        }
    }

    /// Decodes the `data` into the intended container type.
    /// - Parameter decoder: The decoder to decode the data with.
    /// - Returns: The decoded data.
    /// - Throws: An error if `data` is `nil` or cannot be decoded as the expected type.
    public func decode<Output>(using decoder: JSONDecoder) throws -> Output where Output: Decodable, Received == Data {
        guard let data = data else {
            throw ResponseError.dataAssertionFailed
        }

        return try decoder.decode(Output.self, from: data)
    }

    /// Unwraps the stored `URL` and returns it.
    /// - Returns: URL to a downloaded file on-disk.
    /// - Throws: An error if `data` is nil.
    public func decode() throws -> URL where Received == URL {
        guard let data = data else {
            throw ResponseError.dataAssertionFailed
        }

        return data
    }
}

/// Error thrown when the response from the ``Transport`` fails to meet expectations.
public enum ResponseError: Swift.Error, Equatable {
    /// The response as requested was unsuccessful, as described by the `statusCode` and `error`.
    case requestFailure(error: ErrorResponse?, statusCode: StatusCode, response: URLResponse)
    /// The client has exceeded the rate limit for the current period.
    case rateLimitExceeded(error: ErrorResponse?, rate: Rate?, response: URLResponse)
    /// Data was expected to exist or conform to some format but failed.
    case dataAssertionFailed
}

/// The rate limit for the current client.
///
/// - SeeAlso: [Identifying Rate Limits](https://developer.apple.com/documentation/appstoreconnectapi/identifying_rate_limits)
public struct Rate: Equatable, Sendable {
    /// The number of requests per hour the client is currently limited to.
    public var limit: Int
    /// The number of remaining requests the client can make this hour.
    public var remaining: Int

    init?(
        from header: String?
    ) {
        guard let header = header, !header.isEmpty else { return nil }

        let pairs: [String: Int] = Dictionary(
            uniqueKeysWithValues:
                header
                .components(separatedBy: ";")
                .compactMap { $0.isEmpty ? nil : $0 }
                .compactMap {
                    let kvp = $0.components(separatedBy: ":")
                    guard kvp.count == 2 else { return nil }

                    let key = kvp[0]
                    guard let value = Int(kvp[1]) else { return nil }

                    return (key, value)
                }
        )

        guard let limit = pairs["user-hour-lim"], let remaining = pairs["user-hour-rem"] else { return nil }

        self.init(limit: limit, remaining: remaining)
    }

    init(
        limit: Int,
        remaining: Int
    ) {
        self.limit = limit
        self.remaining = remaining
    }
}
