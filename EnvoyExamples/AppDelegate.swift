import UIKit
import SwiftUI
import EnvoySDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let envoyConfig = EnvoyConfigSDK(apiKey: Config.apiKey, notifyWhenScreenshotTaken: true)
        Envoy.initialize(config: envoyConfig, delegate: self)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate: EnvoyProtocol {
    func userDidTakeScreenshot() {
        guard let navigationController = UIApplication.shared.rootViewController,
              let hostVC = UIApplication.shared.topViewController(controller: navigationController) as? UIHostingController<ContentView>,
              let topView = hostVC.rootView as? EnvoyEventProtocol else {
            return
        }
        topView.createLink()
    }
}
