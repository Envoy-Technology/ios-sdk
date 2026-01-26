import Foundation

public struct ClaimUserRewardRequest: Encodable {
    let userId: String
    
    public init(userId: String) {
        self.userId = userId
    }
}
