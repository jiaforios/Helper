//
//  handler.h
//  责任链模式
//
//  Created by Mia on 16/12/14.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface handler : NSObject
@property(strong,nonatomic)handler *successor;

-(void)handleRequest:(NSInteger)fee;
@end
