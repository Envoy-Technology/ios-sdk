import UIKit

final class ShareGiftInteractor {
    
    private let createLinkService: CreateLinkServiceType
    
    init(createLinkService: CreateLinkServiceType) {
        self.createLinkService = createLinkService
    }
}

extension ShareGiftInteractor: ShareGiftInteractorProtocol {
    func createLink(
        request: CreateLinkRequest,
        completion: @escaping (CreateLinkResponse?, WebError?) -> ()
    ) {
        createLinkService.createLink(
            request: request,
            completion: completion
        )
    }
}
