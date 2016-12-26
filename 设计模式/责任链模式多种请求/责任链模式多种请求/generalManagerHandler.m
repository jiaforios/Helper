//
//  generalManagerHandler.m
//  责任链模式
//
//  Created by Mia on 16/12/14.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "generalManagerHandler.h"
#import "dinnerFeeRequestModel.h"
#import "travelFeeRequestModel.h"

@implementation generalManagerHandler
-(void)handleRequest:(requestModel *)model{
    if ([model.businessType isEqualToString:@"dinnerFee"]) {
        [self handleDinnerFeeRequest:model];
    
    }else if([model.businessType isEqualToString:@"travelFee"]){
        [self handleTravelFeeRequest:model];
    
    }else{
        NSLog(@"无法处理");
    }
}

-(void)handleDinnerFeeRequest:(requestModel *)model{
    NSLog(@"总经理同意了聚餐费用申请");
}


-(void)handleTravelFeeRequest:(requestModel *)model{
        NSLog(@"总经理同意了差旅费用申请");
   
}

@end
