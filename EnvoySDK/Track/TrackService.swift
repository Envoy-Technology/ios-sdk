import Mixpanel

protocol TrackServiceProtocol {
    func trackEvent(event: TrackEvent, parameters: [TrackParameter])
}

class TrackService: TrackServiceProtocol {
    private let trackService = Mixpanel.mainInstance()
    private let jwtToken: String

    init(jwtToken: String) {
        self.jwtToken = jwtToken
    }

    var defaultParameters: [String : String] {
        let decoded = JWTDecode().decode(jwtToken: jwtToken)
        let orgId = decoded["jti"] as? String ?? ""
        return [
            "user_id" : "\(orgId)#\(trackService.distinctId)",
            "user_type" : "subscriber",
            "version" : "1.0"
        ]
    }

    func trackEvent(event: TrackEvent, parameters: [TrackParameter]) {
        var parameters = parameters
            .compactMap { $0.asParameters }
            .flatMap { $0 }
            .reduce([String:String]()) { (dict, tuple) in
                var dict = dict
                dict.updateValue(tuple.1, forKey: tuple.0)
                return dict
            }

        defaultParameters.forEach { key, value in
            parameters.updateValue(value, forKey: key)
        }

        trackService.track(
            event: event.rawValue,
            properties: parameters
        )
        print(" event: \(event.rawValue) parameters: \(parameters)")
    }
}
