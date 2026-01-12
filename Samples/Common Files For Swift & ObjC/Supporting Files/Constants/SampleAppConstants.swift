//
//  Constants.swift
//  PayU3DS2SwiftSample
//
//  Created by Amit Salaria on 25/08/23.
//

import Foundation

@objc class SampleAppConstants: NSObject {
    @objc static let key = "key"
    @objc static let salt = "salt"
    @objc static let transactionId = "transactionId"
    @objc static let amount = "amount"
    @objc static let email = "email"
    @objc static let cardNumber = "cardNumber"
    @objc static let cardExpiryMonth = "cardExpiryMonth"
    @objc static let cardExpiryYear = "cardExpiryYear"
    @objc static let saveCard = "saveCard"
    @objc static let cardName = "cardName"
    @objc static let cvv = "cvv"
    @objc static let cardToken = "cardToken"
    @objc static let networkToken = "networkToken"
    @objc static let cardTokenType = "cardTokenType"
    @objc static let additionalParam = "additionalParam"
    @objc static let last4Digits = "last4Digits"
    @objc static let tavv = "tavv"
    @objc static let trid = "trid"
    @objc static let tokenRefNo = "tokenRefNo"
    @objc static let userCredential = "userCredential"
    @objc static let cardHash = "card_hash"
    @objc static let bankcode = "bankcode"
    @objc static let hashString = "hashString"
    @objc static let hashName = "hashName"
    @objc static let transactionStatus = "transactionStatus"
    @objc static let mfaRegistrationStatus = "mfaRegistrationStatus"
    @objc static let mfaRegistrationStatusInProgress = "mfa_registration_in_progress"
    @objc static let mfaRegistrationStatusSuccess = "mfa_registration_success"
    @objc static let paymentResponse = "payment_response"
    @objc static let partnerWebhookFailure = "partner_webhook_failure"
    @objc static let partnerWebhookSuccess = "partner_webhook_success"
    
    @objc static let pg = "pg"
    @objc static let bankCode = "bankCode"
    
    // SI keys
    @objc static let siPaymentInfo = "siPaymentInfo"
    @objc static let billingAmount = "billingAmount"
    @objc static let billingCycle = "billingCycle"
    @objc static let siStartDate = "siStartDate"
    @objc static let siEndDate = "siEndDate"
    @objc static let billingInterval = "billingInterval"
    @objc static let remarks = "remarks"
    @objc static let billingLimit = "billingLimit"
    @objc static let billingRule = "billingRule"
}

let kCardDetailsViewController = "CardDetailsViewController"
