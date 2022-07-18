import UIKit
import EnvoySDK

class ViewController: UIViewController {

    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var stackView: UIStackView!

    private lazy var envoySDK = Envoy(
        baseURL: Environments.baseURL,
        apiKey: Environments.apiKey
    )
    private lazy var giftButton = envoySDK.giftButton(request: request)
    private var request: CreateLinkRequest {
        .init(
            userId: "11",
            contentConfig: .init(
                contentType: "VIDEO",
                contentName: "Amazing content",
                contentDescription: "Some amazing description",
                contentId: "1",
                common: .init(
                    media: .init(
                        source: "https://contents.pallycon.com/bunny/stream.mpd",
                        poster: "https://images.unsplash.com/photo-1485846234645-a62644f84728?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1159&q=80"
                    )
                )
            )
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.addArrangedSubview(giftButton)
        giftButton.addTarget(self, action: #selector(giftAction(_:)), for: .touchUpInside)
    }

    @IBAction func giftAction(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            envoySDK.presentShareGift(
                from: self,
                request: request
            )
        default:
            envoySDK.pushShareGift(
                in: self.navigationController!,
                request: request
            )
        }
    }
}

