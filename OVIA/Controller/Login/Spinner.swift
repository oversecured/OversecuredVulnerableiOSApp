import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func display(for vc: UIViewController) {
        vc.addChild(self)
        self.view.frame = vc.view.frame
        vc.view.addSubview(self.view)
        didMove(toParent: vc)
    }
    
    func hide() {
        willMove(toParent: nil)
        self.view.removeFromSuperview()
        removeFromParent()
    }
}
