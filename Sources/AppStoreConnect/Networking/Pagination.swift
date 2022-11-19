import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// A page in a paginated REST API.
public struct Page: Equatable, Hashable, Sendable {
    /// Index of the next page, if any.
    public var nextPage: Int?
    /// Index of the previous page, if any.
    public var previousPage: Int?
    /// Index of the first page, if any.
    public var firstPage: Int?
    /// Index of the last page, if any.
    public var lastPage: Int?

    init?(
        for header: String
    ) {
        if header.isEmpty {
            return nil
        }

        for link in header.split(separator: ",") {
            let segments = link
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .split(separator: ";")
            guard
                segments.count <= 2,

                let urlString = segments.first,
                urlString.hasPrefix("<") && urlString.hasSuffix(">"),

                let url = URLComponents(string: String(urlString.dropFirst().dropLast())),

                let pageString = url.queryItems?.first(where: { $0.name == "page" })?.value,
                let page = Int(pageString)
            else {
                continue
            }

            for segment in segments.dropFirst() {
                switch segment.trimmingCharacters(in: .whitespacesAndNewlines) {
                case "rel=\"next\"":
                    nextPage = page
                case "rel=\"prev\"":
                    previousPage = page
                case "rel=\"first\"":
                    firstPage = page
                case "rel=\"last\"":
                    lastPage = page
                default:
                    continue
                }
            }
        }
    }
}

/// Page options to use when fetching a paginated resource.
public struct PageOptions: Equatable, Hashable, Sendable {
    /// Page index.
    public var page: Int
    /// Limit of items per page.
    public var perPage: Int

    public init(
        page: Int,
        perPage: Int
    ) {
        self.page = page
        self.perPage = perPage
    }
}

extension URLRequest {
    mutating func appendPageOptions(_ options: PageOptions) {
        guard let url = self.url,
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        else {
            return
        }
        var queryItems = components.queryItems ?? []
        queryItems.append(pageOptions: options)
        components.queryItems = queryItems
        self.url = components.url
    }
}

extension Array where Element == URLQueryItem {
    fileprivate mutating func append(pageOptions: PageOptions) {
        append(URLQueryItem(name: "page", value: String(pageOptions.page)))
        append(URLQueryItem(name: "per_page", value: String(pageOptions.perPage)))
    }
}
