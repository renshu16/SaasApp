//
//  NSString+TBString.m
//  SaasApp
//
//  Created by ToothBond on 15/11/12.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "NSString+TBString.h"

@implementation NSString (TBString)


- (BOOL)isEmptyString
{
    if (self == nil || self.length == 0 || [self isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

- (NSString *)stringByTrim
{
    NSCharacterSet *character= [NSCharacterSet whitespaceCharacterSet];
    return [self stringByTrimmingCharactersInSet:character];
}

@end
