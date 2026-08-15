//
//  PayU3DS2SDKHelper.swift
//  PayU3DS2SwiftSample
//
//  Created by Amit Salaria on 25/08/23.
//

import PayU3DS2Kit
import UIKit

class PayU3DS2SDKHelper {
    class func open(on parentVC: UIViewController, delegate: PayU3DS2Delegate, parameters: [String: Any], config: PayU3DS2Config?) {
        // Open SDK
        PayU3DS2.initiatePayment(vc: parentVC, config: config ?? getDefaultConfigurations(), paymentParams: getPaymentParameters(from: parameters)!, delegate: delegate)
    }
    
    class func action(
        with acsActionType: PayU3DS2ACSActionType,
        challengeInputParams: PayU3DS2ACSActionParams,
        completion: @escaping PayU3DS2Completion
    ) {
        PayU3DS2.action(acsActionType: acsActionType,
                        challengeInputParams: challengeInputParams,
                        completion: completion)
    }
    
    class func mapPArq(toPaymentParams paymentParams: PayU3DS2PaymentParam, pArq: PayU3DS2PArqResponse, authOnly: Bool, threeDSVersion: String) {
        let deviceRenderOptions = PayU3DS2DeviceRenderOptions(
            sdkInterface: "03",
            sdkUIType: ["05", "01", "02", "03", "04"]
        )
        let sdkEphemPubKey = PayU3DS2SDKEphemPubKey(
            crv: pArq.crv,
            kty: pArq.kty,
            x: pArq.x,
            y: pArq.y
        )
        let sdkInfo = PayU3DS2SDKInfo(
            sdkEncData: pArq.sdkEncData,
            sdkAppID: pArq.sdkAppID,
            sdkReferenceNumber: pArq.sdkReferenceNumber,
            sdkTransID: pArq.sdkTransID,
            sdkMaxTimeout: "05",
            deviceRenderOptions: deviceRenderOptions,
            sdkEphemPubKey: sdkEphemPubKey,
            mfaVersion: pArq.mfaVersion
        )
        let threeDS2Params = PayU3DS2Params(
            sdkInfo: sdkInfo,
            deviceChannel: "APP",
            threeDSVersion: threeDSVersion
        )
        paymentParams.threeDS2Params = threeDS2Params
        paymentParams.termUrl = "https://acssimuat.payubiz.in/termUrl/DecoupledResponse"
        paymentParams.authOnly = authOnly
        PayU3DS2.setPlatformParams(paymentParams: paymentParams)
    }
    
