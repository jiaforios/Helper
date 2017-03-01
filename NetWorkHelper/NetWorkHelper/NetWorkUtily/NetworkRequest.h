//
//  NetworkRequest.h
//  test
//
//  Created by foscam on 17/2/6.
//  Copyright © 2017年 foscam. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 网络下层 对接第三方库

 */

typedef void(^successBlock)(id responseObject);
typedef void(^failureBlock)(NSError *error);

@interface NetworkRequest : NSObject


+ (instancetype)shareNetworkDefault;


/**
 GET 请求

 @param urlStr urlStr
 @param params params
 @param timeOut 超时时间
 @param sucBlock 成功返回
 @param failBlock 失败返回
 */

- (NSURLSessionTask *)getType:(NSString *)urlStr
      andParams:(id)params
     andTimeOut:(NSTimeInterval)timeOut
        success:(successBlock)sucBlock
           fail:(failureBlock)failBlock;



/**
 POST 请求
 
 @param urlStr urlStr
 @param params params
 @param timeOut 超时时间
 @param sucBlock 成功返回
 @param failBlock 失败返回
 */

- (NSURLSessionTask *)postType:(NSString *)urlStr
       andParams:(id)params
      andTimeOut:(NSTimeInterval)timeOut
         success:(successBlock)sucBlock
            fail:(failureBlock)failBlock;


@end
