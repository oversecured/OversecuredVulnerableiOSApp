import Foundation
class Auth {
    private static let instance = Auth()
    
    private let settings = UserSettings.userSettings()
    
    var signedIn: Bool {
        return settings.signedIn
    }
    
    private init() {
    }
    
    static func auth() -> Auth {
        return instance
    }
    
    func singIn(withEmail email: String, password: String, handler: @escaping (Result<String, Error>) -> Void) {
        let network = NetworkCalls.networkCalls()
        network.auth(SignInModel(email: email, password: password)) { result in
            if case .success(let token) = result {
                self.settings.token = token
            }
            handler(result)
        }
    }
    
    func signOut() {
        self.settings.token = nil
    }
}

struct AuthError: Error {
}
