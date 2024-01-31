import Foundation
import UIKit

public protocol EnvoyType {
    
    func pushShareGift(
        in navigationController: UINavigationController,
        request: CreateLinkRequest
    )
    
    func presentShareGift(
        from viewController: UIViewController,
        request: CreateLinkRequest
    )
    
    func giftButton(request: CreateLinkRequest) -> UIButton
    
    func createLink(request: CreateLinkRequest,
                    completion: @escaping (CreateLinkResponse?, WebError?) -> ())
    
    func getUserRemainingQuota(userId: String,
                               completion: @escaping (UserQuotaResponse?, WebError?) -> ())
    
    func logPixelEvent(request: LogPixelEventRequest,
                       completion: @escaping (EmptyResponse?, WebError?) -> ())
    
    func getUserRewards(userId: String,
                        completion: @escaping (UserRewardsResponse?, WebError?) -> ())
    
    func claimUserReward(request: ClaimUserRewardRequest,
                         completion: @escaping (ClaimUserRewardResponse?, WebError?) -> ())
    
    func getUserCurrentRewards(
        userId: String,
        completion: @escaping (UserCurrentRewardsResponse?, WebError?) -> ())
}

public final class Envoy {
    private enum Constants {
        static let envoyShareLinkHash = "envoy_share_link_hash"
        static let envoyLeadUuid = "envoy_lead_uuid"
    }
    
    private let apiKey: String
    private let apiUrl: String
    fileprivate let webClient: WebClient
    
    public static var shared: Envoy!
    
    public static func initialize(apiKey: String) {
        Envoy.shared = Envoy(apiKey: apiKey)
    }
    
    private init(apiKey: String) {
        self.apiKey = apiKey
        //self.apiUrl = "https://dev-api.envoy.is/partner/"
        self.apiUrl = "https://api.envoy.is/partner/"
        self.webClient = WebClient(baseURL: self.apiUrl)
        
        if UserDefaults.standard.isFreshInstall {
            UserDefaults.standard.set(isFreshInstall: false)
            guard let clipboardLink = UIPasteboard.general.string,
                  let url = URL(string: clipboardLink),
                  let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
                  let parameters = components.queryItems else {
                return
            }
            for parameter in parameters {
                if parameter.name == Constants.envoyShareLinkHash,
                   let value = parameter.value {
                    Keychain.standard.set(value, forKey: .envoyShareLinkHash)
                } else if parameter.name == Constants.envoyLeadUuid,
                   let value = parameter.value {
                    Keychain.standard.set(value, forKey: .envoyLeadUuid)
                }
            }
        }
    }
}

extension Envoy: EnvoyType {
    
    public func pushShareGift(in navigationController: UINavigationController,
                              request: CreateLinkRequest) {
        navigationController.pushViewController(shareGiftViewController(request: request),
                                                animated: true)
    }
    
    public func presentShareGift(from viewController: UIViewController,
                                 request: CreateLinkRequest) {
        let parentViewController = viewController.navigationController ?? viewController
        let viewController = shareGiftViewController(request: request)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        parentViewController.present(navigationController, animated: true)
    }
    
    public func giftButton(request: CreateLinkRequest) -> UIButton {
        let button = GiftButton(type: .custom)
        button.token = apiKey
        button.request = request
        button.initialize()
        return button
    }
    
    public func createLink(request: CreateLinkRequest,
                           completion: @escaping (CreateLinkResponse?, WebError?) -> ()) {
        CreateLinkService(client: self.webClient, apiKey: self.apiKey)
            .createLink(request: request, completion: completion)
    }
    
    public func getUserRemainingQuota(userId: String,
                                      completion: @escaping (UserQuotaResponse?, WebError?) -> ()) {
        GetUserRemainingQuotaService(client: self.webClient, apiKey: self.apiKey)
            .getUserQuota(userId: userId, completion: completion)
    }
    
    public func logPixelEvent(request: LogPixelEventRequest,
                              completion: @escaping (EmptyResponse?, WebError?) -> ()) {
        LogPixelEventService(client: self.webClient, apiKey: self.apiKey)
            .logPixelEvent(request: request, completion: completion)
    }
    
    public func getUserRewards(userId: String,
                               completion: @escaping (UserRewardsResponse?, WebError?) -> ()) {
        GetUserRewardsService(client: self.webClient, apiKey: self.apiKey)
            .getUserRewards(userId: userId, completion: completion)
    }
    
    public func claimUserReward(request: ClaimUserRewardRequest,
                                completion: @escaping (ClaimUserRewardResponse?, WebError?) -> ()) {
        ClaimUserRewardService(client: self.webClient, apiKey: self.apiKey)
            .claimUserReward(request: request, completion: completion)
    }
    
    public func getUserCurrentRewards(
        userId: String,
        completion: @escaping (UserCurrentRewardsResponse?, WebError?) -> ()) {
            GetUserCurrentRewardsService(client: self.webClient, apiKey: self.apiKey)
                .getUserCurrentRewards(userId: userId, completion: completion)
    }
}

private extension Envoy {
    func shareGiftViewController(request: CreateLinkRequest) -> UIViewController {
        let viewController = ShareGiftBuilder.viewController(
            request: request,
            apiKey: apiKey,
            baseURL: self.apiUrl)
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
}
