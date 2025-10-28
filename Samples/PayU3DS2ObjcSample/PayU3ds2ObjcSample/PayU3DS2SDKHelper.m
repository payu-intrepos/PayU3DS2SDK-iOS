//
//  PayU3DS2SDKHelper.m
//  PayU3DS2ObjcSample
//
//  Created by Amit Salaria on 29/08/23.
//

#import "PayU3DS2SDKHelper.h"
#import "PayU3DS2ObjcSample-Swift.h"

@implementation PayU3DS2SDKHelper: NSObject

+(void)openOn:(UIViewController *)parentVC delegate:(id<PayU3DS2Delegate>)delegate parameters:(NSDictionary *)parameters config:(PayU3DS2Config *)config {
    PayU3DS2Config *sdkConfig = config;
    if (!sdkConfig) {
        sdkConfig = [self getDefaultConfigurations];
    }
    // Open SDK
    [PayU3DS2 initiatePaymentWithVc:parentVC config:sdkConfig paymentParams:[self getPaymentParametersFrom:parameters] delegate:delegate];
    
}

+(PayU3DS2Config *)getDefaultConfigurations {

    PayU3DS2Config *config = [PayU3DS2Config new];
//    config.isProduction = YES;
//    config.fallback3DS1 = YES;
//    config.authenticateOnly = NO;
//    config.autoSubmit = YES;
//    config.merchantResponseTimeout = 10; // In Seconds
//    config.uiCustomisation = [self getUICustomisation];
//    [config setDefaultProgressLoaderWithShowDefaultLoader:YES defaultProgressLoaderColor:@"#25272C"];
    return config;

}

+(PayU3DS2PaymentParam *)getPaymentParametersFrom: (NSDictionary *)parameters {

    NSLog(@"User Details -> %@", [parameters description]);

    PayU3DS2PaymentParam *paymentParam = [[PayU3DS2PaymentParam alloc]
                                               initWithKey: [parameters objectForKey:SampleAppConstants.key]
                                               transactionId:[parameters objectForKey:SampleAppConstants.transactionId]
                                               amount: [parameters objectForKey:SampleAppConstants.amount]
                                               productInfo: @"Nokia"
                                               firstName: @"First Name"
                                               email: [parameters objectForKey:SampleAppConstants.email]
                                               phone: @"9876543210"
                                               surl: @"https://cbjs.payu.in/sdk/success"
                                               furl: @"https://cbjs.payu.in/sdk/failure"];
    
    paymentParam.pgCode = [parameters objectForKey:SampleAppConstants.pg];
    paymentParam.bankCode = [parameters objectForKey:SampleAppConstants.bankcode];
    paymentParam.userCredential = [parameters objectForKey:SampleAppConstants.userCredential];
    paymentParam.partnerWebhookSuccess = [parameters objectForKey:SampleAppConstants.partnerWebhookSuccess];
    paymentParam.partnerWebhookFailure = [parameters objectForKey:SampleAppConstants.partnerWebhookFailure];
    
    PayU3DS2UserDefines *udfs = [PayU3DS2UserDefines new];
    udfs.udf1 = @"udf1";
    udfs.udf2 = @"udf2";
    udfs.udf3 = @"udf3";
    udfs.udf4 = @"udf4";
    udfs.udf5 = @"udf5";
    
    paymentParam.udfs = udfs;
    
    NSDictionary *additionalParam = [parameters objectForKey:SampleAppConstants.additionalParam];
    if (additionalParam) {
        paymentParam.additionalParam = additionalParam;
    }
    
    PayU3DS2CardInfo * cardinfo = [PayU3DS2CardInfo new];
    // New Card
    cardinfo.cardName = [parameters objectForKey:SampleAppConstants.cardName];
    cardinfo.cardNumber = [parameters objectForKey:SampleAppConstants.cardNumber];
    cardinfo.expiryMonth = [parameters objectForKey:SampleAppConstants.cardExpiryMonth];
    cardinfo.expiryYear = [parameters objectForKey:SampleAppConstants.cardExpiryYear];
    cardinfo.cvv = [parameters objectForKey:SampleAppConstants.cvv];
//    cardinfo.shouldSaveCard = [parameters objectForKey:SampleAppConstants.saveCard];
    // Saved Card
    cardinfo.cardToken = [parameters objectForKey:SampleAppConstants.cardToken];
    cardinfo.networkToken = [parameters objectForKey:SampleAppConstants.networkToken];
    // ignore if 0
    NSString *cardTokenType = [parameters objectForKey:SampleAppConstants.cardTokenType];
    if (cardTokenType && [cardTokenType isEqualToString:@"1"]) {
        paymentParam.cardTokenType = cardTokenType;
    }
    paymentParam.cardinfo = cardinfo;

    // SI params
    NSDictionary *siPaymentInfo = [parameters objectForKey:SampleAppConstants.siPaymentInfo];
    if (siPaymentInfo) {
        NSString *recurringAmount = [siPaymentInfo objectForKey:SampleAppConstants.billingAmount];
        PayU3DS2BillingCycle recurringPeriod = [[siPaymentInfo objectForKey:SampleAppConstants.billingCycle] integerValue];
        NSDate *siStartDate = [siPaymentInfo objectForKey:SampleAppConstants.siStartDate];
        NSDate *siEndDate = [siPaymentInfo objectForKey:SampleAppConstants.siEndDate];
        NSNumber *billingInterval = [siPaymentInfo objectForKey:SampleAppConstants.billingInterval];
        
        PayU3DS2SIParams *siInfo = [[PayU3DS2SIParams alloc] initWithBillingAmount:recurringAmount
                                                                  paymentStartDate:siStartDate
                                                                    paymentEndDate:siEndDate
                                                                       billingCycle:recurringPeriod
                                                                    billingInterval:[billingInterval intValue]];
        siInfo.remarks = [siPaymentInfo objectForKey:SampleAppConstants.remarks];
        siInfo.billingLimit = [siPaymentInfo objectForKey:SampleAppConstants.billingLimit];
        siInfo.billingRule = [siPaymentInfo objectForKey:SampleAppConstants.billingRule];
        
        paymentParam.siParam = siInfo;
    }
    
    return paymentParam;
}

