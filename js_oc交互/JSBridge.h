//
//  JSBridge.h
//  blockChain
//
//  Created by foscom on 16/9/9.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface JSBridge : NSObject
@property (nonatomic,strong) JSContext *jsContext;

- (void)bridgeForJs;
- (void)regiestJSFunctionInContext:(JSContext *) jsContext;

@end
