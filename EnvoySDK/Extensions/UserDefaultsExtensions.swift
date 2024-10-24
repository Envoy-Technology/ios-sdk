//
//  UserDefaultsExtensions.swift
//  EnvoySDK
//
//  Created by Bianca Felecan on 03.01.2024.
//

import Foundation

extension UserDefaults {
    
    private struct Keys {
        static let isFreshInstall = "isFreshInstall"
        static let notifyScreenShot = "notifyScreenShot"
    }
    
    // MARK: Fresh install
    var isFreshInstall: Bool {
        let stored = value(forKey: Keys.isFreshInstall) as? Bool
        return stored ?? true
    }

    func set(isFreshInstall: Bool) {
        set(isFreshInstall, forKey: Keys.isFreshInstall)
    }

}
