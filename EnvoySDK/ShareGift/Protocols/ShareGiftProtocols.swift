protocol ShareGiftWireframeProtocol: AnyObject {

}

protocol ShareGiftInteractorProtocol: AnyObject {
    func getCreateLink(
        request: CreateLinkRequest,
        completion: @escaping (CreateLinkResponse?, WebError?) -> ()
    )

    // Track
    func trackClickGenerateShareLink()
    func trackViewShareDetails(url: String, giftsLeft: Int)
    func trackViewExceededQuotaError()
    func trackClickChooseShareMedium(url: String, type: String)
}

protocol ShareGiftViewProtocol: AnyObject {
    func updateWith(viewState: ShareGiftViewState)
    func updateWith(isLoading: Bool)
    func presentShare(for url: String)
}

protocol ShareGiftViewDelegate: AnyObject {
    func viewDidLoad()
    func shareAction()
    func shareCompleted(with type: UIActivity.ActivityType)
}
