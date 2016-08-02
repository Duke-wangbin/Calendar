//
//  CalendarView.m
//  Thecalendar
//
//  Created by enway_liang on 16/7/27.
//  Copyright © 2016年 wangbin. All rights reserved.
//
#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height
#import "CalendarView.h"
#import "Tools.h"
#import "UIView+Extension.h"
#import "NSDate+Extension.h"

@interface CalendarView ()
{
    
    NSString *timeStr;
    
    UIView *backView;
    NSInteger currDay;
    UILabel *dateLabel;
    UIView *TimeView;
    UIImageView *boom;
    UILabel *topLabel;
    
    UIButton *creat;
    NSString *moringOR;
    NSTimer *timer;
    NSInteger btnTag;
    
}
@end

@implementation CalendarView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (!self.isNew) {
        self.nextDate = [Tools getNowData];
        currDay = [Tools getCurrDay:self.nextDate];//今天是几号
        
    }
    NSArray *weekdays = [NSArray arrayWithObjects:@"日", @"一", @"二", @"三", @"四", @"五", @"六", nil];
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    backView.backgroundColor = [UIColor clearColor];
    [self addSubview:backView];
    dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, backView.width-30, 35)];
    dateLabel.font = [UIFont systemFontOfSize:15];
    timeStr =[Tools getYearAndMonth:self.nextDate];//今天是X年X月
    if (self.isNew==YES) {
        dateLabel.text =timeStr;
    }else{
        NSString *ss = [NSString stringWithFormat:@"%@  %@",timeStr,@"(请选择开始结束日期)"];
        dateLabel.attributedText = [self createAttributrdStr:ss firstTime:timeStr secondTime:@"(请选择开始结束日期)"];
    }
    [backView addSubview:dateLabel];
    for (int i = 0; i < 2; i ++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 34 + 29*i, WIDTH, 1)];
        line.backgroundColor = [UIColor colorWithRed:0.783922 green:0.780392 blue:0.8 alpha:1];
        [backView addSubview:line];
    }
    // 星期
    for (int i = 0; i < 7; i ++) {
        UILabel *la = [[UILabel alloc]init];
        la.font = [UIFont systemFontOfSize:14];
        if (i==0 || i == 6) {
            la.textColor = [UIColor redColor];
        }else{
            la.textColor = [UIColor blackColor];
        }
        la.numberOfLines = 0;
        la.textAlignment = NSTextAlignmentCenter;
        la.frame = CGRectMake(WIDTH/7*i, 35, WIDTH/7, 30);
        la.text = [NSString stringWithFormat:@"%@",weekdays[i]];
        [backView addSubview:la];
    }
    CGFloat VIEWH = 65;
    
    
    NSInteger weight = WIDTH/7;
    NSInteger height = (self.frame.size.height-VIEWH)/6;
    //日历按钮
    for (int i = 0; i < 42; i ++) {
        NSInteger index = i%7;
        NSInteger page = i/7;
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        //        btn.layer.borderWidth = 0.5;
        //        btn.layer.borderColor = [[UIColor blackColor]CGColor];
        //        [btn addTarget:self action:@selector(hiddentMorning) forControlEvents:(UIControlEventTouchUpInside)];
        btn.frame = CGRectMake(index *weight,65+page*height, weight, height);
        [backView  addSubview:btn];
    }
    NSInteger monthDay = [Tools numberOfDaysInCurrentMonth:self.nextDate];//这个月有多少天
    NSDate *bbb = [Tools firstDayOfCurrentMonth:self.nextDate];//本月第一天
    NSString *ss = [Tools weekdayStringFromDate:bbb];//本月第一天是周几
    NSInteger weekF = [ss integerValue];//本月第一天是周几
    //    NSInteger currDay = [Tools getCurrDay:self.nextDate];//今天是几号
    NSDate *curr = [Tools getNowData];
    NSString *a = [Tools getYearAndMonth:self.nextDate];
    NSString *b = [Tools getYearAndMonth:curr];
    //日历日期
    for (int i = 0; i < monthDay; i ++) {
        NSInteger num = 7 - weekF;
        NSInteger index = i % 7;
        NSInteger page = i / 7;
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        btn.tag = 100+i;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(dataAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        if (i < num) {
            btn.frame = CGRectMake(index * weight+weight*weekF, VIEWH+page * height, weight, height);
            
            if (btn.x==0 || btn.x==weight*6) {
                [btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
            }else{
                [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            }
            
        }else{
            if (num==0) {
                NSInteger inde = (i-num) % 7;
                NSInteger pag = (i-num) / 7;
                btn.frame = CGRectMake(inde * weight, VIEWH+pag * height, weight, height);;
                
                if (btn.x==0 || btn.x==weight*6) {
                    [btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
                }else{
                    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
                }
                
            }else{
                NSInteger inde = (i-num) % 7;
                NSInteger pag = (i-num) / 7;
                btn.frame = CGRectMake(inde * weight, VIEWH+pag * height+height, weight, height);
                
                if (btn.x==0 || btn.x==weight*6) {
                    [btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
                }else{
                    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
                }
                
            }
        }
        
        if (i == currDay-1 && a==b) {
            [btn setTitle:@"今天" forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }else if (i<currDay-1){
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }
        [backView  addSubview:btn];
    }
}

#pragma mark --- 点击某个日期
-(void)dataAction:(UIButton *)button{
    [self clickMorningOrAfternoon:button];
}
-(void)clickMorningOrAfternoon:(UIButton *)btn{
    btnTag = btn.tag-99;
    NSLog(@"----%ld",btnTag);
    [topLabel removeFromSuperview];
    [boom removeFromSuperview];
    [TimeView removeFromSuperview];
    [timer timeInterval];
    CGFloat btnx = btn.centerX;
    CGFloat btny = btn.y;
    CGFloat timeW = btn.width * 3;
    TimeView = [[UIView alloc]init];
    TimeView.frame = CGRectMake(btnx-timeW/2, btny-30, timeW, 35);
    TimeView.backgroundColor = [UIColor colorWithRed:54/255.0 green:145/255.0 blue:227/255.0 alpha:1];
    TimeView.layer.cornerRadius = 4;
    [backView addSubview:TimeView];
    boom = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bootom"]];
    boom.frame = CGRectMake(TimeView.centerX-7.5, TimeView.bottom, 15, 7);
    [backView addSubview:boom];
    
    if (btn.x == 0) {
        TimeView.frame = CGRectMake(0, btny-35, timeW, 35);
    }else if (btn.x==btn.width*6){
        TimeView.frame = CGRectMake(btn.width*4, btny-35, timeW, 35);
    }
    NSArray *a = @[@"上午",@"下午",@"晚上"];
    CGFloat linex = TimeView.width/3;
    for (int i = 0; i < 3; i ++) {
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(linex * i-0.5, 5, 1, 25)];
        line1.backgroundColor = [UIColor colorWithRed:114/255.0 green:196/255.0 blue:251/255.0 alpha:1];
        [TimeView addSubview:line1];
        
        UIButton *butt = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [butt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        butt.tag = 10000+i;
        [butt setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
        [butt setTitle:a[i] forState:(UIControlStateNormal)];
        butt.frame = CGRectMake(TimeView.width/3 * i, 0, TimeView.width/3, 35);
        butt.backgroundColor = [UIColor clearColor];
        butt.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [butt addTarget:self action:@selector(pickTimeAction:) forControlEvents:(UIControlEventTouchUpInside)];
        if (i==0) {
            butt.selected=YES;
        }
        [TimeView addSubview:butt];
    }
    topLabel = [[UILabel alloc]initWithFrame:CGRectMake(btn.centerX-14, btn.centerY-14, 28, 28)];
    topLabel.backgroundColor = [UIColor whiteColor];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.font = [UIFont systemFontOfSize:15];
    topLabel.text = btn.titleLabel.text;
    topLabel.layer.borderWidth = 0.5;
    topLabel.layer.borderColor = [[UIColor colorWithRed:54/255.0 green:145/255.0 blue:227/255.0 alpha:1]CGColor];
    topLabel.layer.cornerRadius = 12.5;
    topLabel.textColor = [UIColor colorWithRed:54/255.0 green:145/255.0 blue:227/255.0 alpha:1];
    topLabel.adjustsFontSizeToFitWidth=YES;
    [backView addSubview:topLabel];
}
#pragma mark ---- 选择上午\中午\晚上
-(void)pickTimeAction:(UIButton *)butt{
    
    [self StartOrEndAction:butt.titleLabel.text btnTag:btnTag];
    
}
#pragma mark ---- 开始或者结束
-(void)StartOrEndAction:(NSString *)btnText btnTag:(NSInteger)tag{
    
    
    NSInteger inte = tag;
    NSString *ss;
    
    if (inte<10) {
        ss = [NSString stringWithFormat:@"0%ld",(long)inte];
    }else{
        ss = [NSString stringWithFormat:@"%ld",(long)inte];
    }
    
    NSString *timeS = [NSString stringWithFormat:@"%@-%@",timeStr,ss];
    if ([_NowOrNext isEqualToString:@"开始"]) {
        
        //选择了开始时间
        self.isChoose=YES;
        
        if (_jieshuTime.length>0) {
            
            NSDate *jieshu = [Tools dateFromString:_jieshuTime];
            NSDate *time = [Tools dateFromString:timeS];
            NSInteger inter = [NSDate getDayNumbertoDay1:time beforDay:jieshu];
            if (inter>=0) {
                if ([self.delegate respondsToSelector:@selector(ClickStartDate:andWhattime:)]) {
                    [self.delegate ClickStartDate:timeS andWhattime:btnText];
                }
                [boom removeFromSuperview];
                [TimeView removeFromSuperview];
            }else{
                [self loadAlertView:@"开始时间不能晚于结束时间"];
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(ClickStartDate:andWhattime:)]) {
                [self.delegate ClickStartDate:timeS andWhattime:btnText];
            }
            [boom removeFromSuperview];
            [TimeView removeFromSuperview];
        }
    }else{
        if (_kaishiTime.length>0) {
            NSDate *kaishi = [Tools dateFromString:_kaishiTime];
            NSDate *time = [Tools dateFromString:timeS];
            NSInteger inter = [NSDate getDayNumbertoDay1:kaishi beforDay:time];
            
            if (inter>=0) {
                if ([self.delegate respondsToSelector:@selector(ClickEndDate:andWhattime:)]) {
                    [self.delegate ClickEndDate:timeS andWhattime:btnText];
                }
                [boom removeFromSuperview];
                [TimeView removeFromSuperview];
                
            }else{
                
                [self loadAlertView:@"结束时间不能早于开始时间"];
                
            }
        }else{
            
            
            if ([self.delegate respondsToSelector:@selector(ClickEndDate:andWhattime:)]) {
                [self.delegate ClickEndDate:timeS andWhattime:btnText];
            }
            [boom removeFromSuperview];
            [TimeView removeFromSuperview];
        }
    }
    
}
//-(void)loadTopView:(UIButton *)StartButton{
//
//    UILabel *albel = [[UILabel alloc]initWithFrame:CGRectMake(StartButton.centerX-14, StartButton.centerY-14, 28, 28)];
//    albel.backgroundColor = [UIColor clearColor];
//    albel.textAlignment = NSTextAlignmentCenter;
//    albel.font = [UIFont systemFontOfSize:15];
//    albel.text = StartButton.titleLabel.text;
//    albel.layer.borderWidth = 0.5;
//    albel.layer.borderColor = [[UIColor colorWithRed:54/255.0 green:145/255.0 blue:227/255.0 alpha:1]CGColor];
//    albel.layer.cornerRadius = 12.5;
//    albel.textColor = [UIColor colorWithRed:54/255.0 green:145/255.0 blue:227/255.0 alpha:1];
//    albel.adjustsFontSizeToFitWidth=YES;
//    [backView addSubview:albel];
//
//}

//-(void)timerFire:(id)userinfo {
//    NSLog(@"Fire");
//    [topLabel removeFromSuperview];
//    [boom removeFromSuperview];
//    [TimeView removeFromSuperview];
//    [timer timeInterval];
//}

//富文本
- (NSAttributedString *)createAttributrdStr:(NSString *)totalStr firstTime:(NSString *)firstTime secondTime: (NSString *)secondTime
{
    NSRange firstRange = [totalStr rangeOfString:firstTime];
    NSRange secondRange = [totalStr rangeOfString:secondTime];
    NSMutableAttributedString * attrributedStr = [[NSMutableAttributedString alloc] initWithString:totalStr];
    [attrributedStr addAttribute:NSForegroundColorAttributeName
                           value:[UIColor blackColor]
                           range:firstRange];
    [attrributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:firstRange];
    [attrributedStr addAttribute:NSForegroundColorAttributeName
                           value:[UIColor grayColor]
                           range:secondRange];
    [attrributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:secondRange];
    return attrributedStr;
}
-(void)loadAlertView:(NSString *)string{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}


@end
