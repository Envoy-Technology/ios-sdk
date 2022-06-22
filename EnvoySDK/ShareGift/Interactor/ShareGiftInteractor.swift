import UIKit

final class ShareGiftInteractor {
    
    private let createLinkService: CreateLinkServiceType
    private let trackService: TrackServiceProtocol
    private let request: CreateLinkRequest
    private let jwtToken: String

    init(
        createLinkService: CreateLinkServiceType,
        trackService: TrackServiceProtocol,
        request: CreateLinkRequest,
        jwtToken: String
    ) {
        self.createLinkService = createLinkService
        self.trackService = trackService
        self.request = request
        self.jwtToken = jwtToken
    }
}

extension ShareGiftInteractor: ShareGiftInteractorProtocol {
    func getCreateLink(
        request: CreateLinkRequest,
        completion: @escaping (CreateLinkResponse?, WebError?) -> ()
    ) {
        createLinkService.createLink(
            request: request,
            completion: completion
        )
    }

    func trackClickGenerateShareLink() {
        let parameters: [TrackParameter] = [
            partnerParameters(),
            contentParameters(),
            subscriberParameters()
        ]

        trackService.trackEvent(
            event: .clickGenerateShareLink,
            parameters: parameters
        )
    }

    func trackViewShareDetails(url: String, giftsLeft: Int) {
        let parameters: [TrackParameter] = [
            partnerParameters(),
            contentParameters(),
            subscriberParameters(),
            shareLinkParameters(url: url),
            .custom(["number_credits_left" : String(giftsLeft)])
        ]

        trackService.trackEvent(
            event: .viewShareDetailsModel,
            parameters: parameters
        )
    }

    func trackViewExceededQuotaError() {
        let parameters: [TrackParameter] = [
            partnerParameters(),
            contentParameters(),
            subscriberParameters()
        ]

        trackService.trackEvent(
            event: .viewExceededQuotaError,
            parameters: parameters
        )
    }

    func trackClickChooseShareMedium(url: String, type: String) {
        let parameters: [TrackParameter] = [
            partnerParameters(),
            contentParameters(),
            subscriberParameters(),
            shareLinkParameters(url: url),
            .custom(["share_medium": type])
        ]

        trackService.trackEvent(
            event: .clickChooseShareMedium,
            parameters: parameters
        )
    }
}

private extension ShareGiftInteractor {
    func partnerParameters() -> TrackParameter {
        .partner(.init(jwt: jwtToken))
    }

    func contentParameters() -> TrackParameter {
        .content(.init(request: request, jwtToken: jwtToken))
    }

    func subscriberParameters() -> TrackParameter {
        .subscriber(.init(request: request))
    }

    func shareLinkParameters(url: String) -> TrackParameter {
        .shareLink(.init(shareLinkUrl: url, shareLinkHash: (url as NSString).lastPathComponent))
    }
}
