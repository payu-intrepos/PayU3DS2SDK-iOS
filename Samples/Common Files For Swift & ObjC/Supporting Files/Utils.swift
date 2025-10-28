//
//  Utils.swift
//  PayU3DS2SwiftSampleApp
//
//  Created by Amit Salaria on 17/08/23.
//

import CommonCrypto
import Foundation
import UIKit

class Utils {
    // For testing purpose only
    class func sha512Hex(string: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        if let data = string.data(using: String.Encoding.utf8) {
            let value = data as NSData
            CC_SHA512(value.bytes, CC_LONG(data.count), &digest)
        }
        var digestHex = ""
        for index in 0 ..< Int(CC_SHA512_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        return digestHex
    }
    
    class func getDataOfImage(string: String) -> Data? {
        if let url = URL(string: string) {
            let data = try? Data(contentsOf: url)
            return data
        }
        return nil
    }
}

extension UIImageView {

    func loadImage(with string: String) {
        image = nil
        DispatchQueue.global().async {
            guard let url = URL(string: string) else { return }
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let imageData = data else { return }
                DispatchQueue.main.async {
                    self?.image = UIImage(data: imageData)
                }
            }.resume()
        }
    }

}

extension Date {
    var dateString:String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
}
