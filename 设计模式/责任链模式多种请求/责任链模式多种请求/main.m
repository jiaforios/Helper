//
//  main.m
//  责任链模式多种请求
//
//  Created by Mia on 16/12/14.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "requestModel.h"
#import "dinnerFeeRequestModel.h"
#import "travelFeeRequestModel.h"
#import "handler.h"
#import "projectManagerHandler.h"
#import "depManagerHandler.h"
#import "generalManagerHandler.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {

        handler *handler1 = [projectManagerHandler new];
        handler *handler2 = [depManagerHandler new];
        handler *handler3 = [generalManagerHandler new];
        handler1.successor = handler2;
        handler2.successor = handler3;

        dinnerFeeRequestModel *dinnerModel = [dinnerFeeRequestModel new];
        dinnerModel.dinnerFee = 1000;
        [handler1 handleRequest:dinnerModel];
        
        
        NSLog(@"--------------------------------------------");
        travelFeeRequestModel *travelModel = [travelFeeRequestModel new];
        travelModel.travelFee = 3000;
        [handler1 handleRequest:travelModel];
        
        
        
        
    }
    return 0;
}
