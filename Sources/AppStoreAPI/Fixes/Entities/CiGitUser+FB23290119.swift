import Foundation
import AppStoreConnect

/// The following code should be removed once Apple has fixed FB23290119 which allows the server to return
/// `avatarURL` as the empty string rather than `null` or a correct URL object.
///
extension CiGitUser {
    private enum FixCodingKeys: String, CodingKey {
        case displayName
        case avatarURL = "avatarUrl"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: FixCodingKeys.self)
        self.displayName = try container.decodeIfPresent(String.self, forKey: .displayName)
        self.avatarURL = try? container.decodeIfPresent(URL.self, forKey: .avatarURL)
    }
}
