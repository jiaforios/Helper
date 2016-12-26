//
//  projectManagerHandler.m
//  责任链模式
//
//  Created by Mia on 16/12/14.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "projectManagerHandler.h"

@implementation projectManagerHandler

-(void)handleRequest:(NSInteger)fee{
    if (fee < 500) {
        NSLog(@"项目经理同意了费用申请");
    }else{
        if (self.successor)
            NSLog(@"项目经理没有权限批准，转到部门经理处理");
            [self.successor handleRequest:fee];
    }
}
@end
