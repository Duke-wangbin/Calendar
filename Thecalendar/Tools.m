//
//  Tools.m
//  GiveYaoYaoDemo
//
//  Created by enway_liang on 16/4/12.
//  Copyright © 2016年 wangbin. All rights reserved.
//

#import "Tools.h"

@implementation Tools

static Tools *_instance = nil;
+(id)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL]init];
    });

    return _instance;
}
+(id)allocWithZone:(struct _NSZone *)zone{
    return [Tools shareInstance];
}
-(id)copyWithZone:(struct _NSZone *)zone
{
    return [Tools shareInstance] ;
}

/**
 *  获取现在时间
 */
+(NSDate *)getNowData{
    
    NSDate *today = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: today];
    today = [today  dateByAddingTimeInterval: interval];
    return today;
}
/**
 *  今天是X年X月
 */
+(NSString *)getYearAndMonth:(NSDate *)currentDay{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *strtime =[dateFormatter stringFromDate:currentDay];
    return strtime;
    
}
/**
 *  今天是X号
 */
+(NSUInteger)getCurrDay:(NSDate *)currentDay{
    
    NSDate *pickerDate = [self getNowData];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    NSString *strtime =[dateFormatter stringFromDate:pickerDate];
    
    NSInteger inrerTime = [strtime integerValue];
    return inrerTime;
}
/**
 *  这个月有多少天
 */
+(NSUInteger)numberOfDaysInCurrentMonth:(NSDate *)CurrentMonth
{
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit: NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:CurrentMonth];
    return  days.length;
}
/**
 *  这个月的第一天
 */
+(NSDate *)firstDayOfCurrentMonth:(NSDate *)whichDay
{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:whichDay];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:startDate];
    startDate = [startDate  dateByAddingTimeInterval:interval];
    return startDate;
}
/**
 *  这个月第一天是周几
 */
+(NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"7", @"1", @"2", @"3", @"4", @"5", @"6", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}
/**
 *  本周的周一和周日是几号
 */

+(NSString *)getWeekTime:(NSDate *)needDate
{
    NSDate *nowDate = needDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSDayCalendarUnit fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取几天是几号
    NSInteger day = [comp day];
//    NSLog(@"%ld----%ld",(long)weekDay,(long)day);
    
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    //    weekDay = 1;
    if (weekDay == 1)
    {
        firstDiff = -6;
        lastDiff = 0;
    }
    else
    {
        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 8 - weekDay;
    }
//    NSLog(@"firstDiff: %ld   lastDiff: %ld",firstDiff,lastDiff);
    
    // 在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit  fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit   fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];
    NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];
//    NSLog(@"%@=======%@",firstDay,lastDay);
    
    NSString *dateStr = [NSString stringWithFormat:@"%@<>%@",firstDay,lastDay];
    
    return dateStr;
    
}
/**
 *  判断是不是浮点型
 */
+(BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}
/**
 *  判断是不是整形
 */
+(BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+(NSDate *)dateFromString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}




/**
 *  创建Button
 */
+(UIButton *)creatButton:(CGRect)frame btnColor:(UIColor *)btncolor btnTitle:(NSString *)btntitle btnTitleColor:(UIColor *)btntitlecolor btnCornerRadius:(int)cornerRadius btnBorderWidth:(int)borderWidth btnBorderColor:(UIColor *)bordercolor btnTitleFont:(int)font btnTag:(int)btntag{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = frame;
    [button setTitle:btntitle forState:(UIControlStateNormal)];
    [button setTitleColor:btntitlecolor forState:(UIControlStateNormal)];
    button.backgroundColor = btncolor;
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.layer.cornerRadius = cornerRadius;
    button.layer.borderWidth = borderWidth;
    button.layer.borderColor = bordercolor.CGColor;
    button.tag = btntag;
    return button;
}
/**
 *  创建Label
 */
+(UILabel *)creatLabel:(CGRect)frame labColor:(UIColor *)labcolor labTitle:(NSString *)labtitle labTitleColor:(UIColor *)labtitlecolor labCornerRadius:(int)cornerRadius labBorderWidth:(int)borderWidth labBorderColor:(UIColor *)bordercolor labTitleFont:(int)font textAlignment:(NSTextAlignment)textalignment labTag:(int)labtag{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = labcolor;
    label.text = labtitle;
    label.textColor = labtitlecolor;
    label.textAlignment = textalignment;
    label.font = [UIFont systemFontOfSize:font];
    label.layer.cornerRadius = cornerRadius;
    label.layer.borderWidth = borderWidth;
    label.layer.borderColor = bordercolor.CGColor;
    label.tag = labtag;
    return label;
}
/**
 *  创建TextField
 */
+(UITextField *)creatTextField:(CGRect)frame fieldPlaceholder:(NSString *)fieldplaceholder fieldFont:(int)font fieldAlignment:(NSTextAlignment)fieldalignment fieldCornerRadius:(int)cornerRadius fieldBorderWidth:(int)borderWidth fieldBorderColor:(UIColor *)bordercolor fieldTag:(int)tag{
    UITextField *field = [[UITextField alloc]initWithFrame:frame];
    field.placeholder = fieldplaceholder;
    field.font = [UIFont systemFontOfSize:font];
    field.textAlignment = fieldalignment;
    field.layer.cornerRadius = cornerRadius;
    field.layer.borderWidth = borderWidth;
    field.layer.borderColor = bordercolor.CGColor;
    field.tag = tag;
    return field;
}
/**
 *  创建一条分割线
 */
+(UIView *)creatLine:(CGRect)frame viewBagColor:(UIColor *)bagcolor{
    UIView *line = [[UIView alloc]initWithFrame:frame];
    if (bagcolor==nil) {
        line.backgroundColor = [UIColor colorWithRed:0.783922 green:0.780392 blue:0.8 alpha:1];
    }else{
    line.backgroundColor = bagcolor;
    }
    return line;
}
/**
 *  将(null)转为@" "
 */
+(NSString *)returnNull:(NSString *)string{
    string = [NSString stringWithFormat:@"%@",string];
    if (string.length==0) {
        string = @" ";
    }else{
        string = string;
    }
    return string;
}
/**
 *  计算字符串的SIZE
 */
+(CGSize)getStringCGSizeWithMaxSize:(CGSize)maxSize WithFont:(UIFont *)font WithString:(NSString *)string
{
    NSDictionary * attres=@{NSFontAttributeName:font};
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attres context:nil].size;
    
}
#pragma mark -- 设备信息相关
+ (NSString *)getDeviceName
{
    return [UIDevice currentDevice].name;
}

+ (NSString *)getDeviceSystem
{
    return [UIDevice currentDevice].systemName;
}

+ (NSString *)getDeviceUUID
{
    return [[UIDevice currentDevice] identifierForVendor].UUIDString;
}
+ (NSString *)getDeviceVersion{

    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";

    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceString isEqualToString:@"iPad4,4"]||[deviceString isEqualToString:@"iPad4,5"] ||[deviceString isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
     if ([deviceString isEqualToString:@"iPad4,7"]||[deviceString isEqualToString:@"iPad4,8"]||[deviceString isEqualToString:@"iPad4,9"])  return @"iPad mini 3";
    return deviceString;
}

@end
