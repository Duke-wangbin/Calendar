//
//  ViewController.m
//  Thecalendar
//
//  Created by enway_liang on 16/7/27.
//  Copyright © 2016年 wangbin. All rights reserved.
#define SCREENWIDTH                         [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT                        [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "CalendarView.h"
#import "Tools.h"
#import "UIView+Extension.h"
#import "NSDate+Extension.h"
@interface ViewController ()<UIScrollViewDelegate,CalendarViewDelegate>
{
    UIScrollView *Scroll;
    int flag;
    CalendarView *dateView;
    CGFloat viewHeight;
    NSDate *Nowdate;
    NSString *startString;
    NSString *endString;
    BOOL isNow;
    NSString *startDay;
    NSString *endDay;
    
}
@property (nonatomic,strong) UIView *shadowView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日历";
    self.view.backgroundColor = [UIColor whiteColor];
    Nowdate = [Tools getNowData];

    
    
    NSArray *a = @[@"开始时间",@"结束时间"];
    for (int i = 0; i < 2; i ++) {
        
        UILabel *label = [Tools creatLabel:CGRectMake(30, 100+44*i+30*i, [UIScreen mainScreen].bounds.size.width-60, 44) labColor:[UIColor clearColor] labTitle:a[i] labTitleColor:[UIColor blackColor] labCornerRadius:6 labBorderWidth:1 labBorderColor:[UIColor redColor] labTitleFont:15 textAlignment:NSTextAlignmentCenter labTag:200+i];
        
        [self.view addSubview:label];
        
        UIButton *button = [Tools creatButton:label.frame btnColor:[UIColor clearColor] btnTitle:@"" btnTitleColor:[UIColor clearColor] btnCornerRadius:0 btnBorderWidth:0 btnBorderColor:[UIColor clearColor] btnTitleFont:0 btnTag:100+i];
        
        [button addTarget:self action:@selector(timePickAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:button];
        
        
    }
    
}
-(void)timePickAction:(UIButton *)btn{
    
    
    flag=0;
    self.shadowView = [[UIView alloc]init];
    self.shadowView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    self.shadowView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    [self.view addSubview:self.shadowView];
    
    CGRect firstRect = CGRectMake(10, SCREENHEIGHT, SCREENWIDTH-20, 0);
    CGRect secondRect = CGRectMake(10, SCREENHEIGHT-SCREENHEIGHT*0.7, SCREENWIDTH-20, SCREENHEIGHT*0.7);
    
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *backView = [[UIVisualEffectView alloc] initWithEffect:effect];
    backView.alpha = 0.3;
    backView.layer.cornerRadius=3;
    backView.frame = firstRect;
    [self.shadowView addSubview:backView];
    
    Scroll = [[UIScrollView alloc]init];
    Scroll.showsVerticalScrollIndicator = NO;
    Scroll.scrollEnabled = YES;
    Scroll.bounces = NO;
    Scroll.frame = firstRect;
    Scroll.layer.cornerRadius = 5;
    Scroll.backgroundColor = [UIColor whiteColor];
    Scroll.alpha = 0.8;
    Scroll.delegate = self;
    [self.shadowView addSubview:Scroll];
    
    UIButton *cancel = [UIButton buttonWithType:(UIButtonTypeCustom)];
    cancel.backgroundColor = [UIColor whiteColor];
    cancel.frame = firstRect;
    cancel.layer.cornerRadius = 5;
    [cancel setTitle:@"取消" forState:(UIControlStateNormal)];
    [cancel setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    cancel.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancel addTarget:self action:@selector(removeShadowView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.shadowView addSubview:cancel];
    [UIView animateWithDuration:0.3 animations:^{
        backView.frame = secondRect;
        Scroll.frame = CGRectMake(10, SCREENHEIGHT-SCREENHEIGHT*0.7, backView.width, backView.height-54);
        cancel.frame = CGRectMake(10, Scroll.bottom+10, backView.width, 40);
        dateView = [[CalendarView alloc]initWithFrame:CGRectMake(0, 0, Scroll.width, Scroll.height-40)];
        viewHeight = Scroll.height;
        dateView.backgroundColor = [UIColor clearColor];
        dateView.nextDate = Nowdate;
        dateView.kaishiTime = startString;
        dateView.jieshuTime = endString;
        dateView.delegate = self;
        if (btn.tag == 100) {
            dateView.NowOrNext = @"开始";
            isNow = YES;
        }else{
            isNow = NO;
            dateView.NowOrNext = @"结束";
        }
        [Scroll addSubview:dateView];
        
    }];
    Scroll.contentSize = CGSizeMake(0, viewHeight*2);
    Scroll.contentOffset = CGPointMake(0, 1.5);
}
-(void)loadDateView{
    //    UIButton *btn = (UIButton *)[self.view viewWithTag:10000];
    flag ++;
    dateView = [[CalendarView alloc]initWithFrame:CGRectMake(0, viewHeight * flag-40, Scroll.width, Scroll.height)];
    dateView.backgroundColor = [UIColor clearColor];
    NSDate *date =[Nowdate dayInTheFollowingMonth:flag];
    dateView.nextDate = date;
    dateView.isNew = YES;
    dateView.kaishiTime = startString;
    dateView.jieshuTime = endString;
    dateView.delegate = self;
    dateView.tag = flag;
    if (isNow == YES) {
        dateView.NowOrNext = @"开始";
    }else{
        dateView.NowOrNext = @"结束";
    }
    [Scroll addSubview:dateView];
    Scroll.contentSize = CGSizeMake(0, viewHeight*(flag+1));
    
    
}
// 滚动就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat VIEWH = SCREENHEIGHT*0.7-55;
    if (scrollView==Scroll) {
        CGPoint point = scrollView.contentOffset;
        CGFloat scrollH = VIEWH*flag;
        if (point.y>scrollH) {
            [self loadDateView];
        }
    }
}
-(void)removeShadowView{
    [self.shadowView removeFromSuperview];
}
#pragma mark --- CalendarViewDelegate
-(void)ClickStartDate:(NSString *)string andWhattime:(NSString *)time{
    startString = string;
    startDay = time;
    [self removeShadowView];
    UILabel *alabel = (UILabel *)[self.view viewWithTag:200];
    
    alabel.text = [NSString stringWithFormat:@"%@ %@",[string substringFromIndex:5],time];
}
-(void)ClickEndDate:(NSString *)string andWhattime:(NSString *)time{
    endString=string;
    endDay = time;

    UILabel *alabel = (UILabel *)[self.view viewWithTag:201];

    
    [self removeShadowView];
    alabel.text = [NSString stringWithFormat:@"%@ %@",[string substringFromIndex:5],time];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
