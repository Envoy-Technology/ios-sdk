import Foundation

public struct UserCurrentRewardsResponse: Decodable {
    struct EventCount: Decodable {
        let completed: Int
        let leftToReward: Int
        let percentageDone: Int
    }
    
    let earnedThisPeriod: Int
    let earnableLeft: Int
    let eventCount: EventCount
}
