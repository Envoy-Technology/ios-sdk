import UIKit

class GiftButton: UIButton {

    var trackService: TrackService?
    var jwtToken: String?
    var request: CreateLinkRequest?

    public override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }

    func initialize() {
        setupUI()
        trackLoadGiftButton()
    }

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        trackViewGiftButton()
    }
}

private extension GiftButton {
    func setupUI() {
        setTitle("", for: .normal)
        setImage(
            UIImage(named: "ic_gift_button", in: Bundle.envoyBundle, with: nil),
            for: .normal
        )
        backgroundColor = .white
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 64),
            widthAnchor.constraint(equalToConstant: 64)
        ])
        layer.cornerRadius = 32
    }

    func partnerParameters() -> TrackParameter? {
        jwtToken.flatMap { .partner(.init(jwt: $0)) }
    }

    func contentParameters() -> TrackParameter? {
        guard let request = request, let jwtToken = jwtToken else {
            return nil
        }
        return .content(.init(request: request, jwtToken: jwtToken))
    }

    func subscriberParameters() -> TrackParameter? {
        request.flatMap { .subscriber(.init(request: $0)) }
    }

    func trackLoadGiftButton() {
        let parameters: [TrackParameter] = [
            partnerParameters(),
            contentParameters(),
            subscriberParameters()
        ].compactMap { $0 }

        trackService?.trackEvent(
            event: .loadGiftButton,
            parameters: parameters
        )
    }

    func trackViewGiftButton() {
        let parameters: [TrackParameter] = [
            partnerParameters(),
            contentParameters(),
            subscriberParameters()
        ].compactMap { $0 }

        trackService?.trackEvent(
            event: .viewGiftButton,
            parameters: parameters
        )
    }
}
