import Foundation

enum Environments: String {
    static let currentEnvironment = Environments.dev
    
    case dev = "https://uwek2gofcc.execute-api.eu-west-2.amazonaws.com/dev/partner/"
    case prod = "" // TODO: replace with real prod
}
