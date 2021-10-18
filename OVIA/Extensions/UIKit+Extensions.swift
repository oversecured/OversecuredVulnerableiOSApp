import UIKit

extension UITextField {
    func markCorrect() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0
    }
    
    func markIncorrect() {
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1.0
    }
}
