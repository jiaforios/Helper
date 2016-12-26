//
//  dinnerFeeRequestModel.m
//  责任链模式多种请求
//
//  Created by Mia on 16/12/14.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "dinnerFeeRequestModel.h"

@implementation dinnerFeeRequestModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.businessType = @"dinnerFee";
    }
    return self;
}
@end
