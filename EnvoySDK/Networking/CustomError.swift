import Foundation

public struct CustomError: Error, Decodable {
    var details: String
}
