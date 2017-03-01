//
//  NetworkTool.m
//  test
//
//  Created by foscam on 17/2/6.
//  Copyright © 2017年 foscam. All rights reserved.
//

#import "NetworkTool.h"
#import "NetworkRequest.h"
#import <sys/socket.h>
#import <SystemConfiguration/SCNetworkReachability.h>

#define defaultTimeOut 60.f

static NSMutableArray *mz_urlTaskArray;

@implementation NetworkTool



+ (void)getWithUrlString:(NSString *)urlStr
               andParams:(id)params
                 success:(successBlock)sucBlock
                    fail:(failureBlock)failBlock
{
    
    [NetworkTool getWithUrlString:urlStr
                        andParams:params
                          success:sucBlock
                             fail:failBlock
                      withTimeOut:defaultTimeOut];
}

+ (void)postWithUrlString:(NSString *)urlStr
                andParams:(id)params
                  success:(successBlock)sucBlock
                     fail:(failureBlock)failBlock
{
    
    [NetworkTool postWithUrlString:urlStr
                         andParams:params
                           success:sucBlock
                              fail:failBlock
                       withTimeOut:defaultTimeOut];
}


+ (void)getWithUrlString:(NSString *)urlStr
               andParams:(id)params
                 success:(successBlock)sucBlock
                    fail:(failureBlock)failBlock
             withTimeOut:(NSTimeInterval)timeout
{
    
    NSLog(@"count0 = %d",[self allTasks].count);
    [self taskCheck];
    NSLog(@"count1 = %d",[self allTasks].count);

    if (![self isConnected]) {
        NSLog(@"没有网络连接");
        return;
    }

   NSURLSessionTask *session =  [[NetworkRequest shareNetworkDefault] getType:urlStr
                                                                    andParams:params
                                                                   andTimeOut:timeout
                                                                      success:sucBlock
                                                                         fail:failBlock];
    if (session) {

        [[self allTasks] addObject:session];
    }
    
    NSLog(@"count2 = %d",[self allTasks].count);

}



+ (void)postWithUrlString:(NSString *)urlStr
                andParams:(id)params
                  success:(successBlock)sucBlock
                     fail:(failureBlock)failBlock
              withTimeOut:(NSTimeInterval)timeout
{
    [self taskCheck];

    if (![self isConnected]) {
        NSLog(@"没有网络连接");
        return;
    }
    
      NSURLSessionTask *session = [[NetworkRequest shareNetworkDefault]postType:urlStr
                                        andParams:params
                                       andTimeOut:timeout
                                          success:sucBlock
                                             fail:failBlock];
    
    if (session) {
        
        [[self allTasks] addObject:session];
    }
    
}


+ (BOOL)isConnected {
    
    struct sockaddr zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sa_len = sizeof(zeroAddress);
    zeroAddress.sa_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability =
    SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags =
    SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

+ (NSMutableArray *)allTasks{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (mz_urlTaskArray == nil) {
            mz_urlTaskArray = [[NSMutableArray alloc] init];
        }
        
    });
    return mz_urlTaskArray;
}


+(void)cancelRequestWithUrl:(NSString *)urlStr
{
    if (urlStr == nil) {
        return;
    }
    @synchronized (self) {
        
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSURLSessionTask class]] && [obj.currentRequest.URL.absoluteString hasSuffix:urlStr]) {
                [obj cancel];
                [[self allTasks] removeObject:obj];
                return ;
            }
            
        }];
        
    }
}

+ (void)cancelAllRequest
{
    
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[NSURLSessionTask class]]) {
                [task cancel];
            }
        }];
        
        [[self allTasks] removeAllObjects];
    };
    
}


+ (void)taskCheck
{
    @synchronized (self) {
        
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask * task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[NSURLSessionTask class]]) {
                NSLog(@"state = %d",task.state);
                if (task.state == NSURLSessionTaskStateCompleted) {
                    [[self allTasks] removeObject:task];
                }
            }

        }];
    }
}


@end
