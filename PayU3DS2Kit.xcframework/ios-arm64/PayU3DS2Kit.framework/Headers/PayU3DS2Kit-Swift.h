#if 0
#elif defined(__arm64__) && __arm64__
// Generated by Apple Swift version 5.7.1 (swiftlang-5.7.1.135.3 clang-1400.0.29.51)
#ifndef PAYU3DS2KIT_SWIFT_H
#define PAYU3DS2KIT_SWIFT_H
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wduplicate-method-match"
#pragma clang diagnostic ignored "-Wauto-import"
#if defined(__OBJC__)
#include <Foundation/Foundation.h>
#endif
#if defined(__cplusplus)
#include <cstdint>
#include <cstddef>
#include <cstdbool>
#else
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>
#endif

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(ns_consumed)
# define SWIFT_RELEASES_ARGUMENT __attribute__((ns_consumed))
#else
# define SWIFT_RELEASES_ARGUMENT
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif
#if !defined(SWIFT_RESILIENT_CLASS)
# if __has_attribute(objc_class_stub)
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME) __attribute__((objc_class_stub))
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_class_stub)) SWIFT_CLASS_NAMED(SWIFT_NAME)
# else
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME)
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) SWIFT_CLASS_NAMED(SWIFT_NAME)
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility)
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_WEAK_IMPORT)
# define SWIFT_WEAK_IMPORT __attribute__((weak_import))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if defined(__OBJC__)
#if !defined(IBSegueAction)
# define IBSegueAction
#endif
#endif
#if !defined(SWIFT_EXTERN)
# if defined(__cplusplus)
#  define SWIFT_EXTERN extern "C"
# else
#  define SWIFT_EXTERN extern
# endif
#endif
#if !defined(SWIFT_CALL)
# define SWIFT_CALL __attribute__((swiftcall))
#endif
#if defined(__cplusplus)
#if !defined(SWIFT_NOEXCEPT)
# define SWIFT_NOEXCEPT noexcept
#endif
#else
#if !defined(SWIFT_NOEXCEPT)
# define SWIFT_NOEXCEPT 
#endif
#endif
#if defined(__cplusplus)
#if !defined(SWIFT_CXX_INT_DEFINED)
#define SWIFT_CXX_INT_DEFINED
namespace swift {
using Int = ptrdiff_t;
using UInt = size_t;
}
#endif
#endif
#if defined(__OBJC__)
#if __has_feature(modules)
#if __has_warning("-Watimport-in-framework-header")
#pragma clang diagnostic ignored "-Watimport-in-framework-header"
#endif
@import Foundation;
@import ObjectiveC;
#endif

#endif
#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"
#pragma clang diagnostic ignored "-Wdollar-in-identifier-extension"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="PayU3DS2Kit",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif

#if defined(__OBJC__)


@class NSString;
@class PayU3DS2Config;
@class PayU3DS2Response;
@class PayU3DS2CardBinInfoRequest;
@protocol PayU3DS2HashDelegate;
@class PayU3DS2CardData;
@class PayU3DS2ChallengeParameter;
@class UIViewController;
@class PayU3DS2PaymentParam;
@protocol PayU3DS2Delegate;

