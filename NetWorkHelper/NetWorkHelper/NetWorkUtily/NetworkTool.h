//
//  NetworkTool.h
//  test
//
//  Created by foscam on 17/2/6.
//  Copyright © 2017年 foscam. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 网络请求中间层 判断网络  缓存处理 取消请求操作

 */
typedef void(^successBlock)(id);
typedef void(^failureBlock)(NSError *);


@interface NetworkTool : NSObject



/**
 GET请求

 @param urlStr urlStr
 @param params params
 @param sucBlock 成功返回
 @param failBlock 失败返回
 
 */

+ (void)getWithUrlString:(NSString *)urlStr
               andParams:(id)params
                 success:(successBlock)sucBlock
                    fail:(failureBlock)failBlock;

/**
 POST请求
 
 @param urlStr urlStr
 @param params params
 @param sucBlock 成功返回
 @param failBlock 失败返回
 
 */

+ (void)postWithUrlString:(NSString *)urlStr
                andParams:(id)params
                  success:(successBlock)sucBlock
                     fail:(failureBlock)failBlock;



/**
 GET请求 超时设置

 @param urlStr urlStr
 @param params params
 @param sucBlock 成功返回
 @param failBlock 失败返回
 @param timeout 超时时间
 */

+ (void)getWithUrlString:(NSString *)urlStr
               andParams:(id)params
                 success:(successBlock)sucBlock
                    fail:(failureBlock)failBlock
             withTimeOut:(NSTimeInterval)timeout;

/**
 POST请求 超时设置
 
 @param urlStr urlStr
 @param params params
 @param sucBlock 成功返回
 @param failBlock 失败返回
 @param timeout 超时时间
 */

+ (void)postWithUrlString:(NSString *)urlStr
                andParams:(id)params
                  success:(successBlock)sucBlock
                     fail:(failureBlock)failBlock
              withTimeOut:(NSTimeInterval)timeout;




/**
 取消指定网络请求

 @param urlStr urlStr
 
 */


+ (void)cancelRequestWithUrl:(NSString *)urlStr;

/**
 取消全部网络请求
 
 */

+ (void)cancelAllRequest;


@end
