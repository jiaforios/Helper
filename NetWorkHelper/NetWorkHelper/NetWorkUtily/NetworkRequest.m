//
//  NetworkRequest.m
//  test
//
//  Created by foscam on 17/2/6.
//  Copyright © 2017年 foscam. All rights reserved.
//

#import "NetworkRequest.h"
#import "AFNetworking.h"

static NetworkRequest *networkRequestManger;

@interface NetworkRequest ()
{
    AFHTTPSessionManager *sessionManger;
}
@end

@implementation NetworkRequest

+ (instancetype)shareNetworkDefault
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        networkRequestManger = [[NetworkRequest alloc] init];
    });
    
    return networkRequestManger;
    
}

- (instancetype)init
{
    if (self = [super init]) {
        
        sessionManger = [AFHTTPSessionManager manager];
        sessionManger.requestSerializer = [AFHTTPRequestSerializer serializer];
        //设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)

        sessionManger.responseSerializer = [AFJSONResponseSerializer serializer];
        
        sessionManger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    }
    
    return self;
}


- (NSURLSessionTask *)getType:(NSString *)urlStr
      andParams:(id)params
     andTimeOut:(NSTimeInterval)timeOut
        success:(successBlock)sucBlock
           fail:(failureBlock)failBlock;
{
    sessionManger.requestSerializer.timeoutInterval = timeOut;
    
   NSURLSessionTask *session =  [sessionManger GET:urlStr
            parameters:params
              progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        sucBlock?sucBlock(responseObject):nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failBlock?failBlock(error):nil;

    }];
    return session;
    
    

}

- (NSURLSessionTask *)postType:(NSString *)urlStr
       andParams:(id)params
      andTimeOut:(NSTimeInterval)timeOut
         success:(successBlock)sucBlock
            fail:(failureBlock)failBlock
{
    
    sessionManger.requestSerializer.timeoutInterval = timeOut;
    
     NSURLSessionTask *session =   [sessionManger POST:urlStr
             parameters:params
               progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        sucBlock?sucBlock(responseObject):nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        failBlock?failBlock(error):nil;
        
    }];
    

    return session;
}





@end
