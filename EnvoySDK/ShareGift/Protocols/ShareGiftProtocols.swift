protocol ShareGiftWireframeProtocol: AnyObject {

}

protocol ShareGiftInteractorProtocol: AnyObject {
    func createLink(
        request: CreateLinkRequest,
        completion: @escaping (CreateLinkResponse?, WebError?) -> ()
    )
}

protocol ShareGiftViewProtocol: AnyObject {
    func updateWith(viewState: ShareGiftViewState)
    func updateWith(isLoading: Bool)
    func presentShare(for url: String)
}

protocol ShareGiftViewDelegate: AnyObject {
    func viewDidLoad()
    func shareAction()
}
