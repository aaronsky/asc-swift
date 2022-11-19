import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URL {
    init() {
        self.init(string: "https://www.apple.com")!
    }
}
