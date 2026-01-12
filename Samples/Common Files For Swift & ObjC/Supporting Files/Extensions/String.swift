//
//  String.swift
//  PayU3DS2SwiftSample
//
//  Created by Amit Salaria on 26/08/23.
//

import Foundation

extension String {
    var maskedCardNumber: String {
        let initial4Characters = String(prefix(4))
        let last4Characters = String(suffix(4))
        guard count > 8 else {
            return initial4Characters + last4Characters
        }
        let mask = Array(repeating: "*", count: count - 8).joined()
        return initial4Characters + mask + last4Characters
    }
}
