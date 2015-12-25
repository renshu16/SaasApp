//
//  StirngUtils.m
//  SaasApp
//
//  Created by ToothBond on 15/11/7.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "StringUtils.h"
#include <sys/stat.h>
#include <dirent.h>
#import "CommonCrypto/CommonDigest.h"
#import "sys/utsname.h"

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";//设置编码

@implementation StringUtils
+ (NSInteger)numberOfDaysFrom:(NSString *)from to:(NSString *)to timeStringFormat:(NSString *)format
{
    NSTimeZone *localTimeZone = [NSTimeZone systemTimeZone];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:localTimeZone];
    [formatter setDateFormat:NSLocalizedString(format,nil)];
    
    NSDate *fromDate = [formatter dateFromString:from];
    NSDate *fromDate2 = [formatter dateFromString:[formatter stringFromDate:fromDate]];
    NSDate *toDate = [formatter dateFromString:to];
    NSDate *toDate2 = [formatter dateFromString:[formatter stringFromDate:toDate]];
    
    double dFrom = [fromDate2 timeIntervalSince1970];
    double dTo = [toDate2 timeIntervalSince1970];
    
    NSInteger nSecs = (NSInteger)(dTo - dFrom);
    NSInteger oneDaySecs = 24*3600;
    return nSecs / oneDaySecs;
}


+ (NSInteger)numberOfDaysFromTodayByTime:(NSString *)time timeStringFormat:(NSString *)format
{
    // format可以形如： @"yyyy-MM-dd"
    
    NSDate *today = [NSDate date];
    
    NSTimeZone *localTimeZone = [NSTimeZone systemTimeZone];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:localTimeZone];
    [formatter setDateFormat:NSLocalizedString(format,nil)];
    
    // 时分秒转为00:00:00
    NSDate *today2 = [formatter dateFromString:[formatter stringFromDate:today]];
    
    NSDate *newDate = [formatter dateFromString:time];
    // 时分秒转为00:00:00
    NSDate *newDate2 = [formatter dateFromString:[formatter stringFromDate:newDate]];
    
    double dToday = [today2 timeIntervalSince1970];
    double dNewDate = [newDate2 timeIntervalSince1970];
    
    NSInteger nSecs = (NSInteger)(dNewDate - dToday);
    NSInteger oneDaySecs = 24*3600;
    return nSecs / oneDaySecs;
}

+ (NSString *)tomorrowDate
{
     NSDate *tomorrowDate = [NSDate dateWithTimeIntervalSinceNow:24*60*60];
    return [self stringFromDate:tomorrowDate format:@"yyyy-MM-dd"];
}

+ (NSString *)currentDate
{
    return [self currentTimeWithFormat:@"yyyy-MM-dd"];
}

+ (NSString *)currentTimeWithFormat:(NSString *)format
{
    NSDate *nowDate = [NSDate date];
    return [self stringFromDate:nowDate format:format];
}

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formatter setLocale:locale];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)str format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formatter setLocale:locale];
    [formatter setDateFormat:format];
    return [formatter dateFromString:str];}

+ (NSString *)MD5encode:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //CC_MD5(cStr, strlen(cStr), result);
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+ (NSString *)BASE64encode:(NSString *)string
{
    if ([self isEmptyString:string]) {
        return @"";
    }
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self base64Encoding:data];
}
+ (NSString *)BASE64decode:(NSString *)secret
{
    if ([self isEmptyString:secret]) {
        return @"";
    }
    NSData *data = [self dataWithBase64EncodedString:secret];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

+ (NSString *)DESencode:(NSString *)string;
{
    //取项目的bundleIdentifier作为KEY
    //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
    NSString *key = @"com.aiyacloud.app";
    return [StringUtils DESencode:string withKey:key];
}

+ (NSString *)DESencode:(NSString *)string withKey:(NSString *)key
{
    if (string && ![StringUtils isEmptyString:string]) {
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin
        data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [StringUtils base64Encoding:data];          //base64EncodedStringFrom
    }
    else {
        return @"";
    }
}

+ (NSString *)DESdecode:(NSString *)secret
{
    NSString *key = [[NSBundle mainBundle] bundleIdentifier];
    return [StringUtils DESdecode:secret withKey:key];;
}
+ (NSString *)DESdecode:(NSString *)secret withKey:(NSString *)key
{
    if (secret && ![StringUtils isEmptyString:secret]) {
        NSData *data = [self dataWithBase64EncodedString:secret];
        //IOS 自带DES解密 Begin
        data = [self DESDecrypt:data WithKey:key];
        //IOS 自带DES解密 End
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return @"";
    }
}

+(NSString *)base64Encoding:(NSData*)_data
{//调用base64的方法
    
    if ([_data length] == 0)
        return @"";
    
    char *characters = malloc((([_data length] + 2) / 3) * 4);
    
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [_data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [_data length])
            buffer[bufferLength++] = ((char *)[_data bytes])[i++];
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES] ;
}

+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:@"%@",@"String is nil"];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

+(NSString *)stringFromData:(NSData *)data
{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}

#pragma mark -


+ (BOOL)isEmptyString:(NSString *)str
{
    if (str == nil || str == NULL || [str isKindOfClass:[NSNull class]] || str.length == 0 || [str isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

+ (NSString *)stringByTrim:(NSString *)str
{
    NSCharacterSet *character= [NSCharacterSet whitespaceCharacterSet];
    return [str stringByTrimmingCharactersInSet:character];
}

+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}


@end