    class func cardBinInfo(
        withParameters parameters: [String: Any],
        delegate: PayU3DS2HashDelegate,
        isSIEnable: Bool,
        completion: @escaping PayU3DS2Completion
    ) {
        let cardDetails = getCardDetails(paymentParams: getPaymentParameters(from: parameters)!)
        guard !cardDetails.isEmpty else {
            completion(PayU3DS2Response.init(status: 1, errorMessage: "Card details cannot be nil or empty", result: nil))
            return
        }
        let request = PayU3DS2CardBinInfoRequest(cardDetails: cardDetails, isSI: isSIEnable)
        PayU3DS2.cardBinInfo(cardBinInfoRequest: request, delegate: delegate, completion: completion)
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

    class func getPaymentParameters(from parameters: [String: Any]) -> PayU3DS2PaymentParam? {
        print("User Details -> ", parameters)

        let paymentParam = PayU3DS2PaymentParam(
            key: parameters[SampleAppConstants.key] as? String ?? "",
            transactionId: parameters[SampleAppConstants.transactionId] as? String ?? "",
            amount: parameters[SampleAppConstants.amount] as? String ?? "",
            productInfo: "Nokia",
            firstName: "No Name",
            email: parameters[SampleAppConstants.email] as? String ?? "",
            phone: "8437123405",
            surl: "https://cbjs.payu.in/sdk/success",
            furl: "https://cbjs.payu.in/sdk/failure"
        )
        paymentParam.pgCode = parameters[SampleAppConstants.pg] as? String ?? ""
        paymentParam.bankCode = parameters[SampleAppConstants.bankcode] as? String ?? ""
        paymentParam.userCredential = parameters[SampleAppConstants.userCredential] as? String ?? ""
        paymentParam.partnerWebhookSuccess = parameters[SampleAppConstants.partnerWebhookSuccess] as? String ?? ""
        paymentParam.partnerWebhookFailure = parameters[SampleAppConstants.partnerWebhookFailure] as? String ?? ""
        
        let udfs = PayU3DS2UserDefines()
        udfs.udf1 = "udf1"
        udfs.udf2 = "udf2"
        udfs.udf3 = "udf3"
        udfs.udf4 = "udf4"
        udfs.udf5 = "udf5"

        paymentParam.udfs = udfs
        if let additional = parameters[SampleAppConstants.additionalParam] as? [String: Any] {
            paymentParam.additionalParam = additional
        }
        
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
        // ignore if 0
        if let type = parameters[SampleAppConstants.cardTokenType] as? String, type == "1" {
            paymentParam.cardTokenType = type
        }
        paymentParam.cardinfo = cardinfo

        // SI params
        if let dict = parameters[SampleAppConstants.siPaymentInfo] as? [String: Any] {
            let recurringAmount = dict[SampleAppConstants.billingAmount] as? String
            let recurringPeriod = dict[SampleAppConstants.billingCycle] as? PayU3DS2BillingCycle ?? .monthly
            let siStartDate = dict[SampleAppConstants.siStartDate] as? Date
            let siEndDate = dict[SampleAppConstants.siEndDate] as? Date
            let billingInterval = dict[SampleAppConstants.billingInterval] as? Int ?? 0
            
            let siInfo = PayU3DS2SIParams(billingAmount: recurringAmount,
                                      paymentStartDate: siStartDate,
                                      paymentEndDate: siEndDate,
                                      billingCycle: recurringPeriod,// PayU3DS2Utils.billingCycleToString(recurringPeriod),
                                      billingInterval: billingInterval) //NSNumber(value:
            siInfo.remarks = dict[SampleAppConstants.remarks] as? String
            //siInfo.isFreeTrial = freeTrialSwitch.isOn
            
            siInfo.billingLimit = dict[SampleAppConstants.billingLimit] as? String
            siInfo.billingRule = dict[SampleAppConstants.billingRule] as? String
            
            paymentParam.siParam = siInfo
        }
        return paymentParam
    }
    
    class func startRedirectionFlow(on parentVC: UIViewController, parameters: [String: Any], delegate: PayU3DS2Delegate) {
        PayU3DS2.startRedirectionFlow(vc: parentVC, params: parameters, uiCustomisation: nil, delegate: delegate)
    }
    
    class func getRedirectionFlowParameters(
        withAcsTemplate acsTemplate: String,
        surl: String,
        furl: String,
        merchantResponseTimeout: Int? = nil,
        autoSubmit: Bool = false,
        autoRead: Bool = false
    ) -> [String: Any] {
        var params: [String: Any] = [:]
        params["acsTemplate"] = acsTemplate
        params["surl"] = surl
        params["furl"] = furl
        
        if let timeout = merchantResponseTimeout {
            params["merchantResponseTimeout"] = timeout
        }
        
        if autoSubmit {
            params["autoSubmit"] = autoSubmit
        }
        
        if autoRead {
            params["autoRead"] = autoRead
        }
        return params
    }
    
    // MARK: - Helper Methods -

    private class func getCardDetails(
        paymentParams: PayU3DS2PaymentParam
    ) -> String {
        var cardDetails = ""
        if let cardNumber = paymentParams.cardinfo?.cardNumber, !cardNumber.isEmpty {
            cardDetails = cardNumber
        } else if let cardToken = paymentParams.cardinfo?.cardToken, !cardToken.isEmpty {
            cardDetails = cardToken
        }
        return cardDetails
    }

}
