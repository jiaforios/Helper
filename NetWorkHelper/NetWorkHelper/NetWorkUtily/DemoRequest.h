//
//  DemoRequest.h
//  test
//
//  Created by foscam on 17/2/7.
//  Copyright © 2017年 foscam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoRequest : NSObject



/**
  与上层业务对接 demo

 */

+ (void)login:(NSString *)urls andParams:(id)params andTimeOut:(NSTimeInterval)timeOut;
+ (void)logout:(NSString *)urls andParams:(id)params andTimeOut:(NSTimeInterval)timeOut;
+ (void)registe:(NSString *)urls andParams:(id)params andTimeOut:(NSTimeInterval)timeOut;
+ (void)getCode:(NSString *)urls andParams:(id)params andTimeOut:(NSTimeInterval)timeOut;
+ (void)getReste:(NSString *)urls andParams:(id)params andTimeOut:(NSTimeInterval)timeOut;
+ (void)postImage:(NSString *)urls andParams:(id)params andTimeOut:(NSTimeInterval)timeOut;
+ (void)restPwd:(NSString *)urls andParams:(id)params andTimeOut:(NSTimeInterval)timeOut;


@end
