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

    NSNumber * transactionId = [NSNumber numberWithInt:([[NSDate date] timeIntervalSince1970])];

    PayU3DS2PaymentParam *paymentParam = [[PayU3DS2PaymentParam alloc]
                                               initWithKey: [parameters objectForKey:SampleAppConstants.key]
                                               transactionId: [transactionId stringValue]
                                               amount: [parameters objectForKey:SampleAppConstants.amount]
                                               productInfo: @"Nokia"
                                               firstName: @"First Name"
                                               email: [parameters objectForKey:SampleAppConstants.email]
                                               phone: @"9876543210"
                                               surl: @"https://cbjs.payu.in/sdk/success"
                                               furl: @"https://cbjs.payu.in/sdk/failure"];
    
    paymentParam.userCredential = [parameters objectForKey:SampleAppConstants.userCredential];    
    
    PayU3DS2UserDefines *udfs = [PayU3DS2UserDefines new];
    udfs.udf1 = @"udf1";
    udfs.udf2 = @"udf2";
    udfs.udf3 = @"udf3";
    udfs.udf4 = @"udf4";
    udfs.udf5 = @"udf5";
    
    paymentParam.udfs = udfs;
    
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
    
    paymentParam.cardinfo = cardinfo;

    return paymentParam;
}

@end
