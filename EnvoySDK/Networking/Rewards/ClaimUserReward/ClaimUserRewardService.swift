import Foundation

fileprivate struct MappingKeys {
    static let authorization = "x-api-key"
}

protocol ClaimUserRewardServiceType {
    @discardableResult
    func claimUserReward(request: ClaimUserRewardRequest,
                         completion: @escaping (ClaimUserRewardResponse?, WebError?) -> ()) -> URLSessionDataTask?
}

final class ClaimUserRewardService {
    
    private let client: WebClient
    private let token: String
    
    init(client: WebClient, token: String) {
        self.client = client
        self.token = token
    }
}

extension ClaimUserRewardService: ClaimUserRewardServiceType {
    @discardableResult
    func claimUserReward(request: ClaimUserRewardRequest,
                         completion: @escaping (ClaimUserRewardResponse?, WebError?) -> ()) -> URLSessionDataTask? {
        let path = Endpoint.claimUserReward.path
        let headers = [MappingKeys.authorization : "\(token)"]
        let resource = Resource<ClaimUserRewardResponse>(
            path: path,
            method: .post,
            params: request.asJSON(keyEncodingStrategy: .useDefaultKeys) ?? [:],
            headers: headers
        )
        return client.load(resource: resource) { (response) in
            DispatchQueue.main.async {
                completion(response.value, response.error)
            }
        }
    }
}

