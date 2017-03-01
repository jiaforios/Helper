//
//  STSetNotiViewController.m
//  VisitorMain
//
//  Created by TigerNong on 17/2/19.
//  Copyright © 2017年 Saftop. All rights reserved.
//

#import "STSetNotiViewController.h"
#import "STLocalNotiModel.h"
#import <UserNotifications/UserNotifications.h>
#import "STLocalNotiTool.h"

#define screenWidth ([UIScreen mainScreen].bounds.size.width)
#define screenHeight ([UIScreen mainScreen].bounds.size.height)

#define backColor [UIColor colorWithRed:238/255.0 green:238/255.0 blue:244/255.0 alpha:1.0]

#define naviBarColor [UIColor colorWithRed:12 / 255.0 green:23 / 255.0 blue:41 / 255.0 alpha:1.0]

#define selectBackColor [UIColor colorWithRed:10 / 255.0 green:171 / 255.0 blue:255 / 255.0 alpha:1.0]

#define monthAndYearColor [UIColor colorWithRed:226/255.0 green:233/255.0 blue:231/255.0 alpha:1.0]

@interface STSetNotiViewController ()
@property (nonatomic, strong) NSArray *selectRemindItems;

@property (nonatomic, strong) NSMutableArray *selects;

@property (nonatomic, strong) NSMutableArray *selectTimes;
@end

@implementation STSetNotiViewController

- (NSMutableArray *)selectTimes{
    if (!_selectTimes) {
        _selectTimes = [NSMutableArray array];
    }
    return _selectTimes;
}

- (NSMutableArray *)selects{
    if (!_selects) {
        
        _selects = [NSMutableArray array];
        
    }
    return _selects;
}

- (NSArray *)selectRemindItems{
    if (!_selectRemindItems) {
        _selectRemindItems = @[@"不提醒",@"事件发生时",@"前5分钟",@"前15分钟",@"前30分钟",@"前1小时",@"前2小时",@"前4小时"];
    }
    return _selectRemindItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = backColor;
    [self setUpNavi];
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (STLocalNotiModel *noti in [[STLocalNotiTool shareLocalNotiTool] readNoti]) {
        
        [arr addObject:noti.ID];
    }
    
    for (NSString *ID in arr) {
        if ([ID containsString:self.ID]) {

            NSString *str = [ID substringFromIndex:self.ID.length];
   
            [self.selects addObject:str];
        }
    }
}


- (void)setUpNavi{
    
    self.title = @"提醒";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:0 target:self action:@selector(save)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(back)];
    
}

- (void)back{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"还没有进行保存，确定退出？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"退出，不保存" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"退出并保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self save];
        
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
}

