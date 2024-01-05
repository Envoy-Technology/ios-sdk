import Foundation

public enum PixelEvent {
    case appDownloaded
    case accountCreated
    case trialActivated
    case paymentSuccess
    case custom(eventName: String)
    
    var rawValue: String {
        switch self {
        case .appDownloaded:
            return "app_downloaded"
        case .accountCreated:
            return "account_created"
        case .trialActivated:
            return "trial_activated"
        case .paymentSuccess:
            return "payment_success"
        case .custom(let eventName):
            return eventName
        }
    }
}

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
    
    public init(event: PixelEvent, userId: String?, sharerUserId: String? = nil,
                shareLinkHash: String?, extra: Extra?) {
        self.eventName = event.rawValue
        self.userId = userId
        self.sharerUserId = sharerUserId
        self.shareLinkHash = shareLinkHash
        self.extra = extra
    }
}
