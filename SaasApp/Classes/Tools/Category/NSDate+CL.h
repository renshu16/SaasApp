//
//  NSDate+CL.h
//  CLWeeklyCalendarView
//
//  Created by Caesar on 10/12/2014.
//  Copyright (c) 2014 Caesar. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TIME_PICK_MINS_INTERVAL  15
#define TIME_A_Quarter           (TIME_PICK_MINS_INTERVAL * 60)   
#define DATE_PICK_MAX            (24*60*60 * 365)

@interface NSDate (CL)
-(NSDate *)addDays:(NSInteger)day;
/**
 *  获取本周第一天的日期
 */
-(NSDate *)getWeekStartDate: (NSInteger)weekStartIndex;
-(NSString *)getDayOfWeekShortString;
-(NSString *)getDateOfMonth;
-(BOOL) isSameDateWith: (NSDate *)dt;
- (BOOL)isDateToday;
- (BOOL)isWithinDate: (NSDate *)earlierDate toDate:(NSDate *)laterDate;
- (BOOL)isPastDate;

/**
 *  获取当前时间最近的一个整15分钟的时间 0～14分->15分，15～29分->30分...
 */
-(NSDate *)getRecentQuarterDate;

/**
 *  获取当前日期的指定时间的Date
 *
 *  @param timeStr 指定HHMMSS
 *
 *  @return 转换时间之后的Data
 */
-(NSDate *)getCurrentDateWithTimeString:(NSString *)timeStr;
@end
