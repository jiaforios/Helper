//
//  main.m
//  责任链模式
//
//  Created by Mia on 16/12/14.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "handler.h"
#import "projectManagerHandler.h"
#import "depManagerHandler.h"
#import "generalManagerHandler.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        handler *handler1 = [projectManagerHandler new];
        handler *handler2 = [depManagerHandler new];
        handler *handler3 = [generalManagerHandler new];
        
        //设置责任链中的下一个处理对象
        handler1.successor = handler2;
        handler2.successor = handler3;
        
        [handler1 handleRequest:100];
        
        NSLog(@"----------------------------------");
        [handler1 handleRequest:700];
        
        NSLog(@"----------------------------------");
        [handler1 handleRequest:10000];


    }
    return 0;
}
