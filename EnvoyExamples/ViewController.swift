import UIKit
import EnvoySDK

class ViewController: UIViewController {

    private let apiKey = "eyJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE2NTQ2OTAwMzUsImlzcyI6IkVudm95IFBsYXRmb3JtIiwianRpIjoiYzUzOTlmNjMtZTI2Mi00YjQ0LTk3M2MtYTcwNTA3YmU5ZmNiIiwibGlua19xdW90YSI6MTAwLCJvcmdfbmFtZSI6IkRldmVsdXgiLCJzYW5kYm94X2xpbmtfcXVvdGEiOjEwMH0.RfWBPrFVJgxOrlxPR4ZgifEVhlbdNGrVENsfRJHQXuqj2GDMHRXXMfTctv5FwA5FIZjmFhRcg6CmhaRkyYaFqA"

    lazy var envoySDK = Envoy(apiKey: apiKey)

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func giftAction(_ sender: Any) {
        let createLinkRequest = CreateLinkRequest(
            userId: "3",
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
        envoySDK.presentShareGift(
            from: self,
            createLinkRequest: createLinkRequest
        )
//        if let navigationController = navigationController {
//            envoySDK.pushShareGift(in: navigationController)
//        }
    }
}