+(void)actionWithAcsActionType:(PayU3DS2ACSActionType)acsActionType challengeInputParams:(PayU3DS2ACSActionParams *)challengeInputParams completion:(void (^)(PayU3DS2Response *))completion {
    [PayU3DS2 actionWithAcsActionType:acsActionType challengeInputParams:challengeInputParams completion:completion];
}

+(void)mapPArqToPaymentParams:(PayU3DS2PaymentParam *)paymentParams pArq:(PayU3DS2PArqResponse *)pArq authOnly:(BOOL)authOnly threeDSVersion:(NSString *)threeDSVersion {
    PayU3DS2DeviceRenderOptions *deviceRenderOptions = [[PayU3DS2DeviceRenderOptions alloc] initWithSdkInterface:@"03" sdkUIType:@[@"05", @"01", @"02", @"03", @"04"]];
    
    PayU3DS2SDKEphemPubKey *sdkEphemPubKey = [[PayU3DS2SDKEphemPubKey alloc] initWithCrv:pArq.crv
                                                                                        kty:pArq.kty
                                                                                          x:pArq.x
                                                                                          y:pArq.y];
    
    PayU3DS2SDKInfo *sdkInfo = [[PayU3DS2SDKInfo alloc] initWithSdkEncData:pArq.sdkEncData
                                                                   sdkAppID:pArq.sdkAppID
                                                          sdkReferenceNumber:pArq.sdkReferenceNumber
                                                                 sdkTransID:pArq.sdkTransID
                                                               sdkMaxTimeout:@"05"
                                                         deviceRenderOptions:deviceRenderOptions
                                                              sdkEphemPubKey:sdkEphemPubKey];
    
    PayU3DS2Params *threeDS2Params = [[PayU3DS2Params alloc] initWithSdkInfo:sdkInfo
                                                               deviceChannel:@"APP"
                                                              threeDSVersion:threeDSVersion];
    
    paymentParams.threeDS2Params = threeDS2Params;
    paymentParams.termUrl = @"https://acssimuat.payubiz.in/termUrl/DecoupledResponse";
    paymentParams.authOnly = authOnly;
    [PayU3DS2 setPlatformParamsWithPaymentParams:paymentParams];
}

+(void)cardBinInfoWithParameters:(NSDictionary *)parameters delegate:(id<PayU3DS2HashDelegate>)delegate isSIEnable:(BOOL)isSIEnable completion:(void (^)(PayU3DS2Response *))completion {
    NSString *cardDetails = [self getCardDetailsWithPaymentParams:[self getPaymentParametersFrom:parameters]];
    if (cardDetails.length == 0) {
        PayU3DS2Response *response = [[PayU3DS2Response alloc] initWithStatus:1 errorMessage:@"Card details cannot be nil or empty" result:nil];
        completion(response);
        return;
    }
    
    PayU3DS2CardBinInfoRequest *request = [[PayU3DS2CardBinInfoRequest alloc] initWithCardDetails:cardDetails isSI:isSIEnable];
    [PayU3DS2 cardBinInfoWithCardBinInfoRequest:request delegate:delegate completion:completion];
}

+(void)startRedirectionFlowOn:(UIViewController *)parentVC parameters:(NSDictionary *)parameters delegate:(id<PayU3DS2Delegate>)delegate {
    [PayU3DS2 startRedirectionFlowWithVc:parentVC params:parameters uiCustomisation:nil delegate:delegate];
}

+(NSDictionary *)getRedirectionFlowParametersWithAcsTemplate:(NSString *)acsTemplate surl:(NSString *)surl furl:(NSString *)furl merchantResponseTimeout:(NSNumber *)merchantResponseTimeout autoSubmit:(BOOL)autoSubmit autoRead:(BOOL)autoRead {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"acsTemplate"] = acsTemplate;
    params[@"surl"] = surl;
    params[@"furl"] = furl;
    
    if (merchantResponseTimeout) {
        params[@"merchantResponseTimeout"] = merchantResponseTimeout;
    }
    
    if (autoSubmit) {
        params[@"autoSubmit"] = @(autoSubmit);
    }
    
    if (autoRead) {
        params[@"autoRead"] = @(autoRead);
    }
    
    return [params copy];
}

+(NSString *)getCardDetailsWithPaymentParams:(PayU3DS2PaymentParam *)paymentParams {
    NSString *cardDetails = @"";
    if (paymentParams.cardinfo.cardNumber && paymentParams.cardinfo.cardNumber.length > 0) {
        cardDetails = paymentParams.cardinfo.cardNumber;
    } else if (paymentParams.cardinfo.cardToken && paymentParams.cardinfo.cardToken.length > 0) {
        cardDetails = paymentParams.cardinfo.cardToken;
    }
    return cardDetails;
}

@end
