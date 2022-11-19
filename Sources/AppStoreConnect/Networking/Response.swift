import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

enum ResponseError: Error {
    case requestFailure(Response.StatusCode, ErrorResponse?, URLResponse)
    case dataAssertionFailed
}

public struct Response<T: Equatable>: Equatable {
    public typealias StatusCode = Int

    public let data: T?
    public let response: URLResponse
    public let statusCode: StatusCode
    public let errorResponse: ErrorResponse?

    public init(
        data: T?,
        response: URLResponse,
        statusCode: StatusCode,
        decoder: JSONDecoder
    ) throws where T == Data {
        var errorResponse: ErrorResponse?
        if let data = data {
            errorResponse = try decoder.decode(ErrorResponse.self, from: data)
        }

        self.init(data: data, response: response, statusCode: statusCode, errorResponse: errorResponse)
    }

    public init(
        fileURL: T?,
        response: URLResponse,
        statusCode: StatusCode
    ) where T == URL {
        self.init(data: fileURL, response: response, statusCode: statusCode)
    }

    public init(
        data: T?,
        response: URLResponse,
        statusCode: StatusCode,
        errorResponse: ErrorResponse? = nil
    ) {
        self.data = data
        self.response = response
        self.statusCode = statusCode
        self.errorResponse = errorResponse
    }

    func check() throws {
        guard 200..<300 ~= statusCode else {
            throw ResponseError.requestFailure(statusCode, errorResponse, response)
        }
    }

    func decode<Output>(using decoder: JSONDecoder) throws -> Output where Output: Decodable, T == Data {
        guard let data = data else {
            throw ResponseError.dataAssertionFailed
        }

        return try decoder.decode(Output.self, from: data)
    }

    func decode() throws -> URL where T == URL {
        guard let data = data else {
            throw ResponseError.dataAssertionFailed
        }

        return data
    }
}
