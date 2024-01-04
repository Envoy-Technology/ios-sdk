import Foundation

fileprivate struct MappingKeys {
    static let authorization = "x-api-key"
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
    private let token: String

    init(
        client: WebClient,
        token: String
    ) {
        self.client = client
        self.token = token
    }
}

extension CreateLinkService: CreateLinkServiceType {
    @discardableResult
    func createLink(
        request: CreateLinkRequest,
        completion: @escaping (CreateLinkResponse?, WebError?) -> ()
    ) -> URLSessionDataTask? {
        let path = Endpoint.createLink.path
        let headers = [MappingKeys.authorization : "\(token)"]
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
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        guard let data = try? encoder.encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
