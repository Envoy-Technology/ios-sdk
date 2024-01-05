import Foundation

public enum WebError: Error {
    case noInternetConnection
    case custom(CustomError)
    case unauthorized
    case other
}

extension WebError {
    var message: String {
        switch self {
        case .noInternetConnection:
            return "No Internet Connection"
        case let .custom(error):
            return error.details
        case .unauthorized:
            return "Unauthorized"
        case .other:
            return "Unexpected error"
        }
    }
}
