import Foundation

struct CustomError: Error, Decodable {
    var details: String
}
