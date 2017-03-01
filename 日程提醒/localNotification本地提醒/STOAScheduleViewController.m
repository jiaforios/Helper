//
//  STOAScheduleViewController.m
//  Saftop_moblieOA
//
//  Created by AG_TigerNong on 16/12/12.
//  Copyright © 2016年 Saftop. All rights reserved.
//

#import "STOAScheduleViewController.h"
#import "JTCalendar.h"
#import "SVProgressHUD.h"
#import "STLocalNotiTool.h"

#import "STOASchduleDetailViewController.h"

#define screenWidth ([UIScreen mainScreen].bounds.size.width)
#define screenHeight ([UIScreen mainScreen].bounds.size.height)

#define backColor [UIColor colorWithRed:238/255.0 green:238/255.0 blue:244/255.0 alpha:1.0]

#define naviBarColor [UIColor colorWithRed:12 / 255.0 green:23 / 255.0 blue:41 / 255.0 alpha:1.0]

#define selectBackColor [UIColor colorWithRed:10 / 255.0 green:171 / 255.0 blue:255 / 255.0 alpha:1.0]

#define monthAndYearColor [UIColor colorWithRed:226/255.0 green:233/255.0 blue:231/255.0 alpha:1.0]

@interface STOAScheduleViewController ()<JTCalendarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calenderMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calenderShowView;

@property (weak, nonatomic) IBOutlet UIButton *preButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;
@property (weak, nonatomic) IBOutlet UIView *contentItemView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (nonatomic, strong) NSMutableDictionary *eventsByDate;

@property (nonatomic, strong)  NSDate *dateSelected;

@property (nonatomic, strong)  NSDate *todayDate;

@property (nonatomic, strong)  NSDate *minDate;

@property (nonatomic, strong)  NSDate *maxDate;

@end

@implementation STOAScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initCalendar];
    
    [self setUpNavi];

    self.viewWidth.constant = screenWidth;
    self.viewHeight.constant = screenHeight - 64;
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //开启本地通知
    [[STLocalNotiTool shareLocalNotiTool] scheduleLocalNotification];
    
    //移除毕当前时间早的本地通知
    [[STLocalNotiTool shareLocalNotiTool] removeEarlierThenCurrentTimeLocalNitofication];
}

- (void)setUpNavi{
    
    self.title = @"我的日程";
    
}



//初始化时间
- (void)initCalendar{
    
    [self setUpButton:self.nextButton];
    [self setUpButton:self.preButton];
    self.contentItemView.backgroundColor = monthAndYearColor;
    self.calenderMenuView.backgroundColor = monthAndYearColor;
    
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
     [self createRandomEvents];
    
    _calenderMenuView.contentRatio = .75;
    _calendarManager.settings.weekDayFormat = JTCalendarWeekDayFormatSingle;
    _calendarManager.dateHelper.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    
    [_calendarManager setMenuView:_calenderMenuView];
    [_calendarManager setContentView:self.calenderShowView];
    [_calendarManager setDate:[NSDate date]];
    
}

- (void)setUpButton:(UIButton *)button{
    
    button.layer.cornerRadius = 12.5;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [UIColor darkGrayColor].CGColor;
    button.layer.borderWidth = 1;
    button.backgroundColor = monthAndYearColor;
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
}

- (void)createRandomEvents
{
    self.eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        NSString *key = [[self dayDateFormatter] stringFromDate:randomDate];
        
        if(!_eventsByDate[key]){
            _eventsByDate[key] = [NSMutableArray new];
        }
        
        [_eventsByDate[key] addObject:randomDate];
    }
}


- (BOOL)haveEventForDay:(NSDate *)date
{
    NSString *key = [[self dayDateFormatter] stringFromDate:date];

    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){

        return YES;
    }
    
    return NO;
    
}

#pragma mark - CalendarManager delegate

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    dayView.hidden = NO;
    
    if([dayView isFromAnotherMonth]){
        dayView.hidden = YES;
    }
    
    else if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = naviBarColor;
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = selectBackColor;
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = selectBackColor;
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}


- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    //开始时间
    NSTimeInterval nowTime = [zone secondsFromGMTForDate:[NSDate date]];
    NSDate *now = [[NSDate date] dateByAddingTimeInterval:(nowTime - 24 * 3600)];
    
    //选中的时间
    NSTimeInterval time = [zone secondsFromGMTForDate:dayView.date];
    NSDate *dateNow = [dayView.date dateByAddingTimeInterval:time];
    
    if([_calendarManager.dateHelper date:now isEqualOrAfter:dateNow]){
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showInfoWithStatus:@"只能选择今天或者今天之后的日期"];
        return;
    }
    
    _dateSelected = dateNow;
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        
                        [_calendarManager reload];
                    } completion:nil];
    
    
    if(_calendarManager.settings.weekModeEnabled){
        return;
    }
    
    
    if(![_calendarManager.dateHelper date:self.calenderShowView.date isTheSameMonthThan:dateNow]){
        if([self.calenderShowView.date compare:dateNow] == NSOrderedAscending){
            [self.calenderShowView loadNextPageWithAnimation];
        }
        else{
            [self.calenderShowView loadPreviousPageWithAnimation];
        }
    }
}


#pragma mark - Views customization

- (UIView *)calendarBuildMenuItemView:(JTCalendarManager *)calendar
{
    UILabel *label = [UILabel new];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Avenir-Medium" size:15];
    label.textColor = [UIColor darkGrayColor];
    
    return label;
}


- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView date:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"MMMM yyyy";
        
        dateFormatter.locale = _calendarManager.dateHelper.calendar.locale;
        dateFormatter.timeZone = _calendarManager.dateHelper.calendar.timeZone;
    }
    
    menuItemView.text = [dateFormatter stringFromDate:date];
}



- (UIView<JTCalendarWeekDay> *)calendarBuildWeekDayView:(JTCalendarManager *)calendar
{
    JTCalendarWeekDayView *view = [JTCalendarWeekDayView new];
    view.backgroundColor = [UIColor colorWithRed:226/255.0 green:233/255.0 blue:231/255.0 alpha:1.0];
    
    for(UILabel *label in view.dayViews){
        label.textColor = [UIColor blackColor];
        label.font = [UIFont fontWithName:@"Avenir-Light" size:13];
    }
    
    return view;
}

- (NSDateFormatter *)dayDateFormatter
{
    static NSDateFormatter *dayDateFormatter;
    if(!dayDateFormatter){
        dayDateFormatter = [[NSDateFormatter alloc] init];
        dayDateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    return dayDateFormatter;
}

- (IBAction)nextMonth:(UIButton *)sender {
    
    [self.calenderShowView loadNextPageWithAnimation];
}

- (IBAction)preMonth:(UIButton *)sender {
    
    [self.calenderShowView loadPreviousPageWithAnimation];
}

#pragma mark - uitableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.tableFooterView = [[UIView alloc] init];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"calendarCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"calendarCell"];
    }
    
    if (indexPath.row == 0) {
         cell.textLabel.text = @"09:00 ~ 10:00 部门会议";
    }else{
        cell.textLabel.text = @"14:00 ~ 16:00 腾讯集团马总来访";
    }
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    STOASchduleDetailViewController *vc = [[STOASchduleDetailViewController alloc] init];
    
    static NSDateFormatter *withoutDateFormatter;
    
    if(!withoutDateFormatter){
        withoutDateFormatter = [NSDateFormatter new];
        withoutDateFormatter.dateFormat = @"YYYY-MM-dd HH:mm";
        
        withoutDateFormatter.locale = _calendarManager.dateHelper.calendar.locale;
        withoutDateFormatter.timeZone = _calendarManager.dateHelper.calendar.timeZone;
    }
    
    NSString *date = [withoutDateFormatter stringFromDate:self.dateSelected];
    
    vc.time = [NSString stringWithFormat:@"%@ 09:00",date];
    vc.ID = [NSString stringWithFormat:@"0000121%ld",indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
