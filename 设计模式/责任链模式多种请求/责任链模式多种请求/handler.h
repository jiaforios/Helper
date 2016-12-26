//
//  handler.h
//  责任链模式多种请求
//
//  Created by Mia on 16/12/14.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "requestModel.h"

@interface handler : NSObject
@property(strong,nonatomic)handler *successor;
-(void)handleRequest:(requestModel *)model;

@end