SWIFT_CLASS("_TtC11PayU3DS2Kit8PayU3DS2")
@interface PayU3DS2 : NSObject
+ (void)initialiseWithKey:(NSString * _Nonnull)key requestId:(NSString * _Nonnull)requestId config:(PayU3DS2Config * _Nonnull)config completion:(void (^ _Nonnull)(PayU3DS2Response * _Nonnull))completion;
+ (void)cardBinInfoWithCardBinInfoRequest:(PayU3DS2CardBinInfoRequest * _Nonnull)cardBinInfoRequest delegate:(id <PayU3DS2HashDelegate> _Nonnull)delegate completion:(void (^ _Nonnull)(PayU3DS2Response * _Nonnull))completion;
+ (PayU3DS2Response * _Nonnull)extractDeviceDetailsWithCardData:(PayU3DS2CardData * _Nonnull)cardData SWIFT_WARN_UNUSED_RESULT;
+ (void)initiateChallengeWithChallengeParameter:(PayU3DS2ChallengeParameter * _Nonnull)challengeParameter completion:(void (^ _Nonnull)(PayU3DS2Response * _Nonnull))completion;
+ (void)initiatePaymentWithVc:(UIViewController * _Nonnull)vc config:(PayU3DS2Config * _Nonnull)config paymentParams:(PayU3DS2PaymentParam * _Nonnull)paymentParams delegate:(id <PayU3DS2Delegate> _Nonnull)delegate;
+ (void)clean;
+ (void)start;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC11PayU3DS2Kit18PayU3DS2BaseConfig")
@interface PayU3DS2BaseConfig : NSObject
@property (nonatomic) BOOL isProduction;
@property (nonatomic) NSTimeInterval merchantResponseTimeout;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC11PayU3DS2Kit25PayU3DS2BaseCustomisation")
@interface PayU3DS2BaseCustomisation : NSObject
- (nonnull instancetype)initWithTextFontColor:(NSString * _Nullable)textFontColor textFontSize:(NSInteger)textFontSize textFontFamilyName:(NSString * _Nullable)textFontFamilyName OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_PROTOCOL("_TtP11PayU3DS2Kit20PayU3DS2BaseDelegate_")
@protocol PayU3DS2BaseDelegate
- (void)onErrorWithErrorCode:(NSInteger)errorCode errorMessage:(NSString * _Nonnull)errorMessage;
@end


SWIFT_CLASS("_TtC11PayU3DS2Kit23PayU3DS2BinInfoResponse")
@interface PayU3DS2BinInfoResponse : NSObject
@property (nonatomic, copy) NSString * _Nullable issuingBank;
@property (nonatomic, copy) NSString * _Nullable bin;
@property (nonatomic, copy) NSString * _Nullable category;
@property (nonatomic, copy) NSString * _Nullable cardType;
@property (nonatomic, copy) NSString * _Nullable isDomestic;
@property (nonatomic, copy) NSString * _Nullable isAtmPinCard;
@property (nonatomic) NSInteger isSiSupported;
@property (nonatomic) NSInteger isOtpOnTheFly;
@property (nonatomic, copy) NSString * _Nullable messageVersion;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

enum PayU3DS2ButtonTextCaseType : NSInteger;

SWIFT_CLASS("_TtC11PayU3DS2Kit27PayU3DS2ButtonCustomisation")
@interface PayU3DS2ButtonCustomisation : PayU3DS2BaseCustomisation
- (nonnull instancetype)initWithTextFontColor:(NSString * _Nullable)textFontColor textFontSize:(NSInteger)textFontSize textFontFamilyName:(NSString * _Nullable)textFontFamilyName backgroundColor:(NSString * _Nullable)backgroundColor cornerRadius:(NSInteger)cornerRadius resendButtonTextFontColor:(NSString * _Nullable)resendButtonTextFontColor textCaseType:(enum PayU3DS2ButtonTextCaseType)textCaseType OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithTextFontColor:(NSString * _Nullable)textFontColor textFontSize:(NSInteger)textFontSize textFontFamilyName:(NSString * _Nullable)textFontFamilyName SWIFT_UNAVAILABLE;
@end

typedef SWIFT_ENUM(NSInteger, PayU3DS2ButtonTextCaseType, open) {
  PayU3DS2ButtonTextCaseTypeLowercase = 0,
  PayU3DS2ButtonTextCaseTypeUppercase = 1,
  PayU3DS2ButtonTextCaseTypeDefault = 2,
};


SWIFT_CLASS("_TtC11PayU3DS2Kit26PayU3DS2CardBinInfoRequest")
@interface PayU3DS2CardBinInfoRequest : NSObject
@property (nonatomic, copy) NSString * _Nonnull cardDetails;
@property (nonatomic) BOOL isSI;
- (nonnull instancetype)initWithCardDetails:(NSString * _Nonnull)cardDetails isSI:(BOOL)isSI OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

enum PayU3DS2CardScheme : NSInteger;

