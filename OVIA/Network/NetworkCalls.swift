import Alamofire

fileprivate let serverUrl = URL(string: "http://example.com.")!

class NetworkCalls {
    private static let instance = NetworkCalls()
    
    private let settings = UserSettings.userSettings()
    
    private init() {
    }
    
    static func networkCalls() -> NetworkCalls {
        return instance
    }
    
    func auth(_ info: SignInModel, handler: @escaping (Result<String, Error>) -> Void) {
        let request = AF.request(serverUrl, method: .post, parameters: info)
        request.responseString { response in
            if response.response?.statusCode == 200 {
                let userData = "\(info.email):\(info.password)"
                let token = Crypto.encrypt(userData)
                handler(.success(token))
            }
            else {
                handler(.failure(AuthError()))
            }
        }
    }
}
