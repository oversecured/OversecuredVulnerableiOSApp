import Foundation

fileprivate let serverUrlKey = "serverUrl"
fileprivate let tokenKey = "token"

class UserSettings {
    private static let instance = UserSettings()
    
    private let defaults = UserDefaults.standard
    
    var token: String? {
        get {
            return defaults.string(forKey: tokenKey)
        }
        set {
            if let newValue = newValue {
                defaults.set(newValue, forKey: tokenKey)
            }
            else {
                defaults.removeObject(forKey: tokenKey)
            }
            defaults.synchronize()
        }
    }
    
    var signedIn: Bool {
        return token != nil
    }
    
    private init() {
    }
    
    static func userSettings() -> UserSettings {
        return instance
    }
}