SWIFT_CLASS("_TtC11PayU3DS2Kit16PayU3DS2CardData")
@interface PayU3DS2CardData : NSObject
@property (nonatomic) enum PayU3DS2CardScheme cardScheme;
@property (nonatomic, copy) NSString * _Nonnull threeDSVersion;
- (nonnull instancetype)initWithCardScheme:(enum PayU3DS2CardScheme)cardScheme threeDSVersion:(NSString * _Nonnull)threeDSVersion OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC11PayU3DS2Kit16PayU3DS2CardInfo")
@interface PayU3DS2CardInfo : NSObject
@property (nonatomic, copy) NSString * _Nullable cardName;
@property (nonatomic, copy) NSString * _Nullable cardAlias;
@property (nonatomic, copy) NSString * _Nullable cardNumber;
@property (nonatomic, copy) NSString * _Nullable expiryMonth;
@property (nonatomic, copy) NSString * _Nullable expiryYear;
@property (nonatomic, copy) NSString * _Nullable cvv;
@property (nonatomic, copy) NSString * _Nullable cardToken;
@property (nonatomic, copy) NSString * _Nullable networkToken;
@property (nonatomic) enum PayU3DS2CardScheme cardScheme;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

typedef SWIFT_ENUM(NSInteger, PayU3DS2CardScheme, open) {
  PayU3DS2CardSchemeMasterCard = 0,
  PayU3DS2CardSchemeVisa = 1,
  PayU3DS2CardSchemeJcb = 2,
  PayU3DS2CardSchemeAmex = 3,
  PayU3DS2CardSchemeMaestro = 4,
  PayU3DS2CardSchemeRupay = 5,
  PayU3DS2CardSchemeDiscover = 6,
  PayU3DS2CardSchemeDinersClub = 7,
  PayU3DS2CardSchemeLaser = 8,
  PayU3DS2CardSchemeStateBankMaestro = 9,
  PayU3DS2CardSchemeUnknown = 10,
  PayU3DS2CardSchemeSodexo = 11,
};


SWIFT_CLASS("_TtC11PayU3DS2Kit26PayU3DS2ChallengeParameter")
@interface PayU3DS2ChallengeParameter : NSObject
@property (nonatomic, copy) NSString * _Nonnull acsSignedContent;
@property (nonatomic, copy) NSString * _Nonnull acsRefNumber;
@property (nonatomic, copy) NSString * _Nonnull acsTransactionID;
@property (nonatomic, copy) NSString * _Nonnull threeDSServerTransactionID;
- (nonnull instancetype)initWithAcsSignedContent:(NSString * _Nonnull)acsSignedContent acsRefNumber:(NSString * _Nonnull)acsRefNumber acsTransactionID:(NSString * _Nonnull)acsTransactionID threeDSServerTransactionID:(NSString * _Nonnull)threeDSServerTransactionID OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@class PayU3DS2UICustomisation;

SWIFT_CLASS("_TtC11PayU3DS2Kit14PayU3DS2Config")
@interface PayU3DS2Config : PayU3DS2BaseConfig
@property (nonatomic) BOOL fallback3DS1;
@property (nonatomic, strong) PayU3DS2UICustomisation * _Nullable uiCustomisation;
@property (nonatomic) BOOL authenticateOnly;
@property (nonatomic) BOOL autoSubmit;
/// Setup Loader UI
- (void)setDefaultProgressLoaderWithShowDefaultLoader:(BOOL)showDefaultLoader defaultProgressLoaderColor:(NSString * _Nonnull)defaultProgressLoaderColor;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_PROTOCOL("_TtP11PayU3DS2Kit20PayU3DS2HashDelegate_")
@protocol PayU3DS2HashDelegate
- (void)generateHashFor:(NSDictionary<NSString *, NSString *> * _Nonnull)param onCompletion:(void (^ _Nonnull)(NSDictionary<NSString *, NSString *> * _Nonnull))onCompletion;
@end


