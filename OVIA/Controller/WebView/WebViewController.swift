import WebKit

class WebViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    
    private var url: URL!
    
    private var extraHeaders: [String : String] {
        guard let token = UserSettings.userSettings().token else {
            return [:]
        }
        return ["Authorization" : token]
    }
    
    private var request: URLRequest {
        var request = URLRequest(url: url)
        self.extraHeaders.forEach{ name, value in
            request.setValue(value, forHTTPHeaderField: name)
        }
        return request
    }
    
    func set(url: URL) {
        self.url = url
    }
    
    override func loadView() {
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences.allowsContentJavaScript = true
        
        webView = WKWebView(frame: .zero, configuration: config)
        webView.allowsBackForwardNavigationGestures = true
        webView.configuration.preferences.setValue(true, forKey: "developerExtrasEnabled")
        view = webView
        
        webView.load(self.request)
    }
}
