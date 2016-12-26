//
//  handler.m
//  责任链模式多种请求
//
//  Created by Mia on 16/12/14.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "handler.h"

@implementation handler

-(void)handleRequest:(requestModel *)model{
    if (self.successor){
        [self.successor handleRequest:model];
    }
}
@end
