import Foundation

fileprivate struct MappingKeys {
    static let authorization = "x-api-key"
}

protocol GetUserCurrentRewardsServiceType {
    @discardableResult
    func getUserCurrentRewards(
        userId: String,
        completion: @escaping (UserCurrentRewardsResponse?, WebError?) -> ()) -> URLSessionDataTask?
}

final class GetUserCurrentRewardsService {

    private let client: WebClient
    private let token: String

    init(client: WebClient, token: String) {
        self.client = client
        self.token = token
    }
}

extension GetUserCurrentRewardsService: GetUserCurrentRewardsServiceType {
    @discardableResult
    func getUserCurrentRewards(
        userId: String,
        completion: @escaping (UserCurrentRewardsResponse?, WebError?) -> ()) -> URLSessionDataTask? {
        let path = Endpoint.getUserCurrentRewards(userId: userId).path
        let headers = [MappingKeys.authorization : "\(token)"]
        let resource = Resource<UserCurrentRewardsResponse>(
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
