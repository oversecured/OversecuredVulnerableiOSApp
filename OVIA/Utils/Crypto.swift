import Foundation
import CommonCrypto

fileprivate let aesKey = "gEKC8qte1FvR3oJV"
fileprivate let iv = "MFQOKFtxfibUuDWo"

class Crypto {
    private static let aesInstance = AESCrypto(key: aesKey, iv: iv)
    
    private init() {
    }
    
    static func encrypt(_ string: String) -> String {
        return aesInstance.encrypt(string: string).base64EncodedString()
    }
    
    static func decrypt(_ data: String) -> String {
        return aesInstance.decrypt(data: Data(base64Encoded: data)!)
    }
}

fileprivate class AESCrypto {
    private let key: Data
    private let iv: Data
    
    init(key: String, iv: String) {
        guard key.count == kCCKeySizeAES128, let keyData = key.data(using: .utf8) else {
            preconditionFailure("Error: Failed to set a key")
        }
        guard iv.count == kCCBlockSizeAES128, let ivData = iv.data(using: .utf8) else {
            preconditionFailure("Error: Failed to set an initial vector")
        }
        self.key = keyData
        self.iv  = ivData
    }
    
    func encrypt(string: String) -> Data {
        let data = string.data(using: .utf8)!
        return crypt(data: data, option: CCOperation(kCCEncrypt))
    }

    func decrypt(data: Data) -> String {
        let decryptedData = crypt(data: data, option: CCOperation(kCCDecrypt))
        return String(bytes: decryptedData, encoding: .utf8)!
    }

    func crypt(data: Data, option: CCOperation) -> Data {
        let cryptLength = data.count + kCCBlockSizeAES128
        var cryptData   = Data(count: cryptLength)

        let keyLength = key.count
        let options   = CCOptions(kCCOptionPKCS7Padding)

        var bytesLength = Int(0)

        let status = cryptData.withUnsafeMutableBytes { cryptBytes in
            data.withUnsafeBytes { dataBytes in
                iv.withUnsafeBytes { ivBytes in
                    key.withUnsafeBytes { keyBytes in
                        CCCrypt(option, CCAlgorithm(kCCAlgorithmAES), options, keyBytes.baseAddress, keyLength, ivBytes.baseAddress, dataBytes.baseAddress, data.count, cryptBytes.baseAddress, cryptLength, &bytesLength)
                    }
                }
            }
        }

        guard UInt32(status) == UInt32(kCCSuccess) else {
            preconditionFailure("Error: Failed to crypt data. Status \(status)")
        }

        cryptData.removeSubrange(bytesLength..<cryptData.count)
        return cryptData
    }
}
