//
//  PayU3DS2SDKHelper.swift
//  PayU3DS2SwiftSample
//
//  Created by Amit Salaria on 25/08/23.
//

import PayU3DS2
import UIKit

class PayU3DS2SDKHelper {
    class func open(on parentVC: UIViewController, delegate: PayU3DS2Delegate, parameters: [String: Any], config: PayU3DS2Config?) {
        // Open SDK
        PayU3DS2.initiatePayment(vc: parentVC, config: config ?? getDefaultConfigurations(), paymentParams: getPaymentParameters(from: parameters), delegate: delegate)
    }

    fileprivate class func getDefaultConfigurations() -> PayU3DS2Config {
        let config = PayU3DS2Config()
//        config.isProduction = true
//        config.fallback3DS1 = true
//        config.authenticateOnly = false
//        config.autoSubmit = true
//        config.merchantResponseTimeout = 10 // In Seconds
//        config.uiCustomisation = getUICustomisation()
//        config.setDefaultProgressLoader(showDefaultLoader: true, defaultProgressLoaderColor: "#25272C")
        return config
    }

    fileprivate class func getPaymentParameters(from parameters: [String: Any]) -> PayU3DS2PaymentParam {
        print("User Details -> ", parameters)

        let transactionId = Int64(Date().timeIntervalSince1970)

        let paymentParam = PayU3DS2PaymentParam(
            key: parameters[SampleAppConstants.key] as? String ?? "",
            transactionId: String(transactionId),
            amount: parameters[SampleAppConstants.amount] as? String ?? "",
            productInfo: "Nokia",
            firstName: "No Name",
            email: parameters[SampleAppConstants.email] as? String ?? "",
            phone: "9876543210",
            surl: "https://cbjs.payu.in/sdk/success",
            furl: "https://cbjs.payu.in/sdk/failure"
        )

        paymentParam.userCredential = parameters[SampleAppConstants.userCredential] as? String ?? ""

        let udfs = PayU3DS2UserDefines()
        udfs.udf1 = "udf1"
        udfs.udf2 = "udf2"
        udfs.udf3 = "udf3"
        udfs.udf4 = "udf4"
        udfs.udf5 = "udf5"

        paymentParam.udfs = udfs

        let cardinfo = PayU3DS2CardInfo()
        // New Card
        cardinfo.cardName = parameters[SampleAppConstants.cardName] as? String
        cardinfo.cardNumber = parameters[SampleAppConstants.cardNumber] as? String
        cardinfo.expiryMonth = parameters[SampleAppConstants.cardExpiryMonth] as? String
        cardinfo.expiryYear = parameters[SampleAppConstants.cardExpiryYear] as? String
        cardinfo.cvv = parameters[SampleAppConstants.cvv] as? String
//        cardinfo.shouldSaveCard = parameters[SampleAppConstants.saveCard] as? Bool ?? false
        // Saved Card
        cardinfo.cardToken = parameters[SampleAppConstants.cardToken] as? String
        cardinfo.networkToken = parameters[SampleAppConstants.networkToken] as? String

        paymentParam.cardinfo = cardinfo

        return paymentParam
    }
}
