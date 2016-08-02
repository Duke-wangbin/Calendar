//
//  NSDate+Extension.h
//  ExerciseDemo
//
//  Created by 赵帅 on 16/1/27.
//  Copyright © 2016年 赵帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

- (NSInteger)numberOfDaysInCurrentMonth;
- (NSInteger)numberOfWeeksInCurrentMonth;
/**
 *  这个月第一天的日期
 *
 *  @return 这个月第一天的日期
 */
- (NSDate *)firstDayOfCurrentMonth;
/**
 *  第一天是礼拜几
 *
 *  @return 第一天是礼拜几
 */
- (NSInteger)weeklyOrdinality;
/**
 *  这个月的最后一天
 *
 *  @return 这个月的最后一天
 */
- (NSDate *)lastDayOfCurrentmonth;
/**
 *  上一个月
 *
 *  @return 上一个月
 */
- (NSDate *)dayInThePreviousMonth;
/**
 *  下一个月
 *
 *  @return 下一个月
 */
- (NSDate *)dayInTheFollowingMonth;
/**
 *  当前日期后的几个月
 *
 *  @param month 相隔的月数
 *
 *  @return 当前日期后的几个月
 */
- (NSDate *)dayInTheFollowingMonth:(int)month;
/**
 *  当前日期后的几天
 *
 *  @param day 相隔的天数
 *
 *  @return 当前日期后的几天
 */
- (NSDate *)dayInTheFollowingDay:(int)day;
- (NSDateComponents *)Components;
- (NSString *)stringFromDate;

+(NSString *)getWeekStringFromInteger:(int)week;
/**
 *  计算两个日期之间的差值
 *
 *  @param today    第一个日子
 *  @param beforday 第二个日子
 *
 *  @return 差值
 */
+ (NSInteger)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday;//月
//判断两个日期相差多远
+ (NSInteger)getDayNumbertoDay1:(NSDate *)today beforDay:(NSDate *)beforday;//小时


-(NSString *)compareIfTodayWithDate;
- (int)getWeekIntValueWithDate;

+ (NSDate *)dateFromString:(NSString *)dateString;
//NSString1转NSDate
+ (NSDate *)dateFromString1:(NSString *)dateString;
@end
