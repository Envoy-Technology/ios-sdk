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
        let title: String?
        let type: String?
        
        public init(title: String?, type: String?) {
            self.title = title
            self.type = type
        }
    }
    
    let eventName: String
    let sharerUserId: String?
    let shareLinkHash: String?
    let extra: Extra?
    
    public init(event: PixelEvent, sharerUserId: String? = nil,
                shareLinkHash: String? = nil, extra: Extra? = nil) {
        self.eventName = event.rawValue
        self.sharerUserId = sharerUserId
        self.shareLinkHash = shareLinkHash
        self.extra = extra
    }
}
