import Foundation
import UIKit

final class ShareGiftBuilder {
    class func viewController(
        authToken: String,
        createLinkRequest: CreateLinkRequest
    ) -> ShareGiftViewController {
        let webClient = WebClient(baseUrl: Environments.currentEnvironment.rawValue)
        let createLinkService = CreateLinkService(
            client: webClient,
            authToken: authToken
        )
        let interactor = ShareGiftInteractor(
            createLinkService: createLinkService
        )
        let wireframe = ShareGiftWireframe()
        let nibName = String(describing: ShareGiftViewController.self)
        let viewController = ShareGiftViewController(
            nibName: nibName,
            bundle: Bundle(for: Self.self)
        )
        let presenter = ShareGiftPresenter(
            with: interactor,
            wireframe: wireframe,
            view: viewController,
            createLinkRequest: createLinkRequest
        )

        viewController.presenter = presenter
        wireframe.viewController = viewController

        return viewController
    }
}
