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
                    completion: @escaping (CreateLinkResponse?, WebError?) -> ()) -> URLSessionDataTask?
    
    func getUserRemainingQuota(userId: String,
                               completion: @escaping (UserQuotaResponse?, WebError?) -> ()) -> URLSessionDataTask?
    
    func logPixelEvent(request: LogPixelEventRequest,
                       completion: @escaping (EmptyResponse?, WebError?) -> ()) -> URLSessionDataTask?
    
    func getUserRewards(userId: String,
                        completion: @escaping (UserRewardsResponse?, WebError?) -> ()) -> URLSessionDataTask?
    
    func claimUserReward(request: ClaimUserRewardRequest,
                         completion: @escaping (ClaimUserRewardResponse?, WebError?) -> ()) -> URLSessionDataTask?
    
    func getUserCurrentRewards(
        userId: String,
        completion: @escaping (UserCurrentRewardsResponse?, WebError?) -> ()) -> URLSessionDataTask?
}

public final class Envoy {
    private let token: String
    private let baseURL: String
    fileprivate let webClient: WebClient
    
    public init(baseURL: String, token: String) {
        self.baseURL = baseURL
        self.token = token
        self.webClient = WebClient(baseURL: baseURL)
        
        if UserDefaults.standard.isFreshInstall {
            UserDefaults.standard.set(isFreshInstall: false)
            guard let clipboardLink = UIPasteboard.general.string,
                  let url = URL(string: clipboardLink),
                  clipboardLink.contains("envoy") else {
                return
            }
            let linkHash = url.lastPathComponent
            Keychain.standard.set(linkHash, forKey: .clipboardLinkHash)
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
        button.token = token
        button.request = request
        button.initialize()
        return button
    }
    
    public func createLink(request: CreateLinkRequest,
                           completion: @escaping (CreateLinkResponse?, WebError?) -> ()) -> URLSessionDataTask? {
        CreateLinkService(client: self.webClient, token: self.token)
            .createLink(request: request, completion: completion)
    }
    
    public func getUserRemainingQuota(userId: String,
                                      completion: @escaping (UserQuotaResponse?, WebError?) -> ()) -> URLSessionDataTask? {
        GetUserRemainingQuotaService(client: self.webClient, token: self.token)
            .getUserQuota(userId: userId, completion: completion)
    }
    
    public func logPixelEvent(request: LogPixelEventRequest,
                              completion: @escaping (EmptyResponse?, WebError?) -> ()) -> URLSessionDataTask? {
        LogPixelEventService(client: self.webClient, token: self.token)
            .logPixelEvent(request: request, completion: completion)
    }
    
    public func getUserRewards(userId: String,
                               completion: @escaping (UserRewardsResponse?, WebError?) -> ()) -> URLSessionDataTask? {
        GetUserRewardsService(client: self.webClient, token: self.token)
            .getUserRewards(userId: userId, completion: completion)
    }
    
    public func claimUserReward(request: ClaimUserRewardRequest,
                                completion: @escaping (ClaimUserRewardResponse?, WebError?) -> ()) -> URLSessionDataTask? {
        ClaimUserRewardService(client: self.webClient, token: self.token)
            .claimUserReward(request: request, completion: completion)
    }
    
    public func getUserCurrentRewards(
        userId: String,
        completion: @escaping (UserCurrentRewardsResponse?, WebError?) -> ()) -> URLSessionDataTask? {
            GetUserCurrentRewardsService(client: self.webClient, token: self.token)
                .getUserCurrentRewards(userId: userId, completion: completion)
    }
}

private extension Envoy {
    func shareGiftViewController(request: CreateLinkRequest) -> UIViewController {
        let viewController = ShareGiftBuilder.viewController(
            request: request,
            token: token,
            baseURL: baseURL)
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
}
