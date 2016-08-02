//
//  Tools.h
//  GiveYaoYaoDemo
//
//  Created by enway_liang on 16/4/12.
//  Copyright © 2016年 wangbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sys/utsname.h"
#import <UIKit/UIKit.h>
@interface Tools : NSObject

+(id)shareInstance;
/**
 *  获取现在时间
 */
+(NSDate *)getNowData;

/**
 *  今天是X年X月
 */
+(NSString *)getYearAndMonth:(NSDate *)currentDay;

/**
 *  今天是X号
 */
+(NSUInteger)getCurrDay:(NSDate *)currentDay;
/**
 *  这个月有多少天
 */
+(NSUInteger)numberOfDaysInCurrentMonth:(NSDate *)CurrentMonth;
/**
 *  这个月的第一天
 */
+(NSDate *)firstDayOfCurrentMonth:(NSDate *)whichDay;
/**
 *  这个月第一天是周几
 */
+(NSString*)weekdayStringFromDate:(NSDate*)inputDate;
/**
 *  本周的周一和周日是几号
 */
+(NSString *)getWeekTime:(NSDate *)needDate;
/**
 *  判断是不是浮点型
 */
+(BOOL)isPureFloat:(NSString *)string;
/**
 *  判断是不是整形
 */
+(BOOL)isPureInt:(NSString *)string;

+(NSDate *)dateFromString:(NSString *)dateString;


/**
 *  创建Button
 */
+(UIButton *)creatButton:(CGRect)frame btnColor:(UIColor *)btncolor btnTitle:(NSString *)btntitle btnTitleColor:(UIColor *)btntitlecolor btnCornerRadius:(int)cornerRadius btnBorderWidth:(int)borderWidth btnBorderColor:(UIColor *)bordercolor btnTitleFont:(int)font btnTag:(int)btntag;
/**
 *  创建Label
 */
+(UILabel *)creatLabel:(CGRect)frame labColor:(UIColor *)labcolor labTitle:(NSString *)labtitle labTitleColor:(UIColor *)labtitlecolor labCornerRadius:(int)cornerRadius labBorderWidth:(int)borderWidth labBorderColor:(UIColor *)bordercolor labTitleFont:(int)font textAlignment:(NSTextAlignment)textalignment labTag:(int)labtag;
/**
 *  创建TextField
 */
+(UITextField *)creatTextField:(CGRect)frame fieldPlaceholder:(NSString *)fieldplaceholder fieldFont:(int)font fieldAlignment:(NSTextAlignment)fieldalignment fieldCornerRadius:(int)cornerRadius fieldBorderWidth:(int)borderWidth fieldBorderColor:(UIColor *)bordercolor fieldTag:(int)tag;
/**
 *  创建一条分割线
 */
+(UIView *)creatLine:(CGRect)frame viewBagColor:(UIColor *)bagcolor;
/**
 *  将(null)转为@" "
 */
+(NSString *)returnNull:(NSString *)string;
/**
 *  计算字符串的SIZE
 */
+(CGSize)getStringCGSizeWithMaxSize:(CGSize)maxSize WithFont:(UIFont *)font WithString:(NSString *)string;
/**
 *   获得设备信息
 */
+ (NSString *)getDeviceName;
+ (NSString *)getDeviceSystem;
+ (NSString *)getDeviceUUID;
+ (NSString *)getDeviceVersion;


@end
