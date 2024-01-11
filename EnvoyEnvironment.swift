//
//  EnvoyEnvironment.swift
//  EnvoySDK
//
//  Created by Bianca Felecan on 05.01.2024.
//

import Foundation

public enum EnvoyEnvironment {
    case dev
    case prod
    
    var apiUrl: String {
        switch self {
        case .dev:
            return "https://dev-api.envoy.is/partner/"
        case .prod:
            return "https://api.envoy.is/partner/"
        }
    }
}
