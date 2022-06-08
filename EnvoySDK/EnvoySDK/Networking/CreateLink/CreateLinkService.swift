import Foundation

fileprivate struct MappingKeys {
    static let authorization = "Authorization"
}

protocol CreateLinkServiceType {
    @discardableResult
    func createLink(
        request: CreateLinkRequest,
        completion: @escaping (CreateLinkResponse?, WebError?) -> ()
    ) -> URLSessionDataTask?
}

final class CreateLinkService {

    private let client: WebClient
    private let authToken: String

    init(client: WebClient,
         authToken: String
    ) {
        self.client = client
        self.authToken = authToken
    }
}

extension CreateLinkService: CreateLinkServiceType {
    @discardableResult
    func createLink(
        request: CreateLinkRequest,
        completion: @escaping (CreateLinkResponse?, WebError?) -> ()
    ) -> URLSessionDataTask? {
        let path = Endpoint.createLink.rawValue
        let headers = [MappingKeys.authorization : "Bearer \(authToken)"]
        let resource = Resource<CreateLinkResponse>(
            path: path,
            method: .post,
            params: request.asJSON ?? [:],
            headers: headers
        )
        return client.load(resource: resource) { (response) in
            DispatchQueue.main.async {
                completion(response.value, response.error)
            }
        }
    }
}

extension Encodable {
    var asJSON: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
