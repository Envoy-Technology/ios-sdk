import UIKit

struct ShareGiftViewState {
    var error: String?
    var response: CreateLinkResponse?

    var message: String {
        if let response = response {
            return String(format: "%i gifts left", response.userRemainingQuota)
        } else if let error = error {
            return error
        }
        return ""
    }

    var isSharePossible: Bool {
        !(response?.url.isEmpty ?? true)
    }
}
