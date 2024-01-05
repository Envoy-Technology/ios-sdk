import Foundation

public struct ClaimUserRewardRequest: Encodable {
    public let userId: String
    public let paypalReceiver: String
    
    /// paypalReceiver should be a valid email
    public init(userId: String, paypalReceiver: String) {
        self.userId = userId
        self.paypalReceiver = paypalReceiver
    }
}
