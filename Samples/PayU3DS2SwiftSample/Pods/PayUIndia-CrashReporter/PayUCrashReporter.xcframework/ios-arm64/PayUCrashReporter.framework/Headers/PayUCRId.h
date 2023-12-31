#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A wrapper around UUID.
 * UUIDs are declared as either 32 character hexadecimal strings without dashes
 * "12c2d058d58442709aa2eca08bf20986", or 36 character strings with dashes
 * "12c2d058-d584-4270-9aa2-eca08bf20986". It is recommended to omit dashes and use UUID v4 in all
 * cases.
 */
@interface PayUCRId : NSObject

/**
 * Creates a PayUCRId with a random PayUCRId.
 */
- (instancetype)init;

/**
 * Creates a PayUCRId with the given UUID.
 */
- (instancetype)initWithUUID:(NSUUID *)uuid;

/**
 * Creates a PayUCRId from a 32 character hexadecimal string without dashes such as
 * "12c2d058d58442709aa2eca08bf20986" or a 36 character hexadecimal string such as such as
 * "12c2d058-d584-4270-9aa2-eca08bf20986".
 *
 * @return PayUCRId.empty for invalid strings.
 */
- (instancetype)initWithUUIDString:(NSString *)string;

/**
 * Returns a 32 lowercase character hexadecimal string description of the PayUCRId, such as
 * "12c2d058d58442709aa2eca08bf20986".
 */
@property (readonly, copy) NSString *CrashReporterIdString;

/**
 * A PayUCRId with an empty UUID "00000000000000000000000000000000".
 */
@property (class, nonatomic, readonly, strong) PayUCRId *empty;

@end

NS_ASSUME_NONNULL_END