SWIFT_PROTOCOL("_TtP11PayU3DS2Kit16PayU3DS2Delegate_")
@protocol PayU3DS2Delegate <PayU3DS2BaseDelegate, PayU3DS2HashDelegate>
- (void)onPaymentSuccessWithSuccessResponse:(id _Nullable)successResponse;
- (void)onPaymentFailureWithFailureResponse:(id _Nullable)failureResponse;
- (void)onPaymentCancelWithIsTxnInitiated:(BOOL)isTxnInitiated;
@end


SWIFT_CLASS("_TtC11PayU3DS2Kit27PayU3DS2DeviceRenderOptions")
@interface PayU3DS2DeviceRenderOptions : NSObject
@property (nonatomic, copy) NSString * _Nonnull sdkInterface;
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull sdkUIType;
- (nonnull instancetype)initWithSdkInterface:(NSString * _Nonnull)sdkInterface sdkUIType:(NSArray<NSString *> * _Nonnull)sdkUIType OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

typedef SWIFT_ENUM(NSInteger, PayU3DS2DeviceSeverity, open) {
  PayU3DS2DeviceSeverityLow = 0,
  PayU3DS2DeviceSeverityMedium = 1,
  PayU3DS2DeviceSeverityHigh = 2,
};


SWIFT_CLASS("_TtC11PayU3DS2Kit21PayU3DS2DeviceWarning")
@interface PayU3DS2DeviceWarning : NSObject
@property (nonatomic, copy) NSString * _Nonnull id;
@property (nonatomic, copy) NSString * _Nonnull message;
@property (nonatomic) enum PayU3DS2DeviceSeverity severity;
- (nonnull instancetype)initWithId:(NSString * _Nonnull)id message:(NSString * _Nonnull)message severity:(enum PayU3DS2DeviceSeverity)severity OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC11PayU3DS2Kit13PayU3DS2Error")
@interface PayU3DS2Error : NSObject
@property (nonatomic, copy) NSString * _Nonnull message;
@property (nonatomic) NSInteger errorCode;
@property (nonatomic, readonly, copy) NSString * _Nullable errorDescription;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC11PayU3DS2Kit21PayU3DS2HashConstants")
@interface PayU3DS2HashConstants : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull hashString;)
+ (NSString * _Nonnull)hashString SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull hashType;)
+ (NSString * _Nonnull)hashType SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull hashName;)
+ (NSString * _Nonnull)hashName SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull postSalt;)
+ (NSString * _Nonnull)postSalt SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end



SWIFT_CLASS("_TtC11PayU3DS2Kit26PayU3DS2LabelCustomisation")
@interface PayU3DS2LabelCustomisation : PayU3DS2BaseCustomisation
- (nonnull instancetype)initWithTextFontColor:(NSString * _Nullable)textFontColor textFontSize:(NSInteger)textFontSize textFontFamilyName:(NSString * _Nullable)textFontFamilyName headingTextColor:(NSString * _Nullable)headingTextColor headingTextFontFamilyName:(NSString * _Nullable)headingTextFontFamilyName headingTextFontSize:(NSInteger)headingTextFontSize OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithTextFontColor:(NSString * _Nullable)textFontColor textFontSize:(NSInteger)textFontSize textFontFamilyName:(NSString * _Nullable)textFontFamilyName SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC11PayU3DS2Kit20PayU3DS2PArqResponse")
@interface PayU3DS2PArqResponse : NSObject
@property (nonatomic, copy) NSString * _Nonnull sdkAppID;
@property (nonatomic, copy) NSString * _Nonnull sdkEncData;
@property (nonatomic, copy) NSString * _Nonnull crv;
@property (nonatomic, copy) NSString * _Nonnull kty;
@property (nonatomic, copy) NSString * _Nonnull x;
@property (nonatomic, copy) NSString * _Nonnull y;
@property (nonatomic, copy) NSString * _Nonnull sdkTransID;
@property (nonatomic, copy) NSString * _Nonnull sdkReferenceNumber;
- (nonnull instancetype)initWithSdkAppID:(NSString * _Nonnull)sdkAppID sdkEncData:(NSString * _Nonnull)sdkEncData crv:(NSString * _Nonnull)crv kty:(NSString * _Nonnull)kty x:(NSString * _Nonnull)x y:(NSString * _Nonnull)y sdkTransID:(NSString * _Nonnull)sdkTransID sdkReferenceNumber:(NSString * _Nonnull)sdkReferenceNumber OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@class PayU3DS2SDKInfo;

