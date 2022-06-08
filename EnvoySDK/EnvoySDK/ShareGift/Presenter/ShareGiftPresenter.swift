import UIKit

final class ShareGiftPresenter {
    var wireframe: ShareGiftWireframeProtocol
    var interactor: ShareGiftInteractorProtocol
    weak var view: ShareGiftViewProtocol?

    var viewState = ShareGiftViewState()
    let createLinkRequest: CreateLinkRequest

    init(
        with interactor: ShareGiftInteractor,
        wireframe: ShareGiftWireframe,
        view: ShareGiftViewProtocol,
        createLinkRequest: CreateLinkRequest
    ) {
        self.interactor = interactor
        self.wireframe = wireframe
        self.view = view
        self.createLinkRequest = createLinkRequest
    }
}

extension ShareGiftPresenter: ShareGiftViewDelegate {
    func viewDidLoad() {
        createLink()
        updateView()
    }

    func shareAction() {
        startSharing()
    }
}

private extension ShareGiftPresenter {
    func updateView() {
        view?.updateWith(viewState: viewState)
    }

    func createLink() {
        view?.updateWith(isLoading: true)
        interactor.createLink(
            request: createLinkRequest
        ) { [weak self] response, error in
            guard let self = self else { return }
            self.view?.updateWith(isLoading: false)
            if let _ = error {
//                self.viewState.error = error.message
                self.viewState.response = .init(
                    url: "https://contents.pallycon.com/bunny/stream.mpd",
                    userRemainingQuota: 5
                )
                self.startSharing()
            } else {
                self.viewState.response = response
                self.startSharing()
            }
            self.updateView()
        }
    }

    func startSharing() {
        guard let url = viewState.response?.url else { return }
        view?.presentShare(for: url)
    }
}
