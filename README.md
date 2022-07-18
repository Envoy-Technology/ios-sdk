<a name="introduction"></a>
# Overview

Envoy iOS SDK aimed to deliver a fast solution to share content out of the iOS Application.

> **Authorization and Mixpanel usage**: For now ios-sdk has outdated in mentioned parts

# Quick Start Guide

## 1. Install Envoy SDK
You can install the Envoy iOS SDK - Swift library by using CocoaPods. You will need your project token for initializing your library. You can get your project token from [account settings](https://dev-platform.envoy.is/dashboard/account/).

### Installation CocoaPods
1. If this is your first time using CocoaPods, Install CocoaPods using `gem install cocoapods`. Otherwise, continue to Step 3.
2. Run `pod setup` to create a local CocoaPods spec mirror.
3. Create a Podfile in your Xcode project directory by running `pod init` in your terminal, edit the Podfile generated, and add the following line: `pod 'EnvoySDK'`.
4. Run `pod install` in your Xcode project directory. CocoaPods should download and install the EnvoySDK library, and create a new Xcode workspace. Open up this workspace in Xcode or typing `open *.xcworkspace` in your terminal.

## 2. Initialize EnvoySDK
To initialize the library, add `import EnvoySDK` into `AppDelegate` and call `initialize()` in [application:didFinishLaunchingWithOptions:](https://developer.apple.com/documentation/uikit/uiapplicationdelegate#//apple_ref/occ/intfm/UIApplicationDelegate/application:willFinishLaunchingWithOptions:)
```swift
import EnvoySDK

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
...
  Envoy.initialize()
...
}
```

## 3. Configure `CreateLinkRequest`

You need to configure `CreateLinkRequest` with content, which you wanted to be shared. Request is pretty flexible and have both required and optional values.

```swift
struct CreateLinkRequest {
    let userId: String
    let contentConfig: ContentConfig
    let linkPreview: LinkPreview?
    let autoplay: Bool?
    let extra: [String : String]?
}

struct ContentConfig {
    let contentType: String
    let contentName: String
    let contentDescription: String
    let contentId: String
    let common: Common
}

struct Common {
    let media: Media
}

struct Media {
    let source: String
    let poster: String
}

struct LinkPreview {
    let title: String
    let linkPreviewDescription: String
    let image: String
}
```

## 4. Add Gift Button (Optional)

SDK gives ability to add gift button with SDK design for quick implementation.

```swift
let button = envoySDK.giftButton(request: request)
buttin.addTarget(self, action: #selector(giftAction), for: .touchUpInside)
containerView.addSubview(button)
```

## 5. Present Share Screen

To present share screen you need to initialize instance of `Envoy` with `apiKey`. You can get your project token from [account settings](https://dev-platform.envoy.is/dashboard/account/).
Upon tapping on share button you need to call any of these methods.
* `func presentShareGift(from viewController: UIViewController, request: CreateLinkRequest)`
* `func pushShareGift(in navigationController: UINavigationController, request: CreateLinkRequest)`

```swift
import EnvoySDK

class ViewController: UIViewController {
  ...
  func giftAction() {
      envoySDK.presentShareGift(from: self, request: request)
  }
  ...
}
```
