import Foundation

public struct LogPixelEventRequest: Encodable {
    
    public struct Extra: Encodable {
        let campaign: String?
        let userType: String?
        
        public init(campaign: String?, userType: String?) {
            self.campaign = campaign
            self.userType = userType
        }
    }
    
    let eventName: String
    let userId: String?
    let sharerUserId: String?
    let shareLinkHash: String?
    let extra: Extra?
    
    public init(eventName: String, userId: String?, sharerUserId: String?,
                shareLinkHash: String?, extra: Extra?) {
        self.eventName = eventName
        self.userId = userId
        self.sharerUserId = sharerUserId
        self.shareLinkHash = shareLinkHash
        self.extra = extra
    }
}
