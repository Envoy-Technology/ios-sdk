import Foundation
import UIKit
import Mixpanel

public protocol EnvoyType {
    static func initialize()

    func pushShareGift(
        in navigationController: UINavigationController,
        request: CreateLinkRequest
    )

    func presentShareGift(
        from viewController: UIViewController,
        request: CreateLinkRequest
    )

    func giftButton(request: CreateLinkRequest) -> UIButton
}

public final class Envoy {

    private let jwtToken: String
    private let trackService = TrackService()

    public init(apiKey: String) {
        self.jwtToken = apiKey
    }
}

extension Envoy: EnvoyType {
    public static func initialize() {
        Mixpanel.initialize(token: Environments.currentEnvironment.mixpanelToken)
    }

    public func pushShareGift(
        in navigationController: UINavigationController,
        request: CreateLinkRequest
    ) {
        navigationController.pushViewController(
            shareGiftViewController(
                request: request
            ),
            animated: true
        )
    }

    public func presentShareGift(
        from viewController: UIViewController,
        request: CreateLinkRequest
    ) {
        let parentViewController = viewController.navigationController ?? viewController
        let viewController = shareGiftViewController(request: request)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        parentViewController.present(navigationController, animated: true)
    }

    public func giftButton(request: CreateLinkRequest) -> UIButton {
        let button = GiftButton(type: .custom)
        button.jwtToken = jwtToken
        button.trackService = trackService
        button.request = request
        button.initialize()
        return button
    }
}

private extension Envoy {
    func shareGiftViewController(request: CreateLinkRequest) -> UIViewController {
        let viewController = ShareGiftBuilder.viewController(
            trackService: trackService,
            request: request,
            jwtToken: jwtToken
        )
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
}
