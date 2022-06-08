import Foundation

public struct CreateLinkResponse: Codable {
    let url: String
    let userRemainingQuota: Int

    enum CodingKeys: String, CodingKey {
        case url
        case userRemainingQuota = "user_remaining_quota"
    }
}
