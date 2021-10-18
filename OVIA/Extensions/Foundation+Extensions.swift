import Foundation

extension FileManager {
    class func documentsUrlForFile(withName name: String) -> URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documents.appendingPathComponent(name)
    }
}

extension NSAttributedString {
    convenience init?(htmlString: String) {
        guard let data = htmlString.data(using: .utf8) else { return nil }
        guard let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
            return nil
        }
        self.init(attributedString: attributedString)
    }
}
