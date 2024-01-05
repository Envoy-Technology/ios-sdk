import Foundation

public struct UserQuotaResponse: Decodable {
    let userId: String
    let userRemainingQuota: Int
}
