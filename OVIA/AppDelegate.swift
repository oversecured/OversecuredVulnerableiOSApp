import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if Auth.auth().signedIn {
            let mainViewController = MainViewController.styled
            let deeplink = launchOptions?[.url] as? URL
            mainViewController.set(deeplink: deeplink)
            window?.rootViewController = mainViewController
        }
        else {
            let loginViewController = LoginViewController.styled
            window?.rootViewController = loginViewController
        }
        window?.makeKeyAndVisible()
        return true
    }
}
