import Foundation
import UIKit

final class ShareGiftBuilder {
    class func viewController(
        trackService: TrackServiceProtocol,
        request: CreateLinkRequest,
        jwtToken: String,
        baseURL: String
    ) -> ShareGiftViewController {
        let webClient = WebClient(baseURL: baseURL)
        let createLinkService = CreateLinkService(
            client: webClient,
            jwtToken: jwtToken
        )
        let interactor = ShareGiftInteractor(
            createLinkService: createLinkService,
            trackService: trackService,
            request: request,
            jwtToken: jwtToken
        )
        let wireframe = ShareGiftWireframe()
        let nibName = String(describing: ShareGiftViewController.self)
        let viewController = ShareGiftViewController(
            nibName: nibName,
            bundle: Bundle.envoyBundle
        )
        let presenter = ShareGiftPresenter(
            with: interactor,
            wireframe: wireframe,
            view: viewController,
            request: request
        )

        viewController.presenter = presenter
        wireframe.viewController = viewController

        return viewController
    }
}
