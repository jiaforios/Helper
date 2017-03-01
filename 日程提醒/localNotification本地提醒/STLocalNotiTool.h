//
//  STLocalNotiTool.h
//  VisitorMain
//
//  Created by TigerNong on 17/2/19.
//  Copyright © 2017年 Saftop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STLocalNotiModel.h"

@interface STLocalNotiTool : NSObject
+ (id)shareLocalNotiTool;
//存储通知模型
- (void)addLocalNoti:(STLocalNotiModel *)noti;
//读取通知模型
- (NSArray *)readNoti;
//移除某个通知模型
- (void)removeNoti:(STLocalNotiModel *)noti;

//移除所有通知模型
- (void)removeAllNoti;

//移除存储模型所在的路径
- (void)deleteFile;

//开启本地推送
- (void)scheduleLocalNotification;

// 移除比当前时间更早的提醒
- (void)removeEarlierThenCurrentTimeLocalNitofication;

//移除所有的本地推送
- (void)removeAllLocalNotifications;

//移除指定ID的本地通知
- (void)removeLocalNotificationsWithIdentifiers:(NSArray *)identifiers;



@end
