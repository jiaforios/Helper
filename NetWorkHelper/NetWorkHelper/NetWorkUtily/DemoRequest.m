//
//  DemoRequest.m
//  test
//
//  Created by foscam on 17/2/7.
//  Copyright © 2017年 foscam. All rights reserved.
//

#import "DemoRequest.h"
#import "NetworkTool.h"

@implementation DemoRequest

+ (void)login:(NSString *)urls andParams:(id)params andTimeOut:(NSTimeInterval)timeOut
{
    [NetworkTool getWithUrlString:urls andParams:params success:nil fail:nil];
}
+ (void)logout:(NSString *)urls andParams:(id)params andTimeOut:(NSTimeInterval)timeOut
{
    [NetworkTool getWithUrlString:urls andParams:params success:nil fail:nil];

}
+ (void)registe:(NSString *)urls andParams:(id)params andTimeOut:(NSTimeInterval)timeOut
{
    [NetworkTool getWithUrlString:urls andParams:params success:nil fail:nil];

}
+ (void)getCode:(NSString *)urls andParams:(id)params andTimeOut:(NSTimeInterval)timeOut
{
    [NetworkTool getWithUrlString:urls andParams:params success:nil fail:nil];

}
+ (void)getReste:(NSString *)urls andParams:(id)params andTimeOut:(NSTimeInterval)timeOut
{
    [NetworkTool getWithUrlString:urls andParams:params success:nil fail:nil];

}
+ (void)postImage:(NSString *)urls andParams:(id)params andTimeOut:(NSTimeInterval)timeOut
{
    [NetworkTool getWithUrlString:urls andParams:params success:nil fail:nil];

}
+ (void)restPwd:(NSString *)urls andParams:(id)params andTimeOut:(NSTimeInterval)timeOut
{
    [NetworkTool getWithUrlString:urls andParams:params success:nil fail:nil];
}


@end
