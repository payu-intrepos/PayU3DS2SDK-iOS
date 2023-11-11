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

@end
