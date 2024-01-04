import Foundation

fileprivate struct MappingKeys {
    static let authorization = "x-api-key"
}

protocol GetUserRemainingQuotaServiceType {
    @discardableResult
    func getUserQuota(userId: String,
                      completion: @escaping (UserQuotaResponse?, WebError?) -> ()) -> URLSessionDataTask?
}

final class GetUserRemainingQuotaService {

    private let client: WebClient
    private let token: String

    init(client: WebClient, token: String) {
        self.client = client
        self.token = token
    }
}

extension GetUserRemainingQuotaService: GetUserRemainingQuotaServiceType {
    @discardableResult
    func getUserQuota(userId: String,
                      completion: @escaping (UserQuotaResponse?, WebError?) -> ()) -> URLSessionDataTask? {
        let path = Endpoint.getUerRemainingQuota(userId: userId).path
        let headers = [MappingKeys.authorization : "\(token)"]
        let resource = Resource<UserQuotaResponse>(
            path: path,
            method: .get,
            headers: headers
        )
        return client.load(resource: resource) { (response) in
            DispatchQueue.main.async {
                completion(response.value, response.error)
            }
        }
    }
}
