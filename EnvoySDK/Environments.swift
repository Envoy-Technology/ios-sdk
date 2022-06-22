import Foundation

enum Environments: String {
    static let currentEnvironment = Environments.dev
    
    case dev = "https://uwek2gofcc.execute-api.eu-west-2.amazonaws.com/dev/partner/"
    case stage = "https://dev-platform.envoy.is/"
    case prod = "replace2" // TODO: replace with real prod
}

extension Environments {
    var mixpanelToken: String {
        switch self {
        case .dev:
            return "6b1f10ff32148b2db98a00b23c2465d9"
        case .stage:
            return "95a547d8fdb8e9c993c2157f84e5beaa"
        case .prod:
            return "f69c5a8d4c559b7ed2a0e39554458a6c"
        }
    }
}
