import Foundation

fileprivate struct MappingKeys {
    static let authorization = "x-api-key"
}

protocol LogPixelEventServiceType {
    @discardableResult
    func logPixelEvent(request: LogPixelEventRequest,
                       completion: @escaping (EmptyResponse?, WebError?) -> ()) -> URLSessionDataTask?
}

final class LogPixelEventService {
    
    private let client: WebClient
    private let token: String
    
    init(client: WebClient, token: String) {
        self.client = client
        self.token = token
    }
}

extension LogPixelEventService: LogPixelEventServiceType {
    @discardableResult
    func logPixelEvent(request: LogPixelEventRequest,
                       completion: @escaping (EmptyResponse?, WebError?) -> ()) -> URLSessionDataTask? {
        let path = Endpoint.logPixelEvent.path
        let headers = [MappingKeys.authorization : "\(token)"]
        let resource = Resource<EmptyResponse>(
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
