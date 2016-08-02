//
//  CalendarView.h
//  Thecalendar
//
//  Created by enway_liang on 16/7/27.
//  Copyright © 2016年 wangbin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CalendarViewDelegate <NSObject>


-(void)ClickStartDate:(NSString *)string andWhattime:(NSString *)time;
-(void)ClickEndDate:(NSString *)string andWhattime:(NSString *)time;

@end
@interface CalendarView : UIView
@property (nonatomic,strong)NSDate *nextDate;
@property (nonatomic,assign) CGRect rectCG;
@property (nonatomic,assign) BOOL isNew;
@property (nonatomic,assign) BOOL isChoose;
@property (nonatomic,copy) NSString *NowOrNext;
@property (nonatomic,assign)id<CalendarViewDelegate>delegate;
@property (nonatomic,copy) NSString *kaishiTime;
@property (nonatomic,copy)NSString *jieshuTime;
@end
