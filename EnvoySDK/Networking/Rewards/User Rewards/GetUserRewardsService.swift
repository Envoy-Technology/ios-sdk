import Foundation

fileprivate struct MappingKeys {
    static let authorization = "x-api-key"
}

protocol GetUserRewardsServiceType {
    @discardableResult
    func getUserRewards(userId: String,
                        completion: @escaping (UserRewardsResponse?, WebError?) -> ()) -> URLSessionDataTask?
}

final class GetUserRewardsService {

    private let client: WebClient
    private let token: String

    init(client: WebClient, token: String) {
        self.client = client
        self.token = token
    }
}

extension GetUserRewardsService: GetUserRewardsServiceType {
    @discardableResult
    func getUserRewards(userId: String,
                        completion: @escaping (UserRewardsResponse?, WebError?) -> ()) -> URLSessionDataTask? {
        let path = Endpoint.getUserRewards(userId: userId).path
        let headers = [MappingKeys.authorization : "\(token)"]
        let resource = Resource<UserRewardsResponse>(
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
