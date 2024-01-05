import UIKit
import EnvoySDK

class ViewController: UIViewController {

    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var stackView: UIStackView!

    private lazy var envoySDK = Envoy(
        baseURL: Environments.baseURL,
        token: Environments.apiKey
    )
    private lazy var giftButton = envoySDK.giftButton(request: generateDummyData())

    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.addArrangedSubview(giftButton)
        giftButton.addTarget(self, action: #selector(giftAction(_:)), for: .touchUpInside)
        
//        let request = LogPixelEventRequest(eventName: "Test event",
//                                           userId: "11",
//                                           sharerUserId: "11",
//                                           shareLinkHash: "abcd",
//                                           extra: LogPixelEventRequest.Extra(campaign: "campaign",
//                                                                             userType: "userType"))
//        envoySDK.logPixelEvent(request: request) { response, error in
//            print(response)
//            print(error)
//        }
        
//        let request = ClaimUserRewardRequest(userId: "11", paypalReceiver: "abcd")
//        envoySDK.claimUserReward(request: request) { response, error in
//            print(response)
//            print(error)
//        }
//        
//        envoySDK.getUserRemainingQuota(userId: "1") { response, error in
//            print(response)
//            print(error)
//        }
        envoySDK.getUserRewards(userId: "1") { response, error in
            print(response)
            print(error)
        }
//        envoySDK.getUserCurrentRewards(userId: "11") { response, error in
//            print(response)
//            print(error)
//        }
    }

    @IBAction func giftAction(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            envoySDK.presentShareGift(
                from: self,
                request: generateDummyData()
            )
        default:
            envoySDK.pushShareGift(
                in: self.navigationController!,
                request: generateDummyData()
            )
        }
    }
    
    // Function to generate dummy data for YourModel
    func generateDummyData() -> CreateLinkRequest {
        let common = CreateLinkRequest.Common(source: "https://example.com/video.mp4", sourceIsRedirect: false, poster: "https://example.com/poster.jpg")
        let contentSetting = CreateLinkRequest.ContentSetting(contentType: "video",
                                            contentName: "Dummy Video",
                                            contentDescription: "This is a dummy video",
                                            common: common,
                                            timeLimit: 120,
                                            timeStart: 0,
                                            availableFrom: "2023-12-13T07:58:20.020Z",
                                            availableTo: "2023-12-14T07:58:20.020Z",
                                            videoOrientation: 0,
                                            previewTitle: "Dummy Preview",
                                            previewDescription: "This is a preview of the content",
                                            previewImage: "https://example.com/preview.jpg",
                                            isSandbox: true,
                                            mandatoryEmail: false,
                                            modalTitle: "Modal Title",
                                            buttonText: "Play",
                                            contentProtection: nil)
        
        let labels = [CreateLinkRequest.Label(id: 1, text: "Entertainment", color: "blue"),
                      CreateLinkRequest.Label(id: 2, text: "Featured", color: "red")]
        
        return CreateLinkRequest(autoplay: true,
                         contentSetting: contentSetting,
                         lifespanAfterClick: nil,
                         openQuota: 10,
                         extra: nil,//"Some extra information",
                         title: "Dummy Content",
                         sharerId: "user125",
                         isSandbox: true,
                         labels: labels)
    }
}