- (void)save{
    
    if (self.selects.count == 1 && [self.selects[0] isEqualToString:@"不提醒"]) {
        
        NSMutableArray *arr = [NSMutableArray array];
        
        for (STLocalNotiModel *noti in [[STLocalNotiTool shareLocalNotiTool] readNoti]) {
            [arr addObject:noti.ID];
        }
        
        NSMutableArray *seleArr = [NSMutableArray array];
        
        for (NSString *ID in arr) {
            if ([ID containsString:self.ID]) {
                
                NSInteger index = [arr indexOfObject:ID];
                
                STLocalNotiModel *noti = [[STLocalNotiTool shareLocalNotiTool] readNoti][index];
                [seleArr addObject:noti];
            }
        }
        
        for (STLocalNotiModel *noti in seleArr) {
             [[STLocalNotiTool shareLocalNotiTool] removeNoti:noti];
        }
        
        //取消本地通知
        [[STLocalNotiTool shareLocalNotiTool] removeLocalNotificationsWithIdentifiers:seleArr];
    }else{
        for (NSString *str in self.selects) {
            
            if ([str isEqualToString:@"前4小时"]) {
                NSString *dateStr = [self timeWithInterval:4 * 60 * 60];
                STLocalNotiModel *localModel = [self localModelWithTime:dateStr withStr:str withInterval:@"距离预约开始时间还有4小时"];
                
                [[STLocalNotiTool shareLocalNotiTool] addLocalNoti:localModel];
            }
            
            if ([str isEqualToString:@"前2小时"]) {
                NSString *dateStr = [self timeWithInterval:2 * 60 * 60];
                STLocalNotiModel *localModel = [self localModelWithTime:dateStr withStr:str withInterval:@"距离预约开始时间还有2小时"] ;
                [[STLocalNotiTool shareLocalNotiTool] addLocalNoti:localModel];
            }
            
            if ([str isEqualToString:@"前1小时"]) {
                NSString *dateStr = [self timeWithInterval:60 * 60];
                STLocalNotiModel *localModel = [self localModelWithTime:dateStr withStr:str withInterval:@"距离预约开始时间还有1小时"];
                [[STLocalNotiTool shareLocalNotiTool] addLocalNoti:localModel];
            }
            
            if ([str isEqualToString:@"前30分钟"]) {
                NSString *dateStr = [self timeWithInterval:30 * 60];
                STLocalNotiModel *localModel = [self localModelWithTime:dateStr withStr:str withInterval:@"距离预约开始时间还有30分钟"];
                [[STLocalNotiTool shareLocalNotiTool] addLocalNoti:localModel];
            }
            
            if ([str isEqualToString:@"前15分钟"]) {
                NSString *dateStr = [self timeWithInterval:15 * 60];
                STLocalNotiModel *localModel = [self localModelWithTime:dateStr withStr:str withInterval:@"距离预约开始时间还有15分钟"];
                [[STLocalNotiTool shareLocalNotiTool] addLocalNoti:localModel];
            }
            
            if ([str isEqualToString:@"前5分钟"]) {
                NSString *dateStr = [self timeWithInterval:5 * 60];
                STLocalNotiModel *localModel = [self localModelWithTime:dateStr withStr:str withInterval:@"距离预约开始时间还有5分钟"];
                [[STLocalNotiTool shareLocalNotiTool] addLocalNoti:localModel];
            }
            
            if ([str isEqualToString:@"事件发生时"]) {
                NSString *dateStr = [self timeWithInterval:0];
                STLocalNotiModel *localModel = [self localModelWithTime:dateStr withStr:str withInterval:@"预约已开始"];
                [[STLocalNotiTool shareLocalNotiTool] addLocalNoti:localModel];
            }
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (STLocalNotiModel *)localModelWithTime:(NSString *)time withStr:(NSString *)str withInterval:(NSString *)intervalStr{
     STLocalNotiModel *localModel = [[STLocalNotiModel alloc] init];

    localModel.date = time;
    localModel.ID = [NSString stringWithFormat:@"%@%@",self.ID,str];
 
    localModel.title = @"去访提醒";
    localModel.subTitle = intervalStr;
    localModel.body = [NSString stringWithFormat:@"%@ 前去拜访 ",self.time];

    return localModel;

}

- (NSString *)timeWithInterval:(NSInteger)interval{
    
    NSDate *date = [self.timeDateFormatter dateFromString:self.time];
    NSDate *newDate = [NSDate dateWithTimeInterval:-interval sinceDate:date];
    
    NSString *dateStr = [self.timeDateFormatter stringFromDate:newDate];
    
    return dateStr;
    
}

- (NSDateFormatter *)timeDateFormatter
{
    static NSDateFormatter *timeDateFormatter;
    if(!timeDateFormatter){
        timeDateFormatter = [[NSDateFormatter alloc] init];
        timeDateFormatter.dateFormat = @"YYYY-MM-dd HH:mm";
    }
    return timeDateFormatter;
}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"remindCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"remindCell"];
    }
    
    cell.textLabel.text = self.selectRemindItems[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    if (self.selects.count == 0) {
        [self.selects addObject:@"不提醒"];
    }
    
    if ([self.selects containsObject:cell.textLabel.text]) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.textColor = naviBarColor;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    tableView.tableFooterView = [[UIView alloc] init];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.textLabel.text isEqualToString:@"不提醒"]) {
        [self.selects removeAllObjects];
        
        [self.selects addObject:@"不提醒"];
    }else{
        
        [self.selects removeObject:@"不提醒"];
        
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.textColor = [UIColor darkGrayColor];
            
            [self.selects removeObject:cell.textLabel.text];
            
            NSMutableArray *arr = [NSMutableArray array];
            
            for (STLocalNotiModel *noti in [[STLocalNotiTool shareLocalNotiTool] readNoti]) {
                [arr addObject:noti.ID];
            }
            
            NSString *ID = [NSString stringWithFormat:@"%@%@",self.ID,cell.textLabel.text];
            
            if ([arr containsObject:ID]) {
                
                NSInteger index = [arr indexOfObject:ID];
                
                [[STLocalNotiTool shareLocalNotiTool] removeNoti:[[STLocalNotiTool shareLocalNotiTool] readNoti][index]];
            }

            
        }else if (cell.accessoryType == UITableViewCellAccessoryNone){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.textLabel.textColor = naviBarColor;
            
            [self.selects addObject:cell.textLabel.text];
        }
    }
    
    [self.tableView reloadData];
}


@end
