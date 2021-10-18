import UIKit

class Alert {
    private let alertView: UIAlertController
    
    init(title: String, message: String) {
        self.alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
    
    init(title: String, message: NSAttributedString) {
        self.alertView = UIAlertController(title: title, message: "", preferredStyle: .alert)
        self.alertView.setValue(message, forKey: "attributedMessage")
        self.alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
    
    func display(from viewController: UIViewController) {
        viewController.present(self.alertView, animated: true)
    }
}
