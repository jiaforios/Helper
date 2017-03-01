//
//  AppDelegate.h
//  localNotification本地提醒
//
//  Created by TigerNong on 17/2/23.
//  Copyright © 2017年 TigerNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

