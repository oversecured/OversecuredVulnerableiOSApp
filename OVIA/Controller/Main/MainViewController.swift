import UIKit

class MainViewController: UIViewController {
    private var directoryPicker: DirectoryPicker!
    private var deeplink: URL?
    
    static var styled: MainViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "mainStoryboard") as! MainViewController
    }
    
    func set(deeplink: URL?) {
        self.deeplink = deeplink
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let deeplink = deeplink {
            handleDeeplink(deeplink)
        }
    }
    
    @IBAction func signOutAction(_ sender: UIButton) {
        Auth.auth().signOut()
        
        let loginViewController = LoginViewController.styled
        present(loginViewController, animated: true)
    }
    
    @IBAction func dumpDataAction(_ sender: UIButton) {
        directoryPicker = DirectoryPicker(self)
        directoryPicker.pick{ url in
            guard let url = url else {
                return
            }
            Files.dumpCacheFile(to: url)
        }
    }
    
    private func handleDeeplink(_ url: URL) {
        let route = url.lastPathComponent
        if route == "alert", let text = getQueryParameter(url, "message"), let message = NSAttributedString(htmlString: text) {
            Alert(title: "Alert!", message: message).display(from: self)
        }
        else if route == "webview", let urlParam = getQueryParameter(url, "url"), let url = URL(string: urlParam) {
            let webVc = WebViewController()
            webVc.set(url: url)
            present(webVc, animated: true)
        }
        else if route == "save",
                let dataParam = getQueryParameter(url, "data"),
                var data = Data(base64Encoded: dataParam),
                let name = getQueryParameter(url, "name") {
            
            if let offsetParam = getQueryParameter(url, "offset"), let offset = Int(offsetParam) {
                let arr = [UInt8](data)
                data = Data(bytes: &data + offset, count: arr.count - offset)
            }
            
            try! data.write(to: FileManager.documentsUrlForFile(withName: name))
        }
    }
    
    func getQueryParameter(_ url: URL, _ name: String) -> String? {
        if let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true), let params = components.queryItems {
            if let value = params.first(where: { $0.name == name })?.value {
                return value
            }
        }
        return nil
    }
}
