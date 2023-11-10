//
//  Utils.swift
//  PayU3DS2SwiftSampleApp
//
//  Created by Amit Salaria on 17/08/23.
//

import CommonCrypto
import Foundation

class Utils {
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
}
