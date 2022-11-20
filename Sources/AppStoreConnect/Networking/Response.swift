import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Response from sending a ``Request``.
public struct Response<Received: Equatable>: Equatable {
    /// Error thrown when the response from the ``Transport`` fails to meet expectations.
    public enum Error: Swift.Error {
        /// The response as requested was unsuccessful, as described by the ``statusCode`` and ``error``.
        case requestFailure(statusCode: StatusCode, error: ErrorResponse?, response: URLResponse)
        /// Data was expected to exist or conform to some format but failed.
        case dataAssertionFailed
    }

    /// Typealias for the status code returned by the App Store Connect API.
    public typealias StatusCode = Int

    /// Raw data returned by the ``Transport``.
    let data: Received?
    /// Response returned by the ``Transport``.
    let response: URLResponse
    /// Status code found on the ``response``.
    let statusCode: StatusCode
    /// ``ErrorResponse`` object that could be extracted from the data, if possible.
    let errorResponse: ErrorResponse?

    /// Creates a response that contains ``Data``.
    /// - Parameters:
    ///   - data: Data from the ``Transport``.
    ///   - response: Response from the ``Transport``.
    ///   - statusCode: Status code found on the ``response``.
    ///   - decoder: A decoder that can be used to parse an ``ErrorResponse`` object, in case one exists.
    init(
        data: Received?,
        response: URLResponse,
        statusCode: StatusCode,
        decoder: JSONDecoder
    ) where Received == Data {
        var errorResponse: ErrorResponse?
        if let data = data {
            errorResponse = try? decoder.decode(ErrorResponse.self, from: data)
        }

        self.init(data: data, response: response, statusCode: statusCode, errorResponse: errorResponse)
    }

    /// Creates a response that contains a ``URL``.
    /// - Parameters:
    ///   - fileURL: URL to an on-disk file downloaded by the ``Transport``.
    ///   - response: Response from the ``Transport``.
    ///   - statusCode: Status code found on the ``response``.
    init(
        fileURL: Received?,
        response: URLResponse,
        statusCode: StatusCode
    ) where Received == URL {
        self.init(data: fileURL, response: response, statusCode: statusCode)
    }

    /// Creates a response.
    /// - Parameters:
    ///   - data: Data from the ``Transport``.
    ///   - response: Response from the ``Transport``.
    ///   - statusCode: Status code found on the ``response``.
    ///   - errorResponse: ``ErrorResponse`` object that could be extracted from the data, if possible.
    init(
        data: Received?,
        response: URLResponse,
        statusCode: StatusCode,
        errorResponse: ErrorResponse? = nil
    ) {
        self.data = data
        self.response = response
        self.statusCode = statusCode
        self.errorResponse = errorResponse
    }

    /// Checks the response for any unacceptable properties, such as a non-2XX status code, in order to verify integrity.
    func check() throws {
        guard 200..<300 ~= statusCode else {
            throw Error.requestFailure(statusCode: statusCode, error: errorResponse, response: response)
        }
    }

    /// Decodes the ``data`` into the intended container type.
    /// - Returns: The decoded data.
    func decode<Output>(using decoder: JSONDecoder) throws -> Output where Output: Decodable, Received == Data {
        guard let data = data else {
            throw Error.dataAssertionFailed
        }

        return try decoder.decode(Output.self, from: data)
    }

    /// Unwraps the stored ``URL`` and returns it.
    /// - Returns: URL to a downloaded file on-disk.
    func decode() throws -> URL where Received == URL {
        guard let data = data else {
            throw Error.dataAssertionFailed
        }

        return data
    }
}
