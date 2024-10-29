import UIKit

extension UIApplication {
    var mainKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap { $0 as? UIWindowScene }?.windows
            .first(where: \.isKeyWindow)
    }

    var rootViewController: UIViewController? {
        guard let keyWindow = UIApplication.shared.mainKeyWindow,
              let rootViewController = keyWindow.rootViewController else {
            return nil
        }
        return rootViewController
    }

    func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        if controller == nil {
            return topViewController(controller: rootViewController)
        }

        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }

        if let tabController = controller as? UITabBarController,
           let selectedViewController = tabController.selectedViewController {
            return topViewController(controller: selectedViewController)
        }

        if let presentedViewController = controller?.presentedViewController {
            return topViewController(controller: presentedViewController)
        }

        return controller
    }
}

extension UIImage {
    var base64: String? {
        self.jpegData(compressionQuality: 0.1)?.base64EncodedString()
    }
}
