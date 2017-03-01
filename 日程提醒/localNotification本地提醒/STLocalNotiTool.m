//
//  STLocalNotiTool.m
//  VisitorMain
//
//  Created by TigerNong on 17/2/19.
//  Copyright © 2017年 Saftop. All rights reserved.
//

#import "STLocalNotiTool.h"
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import "NSString+Extension.h"

#define name ([NSString stringWithFormat:@"NAME_localNoti"])

#define STLocalNotiDataFile ([[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name])

@interface STLocalNotiTool ()
@property (nonatomic, strong) NSMutableArray *notis;
@end

@implementation STLocalNotiTool

static STLocalNotiTool *_localNotiTool = nil;
+ (id)shareLocalNotiTool{
    
    if (!_localNotiTool) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _localNotiTool = [[STLocalNotiTool alloc] init];
        });
    }
    return _localNotiTool;
}

- (NSMutableArray *)notis{
    if (!_notis) {
        _notis = [NSKeyedUnarchiver unarchiveObjectWithFile:STLocalNotiDataFile];
        
        if (!_notis) {
            _notis = [NSMutableArray array];
        }
    }
    return _notis;
}

- (void)addLocalNoti:(STLocalNotiModel *)noti{
    
    NSMutableArray *arr = [NSMutableArray array];
    
    if (self.notis.count == 0) {
        [self.notis insertObject:noti atIndex:0];
    }else{
        for (STLocalNotiModel *n in self.notis) {
            
            [arr addObject:n.ID];
        }
        
        if (![arr containsObject:noti.ID]) {
            [self.notis addObject:noti];
        }
    }
    
    // 存进沙盒
    [NSKeyedArchiver archiveRootObject:self.notis toFile:STLocalNotiDataFile];
}

- (NSArray *)readNoti{
    return [self.notis copy];
}

- (void)removeNoti:(STLocalNotiModel *)noti{
    [self.notis removeObject:noti];
    
    // 存进沙盒
    [NSKeyedArchiver archiveRootObject:self.notis toFile:STLocalNotiDataFile];

}

- (void)removeAllNoti{
    [self.notis removeAllObjects];
    
    // 存进沙盒
    [NSKeyedArchiver archiveRootObject:self.notis toFile:STLocalNotiDataFile];
}

- (void)deleteFile{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    [manager removeItemAtPath:STLocalNotiDataFile error:nil];
}


- (void)scheduleLocalNotification{
    
    NSArray *arr = [[STLocalNotiTool shareLocalNotiTool] readNoti];
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
        //先删除所有的本地通知
        [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
        
        for (NSInteger i = 0; i < arr.count; i++) {
            //第二步：新建通知内容对象
            STLocalNotiModel *model = arr[i];
            
            UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
            content.title = model.title;
            content.subtitle = model.subTitle;
            content.body = model.body;
            content.badge = @1;
            UNNotificationSound *sound = [UNNotificationSound soundNamed:@"caodi.m4a"];
            content.sound = sound;
            
            
            //设置时间
            NSDateComponents *components = [[NSDateComponents alloc] init];
            NSDate *date = [self.timeDateFormatter dateFromString:model.date];
            NSCalendar *calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            
            NSInteger unitFlags = NSCalendarUnitEra |
            NSCalendarUnitYear |
            NSCalendarUnitMonth |
            NSCalendarUnitDay |
            NSCalendarUnitHour |
            NSCalendarUnitMinute;
            
            components.timeZone = [NSTimeZone systemTimeZone];
            
            components = [calendar components:unitFlags fromDate:date];
            
            //第三步：通知触发机制
            UNCalendarNotificationTrigger *trigger1 = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:NO];
            
            //第四步：创建UNNotificationRequest通知请求对象
            NSString *requertIdentifier = model.ID;
            
            UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requertIdentifier content:content trigger:trigger1];
            
            //第五步：将通知加到通知中心
            [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
                NSLog(@"Error:%@",error);
                
            }];
        }
    }else{
        
        //删除点所有的本地通知
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        //遍历加载本体通知
        for (NSInteger i = 0; i < arr.count; i++) {
            
            STLocalNotiModel *model = arr[i];
            
            /**
             创建本地通知对象
             */
            UILocalNotification *localnotification = [[UILocalNotification alloc]init];
            /**
             *  设置推送的相关属性
             */
            
            NSDate *date = [self.timeDateFormatter dateFromString:model.date];
            localnotification.timeZone = [NSTimeZone systemTimeZone];
            localnotification.fireDate = date;//通知触发时间
            localnotification.alertBody = [NSString stringWithFormat:@"%@ %@",model.body,model.subTitle];//通知具体内容
            localnotification.soundName = @"caodi.m4a";//通知时的音效
            localnotification.applicationIconBadgeNumber = 1;
            localnotification.alertAction = @"查看更多精彩内容";//默认为 滑动来 +查看;锁屏时显示底部提示
            
            NSDictionary *info = [NSDictionary dictionaryWithObject:model.ID forKey:model.ID];
            localnotification.userInfo = info;
            
            /**
             *  调度本地通知,通知会在特定时间发出
             */
            [[UIApplication sharedApplication] scheduleLocalNotification:localnotification];
        }
    }
}


//删除时间比当前时间小的通知
- (void)removeEarlierThenCurrentTimeLocalNitofication{
    NSArray *arr = [[STLocalNotiTool shareLocalNotiTool] readNoti];
    
    NSString *currentTimeStr = [NSString currentWithoutSecondTime];
    
    NSMutableArray *removeArr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < arr.count; i++) {
        //第二步：新建通知内容对象
        STLocalNotiModel *model = arr[i];
        
        BOOL big = [NSString compareWithoutSecondStartTime:currentTimeStr withEndTime:model.date];
        if (big == NO) {
            [[STLocalNotiTool shareLocalNotiTool] removeNoti:model];
            [removeArr addObject:model.ID];
        }
    }
    
    [self removeLocalNotificationsWithIdentifiers:removeArr];
}


- (void)removeAllLocalNotifications{
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
        //先删除所有的本地通知
        [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    }else{
         [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

- (void)removeLocalNotificationsWithIdentifiers:(NSArray *)identifiers{
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
        [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:identifiers];
    }else{
        NSArray *notis = [[UIApplication sharedApplication] scheduledLocalNotifications];
        if (notis || notis.count <= 0) {
            return;
        }
        
        for (UILocalNotification *no in notis) {
            
            NSDictionary *dict = no.userInfo;
            
            for (STLocalNotiModel *noti in identifiers) {
                NSString *ID = noti.ID;
                
                if ([[dict objectForKey:ID] isEqualToString:ID]) {
                    [[UIApplication sharedApplication] cancelLocalNotification:no];
                }
            }
        }
    }

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

@end