SWIFT_CLASS("_TtC11PayU3DS2Kit14PayU3DS2Params")
@interface PayU3DS2Params : NSObject
@property (nonatomic, strong) PayU3DS2SDKInfo * _Nonnull sdkInfo;
@property (nonatomic, copy) NSString * _Nonnull deviceChannel;
@property (nonatomic, copy) NSString * _Nonnull threeDSVersion;
- (nonnull instancetype)initWithSdkInfo:(PayU3DS2SDKInfo * _Nonnull)sdkInfo deviceChannel:(NSString * _Nonnull)deviceChannel threeDSVersion:(NSString * _Nonnull)threeDSVersion OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@class PayU3DS2UserDefines;

SWIFT_CLASS("_TtC11PayU3DS2Kit20PayU3DS2PaymentParam")
@interface PayU3DS2PaymentParam : NSObject
@property (nonatomic, copy) NSString * _Nonnull key;
@property (nonatomic, copy) NSString * _Nonnull transactionId;
@property (nonatomic, copy) NSString * _Nonnull amount;
@property (nonatomic, copy) NSString * _Nonnull productInfo;
@property (nonatomic, copy) NSString * _Nonnull firstName;
@property (nonatomic, copy) NSString * _Nonnull email;
@property (nonatomic, copy) NSString * _Nonnull phone;
@property (nonatomic, copy) NSString * _Nonnull surl;
@property (nonatomic, copy) NSString * _Nonnull furl;
@property (nonatomic, copy) NSString * _Nullable userCredential;
@property (nonatomic, copy) NSDictionary<NSString *, id> * _Nonnull additionalParam;
@property (nonatomic, strong) PayU3DS2UserDefines * _Nullable udfs;
@property (nonatomic, strong) PayU3DS2CardInfo * _Nullable cardinfo;
- (nonnull instancetype)initWithKey:(NSString * _Nonnull)key transactionId:(NSString * _Nonnull)transactionId amount:(NSString * _Nonnull)amount productInfo:(NSString * _Nonnull)productInfo firstName:(NSString * _Nonnull)firstName email:(NSString * _Nonnull)email phone:(NSString * _Nonnull)phone surl:(NSString * _Nonnull)surl furl:(NSString * _Nonnull)furl OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC11PayU3DS2Kit16PayU3DS2Response")
@interface PayU3DS2Response : NSObject
@property (nonatomic) NSInteger status;
@property (nonatomic, copy) NSString * _Nullable errorMessage;
@property (nonatomic) id _Nullable result;
- (nonnull instancetype)initWithStatus:(NSInteger)status errorMessage:(NSString * _Nullable)errorMessage result:(id _Nullable)result OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithStatus:(NSInteger)status result:(id _Nullable)result OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithStatus:(NSInteger)status errorMessage:(NSString * _Nullable)errorMessage OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC11PayU3DS2Kit22PayU3DS2SDKEphemPubKey")
@interface PayU3DS2SDKEphemPubKey : NSObject
@property (nonatomic, copy) NSString * _Nonnull crv;
@property (nonatomic, copy) NSString * _Nonnull kty;
@property (nonatomic, copy) NSString * _Nonnull x;
@property (nonatomic, copy) NSString * _Nonnull y;
- (nonnull instancetype)initWithCrv:(NSString * _Nonnull)crv kty:(NSString * _Nonnull)kty x:(NSString * _Nonnull)x y:(NSString * _Nonnull)y OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC11PayU3DS2Kit15PayU3DS2SDKInfo")
@interface PayU3DS2SDKInfo : NSObject
@property (nonatomic, copy) NSString * _Nonnull sdkEncData;
@property (nonatomic, copy) NSString * _Nonnull sdkAppID;
@property (nonatomic, copy) NSString * _Nonnull sdkReferenceNumber;
@property (nonatomic, copy) NSString * _Nonnull sdkTransID;
@property (nonatomic, copy) NSString * _Nonnull sdkMaxTimeout;
@property (nonatomic, strong) PayU3DS2DeviceRenderOptions * _Nonnull deviceRenderOptions;
@property (nonatomic, strong) PayU3DS2SDKEphemPubKey * _Nonnull sdkEphemPubKey;
- (nonnull instancetype)initWithSdkEncData:(NSString * _Nonnull)sdkEncData sdkAppID:(NSString * _Nonnull)sdkAppID sdkReferenceNumber:(NSString * _Nonnull)sdkReferenceNumber sdkTransID:(NSString * _Nonnull)sdkTransID sdkMaxTimeout:(NSString * _Nonnull)sdkMaxTimeout deviceRenderOptions:(PayU3DS2DeviceRenderOptions * _Nonnull)deviceRenderOptions sdkEphemPubKey:(PayU3DS2SDKEphemPubKey * _Nonnull)sdkEphemPubKey OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC11PayU3DS2Kit28PayU3DS2TextBoxCustomisation")
@interface PayU3DS2TextBoxCustomisation : PayU3DS2BaseCustomisation
- (nonnull instancetype)initWithTextFontColor:(NSString * _Nullable)textFontColor textFontSize:(NSInteger)textFontSize textFontFamilyName:(NSString * _Nullable)textFontFamilyName borderColor:(NSString * _Nullable)borderColor borderWidth:(NSInteger)borderWidth cornerRadius:(NSInteger)cornerRadius OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithTextFontColor:(NSString * _Nullable)textFontColor textFontSize:(NSInteger)textFontSize textFontFamilyName:(NSString * _Nullable)textFontFamilyName SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC11PayU3DS2Kit28PayU3DS2ToolBarCustomisation")
@interface PayU3DS2ToolBarCustomisation : PayU3DS2BaseCustomisation
- (nonnull instancetype)initWithTextFontColor:(NSString * _Nullable)textFontColor textFontSize:(NSInteger)textFontSize textFontFamilyName:(NSString * _Nullable)textFontFamilyName backgroundColor:(NSString * _Nullable)backgroundColor buttonText:(NSString * _Nullable)buttonText headerText:(NSString * _Nullable)headerText OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithTextFontColor:(NSString * _Nullable)textFontColor textFontSize:(NSInteger)textFontSize textFontFamilyName:(NSString * _Nullable)textFontFamilyName SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC11PayU3DS2Kit23PayU3DS2UICustomisation")
@interface PayU3DS2UICustomisation : NSObject
- (nonnull instancetype)initWithButtonCustomisation:(PayU3DS2ButtonCustomisation * _Nullable)buttonCustomisation labelCustomisation:(PayU3DS2LabelCustomisation * _Nullable)labelCustomisation textBoxCustomisation:(PayU3DS2TextBoxCustomisation * _Nullable)textBoxCustomisation toolbarCustomisation:(PayU3DS2ToolBarCustomisation * _Nullable)toolbarCustomisation OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC11PayU3DS2Kit19PayU3DS2UserDefines")
@interface PayU3DS2UserDefines : NSObject
@property (nonatomic, copy) NSString * _Nullable udf1;
@property (nonatomic, copy) NSString * _Nullable udf2;
@property (nonatomic, copy) NSString * _Nullable udf3;
@property (nonatomic, copy) NSString * _Nullable udf4;
@property (nonatomic, copy) NSString * _Nullable udf5;
@property (nonatomic, copy) NSString * _Nullable udf6;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC11PayU3DS2Kit17PayU3DS2Validator")
@interface PayU3DS2Validator : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC11PayU3DS2Kit23PayU3DS2ValidatorHelper")
@interface PayU3DS2ValidatorHelper : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


#endif
#if defined(__cplusplus)
#endif
#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop
#endif

#else
#error unsupported Swift architecture
#endif
