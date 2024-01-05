import Foundation

public struct ClaimUserRewardRequest: Encodable {
    let userId: String
    let paypalReceiver: String
    
    public init(userId: String, paypalReceiver: String) {
        self.userId = userId
        self.paypalReceiver = paypalReceiver
    }
}
