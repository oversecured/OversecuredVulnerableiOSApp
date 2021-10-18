import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let spinner = SpinnerViewController()
    
    static var styled: LoginViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "loginStoryboard") as! LoginViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        self.emailTextField.markCorrect()
        self.passwordTextField.markCorrect()
        
        guard let email = self.emailTextField.text, !email.isEmpty else {
            self.emailTextField.markIncorrect()
            return
        }
        guard let password = self.passwordTextField.text, !password.isEmpty else {
            self.passwordTextField.markIncorrect()
            return
        }
        
        spinner.display(for: self)
        
        Auth.auth().singIn(withEmail: email, password: password) { result in
            self.spinner.hide()
            
            switch result {
            case .failure(_): Alert(title: "Error", message: "Incorrect credentials").display(from: self)
            case .success(_):
                self.dismiss(animated: true) {
                    let mainController = MainViewController.styled
                    self.present(mainController, animated: true)
                }
            }
        }
    }
}

