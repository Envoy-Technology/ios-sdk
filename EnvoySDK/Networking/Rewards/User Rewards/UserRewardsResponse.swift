import Foundation

public struct UserRewardsResponse: Decodable {
    let userId: String
    let rewardAvailable: Bool
}
