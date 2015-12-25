//
//  StirngUtils.h
//  SaasApp
//
//  Created by ToothBond on 15/11/7.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface StringUtils : NSObject

#pragma mark - 时间

/**
 *  获取两个日期之间的天数差
 *
 *  @param from   起始日期
 *  @param to     结束日期
 *  @param format 时间格式
 *
 *  @return 天数差
 */
+ (NSInteger)numberOfDaysFrom:(NSString *)from to:(NSString *)to timeStringFormat:(NSString *)format;

/**
 *  获取指定日期距离今天的天数差
 *
 *  @param time   指定日期时间
 *  @param format 时间格式
 *
 *  @return 日期差 >0 未来，=0 今天，＝-1 昨天
 */
+ (NSInteger)numberOfDaysFromTodayByTime:(NSString *)time timeStringFormat:(NSString *)format;

+ (NSString *)tomorrowDate;
/**
 *  获取当前的日期 格式：yyyy-MM-dd
 */
+ (NSString *)currentDate;
/**
 *  根据时间格式获取当前时间
 */
+ (NSString *)currentTimeWithFormat:(NSString *)format;
/**
 *  时间转String
 */
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;

/**
 *  string转时间
 */
+ (NSDate *)dateFromString:(NSString *)str format:(NSString *)format;

#pragma mark - 加密 解密

+ (NSString *)MD5encode:(NSString *)string;

+ (NSString *)BASE64encode:(NSString *)string;
+ (NSString *)BASE64decode:(NSString *)secret;

/**
 *  DES加密
 *
 *  @param string 明文
 *  @param key    密钥
 *
 *  @return 密文
 */
+ (NSString *)DESencode:(NSString *)string;
+ (NSString *)DESencode:(NSString *)string withKey:(NSString *)key;


/**
 *  DES解密
 *
 *  @param secret 密文
 *  @param key    密钥
 *
 *  @return 明文
 */
+ (NSString *)DESdecode:(NSString *)secret;
+ (NSString *)DESdecode:(NSString *)secret withKey:(NSString *)key;

+ (NSString *)stringFromData:(NSData *)data;

#pragma mark - 字符串操作常用方法
+ (BOOL)isEmptyString:(NSString *)str;
+ (NSString *)stringByTrim:(NSString *)str;

@end
