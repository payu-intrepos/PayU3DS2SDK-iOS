//
//  PayU3DS2SDKHelper.h
//  PayU3DS2ObjcSample
//
//  Created by Amit Salaria on 29/08/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import PayU3DS2Kit;

@interface PayU3DS2SDKHelper: NSObject

+(void)openOn:(UIViewController *)parentVC delegate:(id<PayU3DS2Delegate>)delegate parameters:(NSDictionary *)parameters config:(PayU3DS2Config *)config;

+(void)actionWithAcsActionType:(PayU3DS2ACSActionType)acsActionType challengeInputParams:(PayU3DS2ACSActionParams *)challengeInputParams completion:(void (^)(PayU3DS2Response *))completion;

+(void)mapPArqToPaymentParams:(PayU3DS2PaymentParam *)paymentParams pArq:(PayU3DS2PArqResponse *)pArq authOnly:(BOOL)authOnly threeDSVersion:(NSString *)threeDSVersion;

+(void)cardBinInfoWithParameters:(NSDictionary *)parameters delegate:(id<PayU3DS2HashDelegate>)delegate isSIEnable:(BOOL)isSIEnable completion:(void (^)(PayU3DS2Response *))completion;

+(PayU3DS2Config *)getDefaultConfigurations;

+(PayU3DS2PaymentParam *)getPaymentParametersFrom:(NSDictionary *)parameters;

+(void)startRedirectionFlowOn:(UIViewController *)parentVC parameters:(NSDictionary *)parameters delegate:(id<PayU3DS2Delegate>)delegate;

+(NSDictionary *)getRedirectionFlowParametersWithAcsTemplate:(NSString *)acsTemplate surl:(NSString *)surl furl:(NSString *)furl merchantResponseTimeout:(NSNumber *)merchantResponseTimeout autoSubmit:(BOOL)autoSubmit autoRead:(BOOL)autoRead;

@end
