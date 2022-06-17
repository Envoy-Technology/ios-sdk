import Foundation
import UIKit

public protocol EnvoyType {
    func pushShareGift(
        in navigationController: UINavigationController,
        createLinkRequest: CreateLinkRequest
    )
    func presentShareGift(
        from viewController: UIViewController,
        createLinkRequest: CreateLinkRequest
    )
}

public final class Envoy {

    private let apiKey: String

    public init(apiKey: String) {
        self.apiKey = apiKey
    }
}

extension Envoy: EnvoyType {
    public func pushShareGift(
        in navigationController: UINavigationController,
        createLinkRequest: CreateLinkRequest
    ) {
        navigationController.pushViewController(shareGiftViewController(createLinkRequest: createLinkRequest), animated: true)
    }

    public func presentShareGift(
        from viewController: UIViewController,
        createLinkRequest: CreateLinkRequest
    ) {
        let parentViewController = viewController.navigationController ?? viewController
        let viewController = shareGiftViewController(createLinkRequest: createLinkRequest)
        let navigationController = UINavigationController(rootViewController: viewController)
        parentViewController.present(navigationController, animated: true)
    }
}

private extension Envoy {
    func shareGiftViewController(createLinkRequest: CreateLinkRequest) -> UIViewController {
        let viewController = ShareGiftBuilder.viewController(
            authToken: apiKey,
            createLinkRequest: createLinkRequest
        )
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
}
