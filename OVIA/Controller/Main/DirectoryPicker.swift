import UIKit
import UniformTypeIdentifiers

class DirectoryPicker: NSObject {
    private let viewController: UIViewController
    private var handler: ((URL?) -> Void)!
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func pick(handler: @escaping (URL?) -> Void) {
        self.handler = handler
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.folder])
        documentPicker.delegate = self
        self.viewController.present(documentPicker, animated: true)
    }
}

extension DirectoryPicker: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        self.handler(urls.first)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        self.handler(nil)
    }
}
