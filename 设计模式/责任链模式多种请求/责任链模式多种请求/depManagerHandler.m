//
//  depManagerHandler.m
//  责任链模式
//
//  Created by Mia on 16/12/14.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "depManagerHandler.h"
#import "dinnerFeeRequestModel.h"
#import "travelFeeRequestModel.h"


@implementation depManagerHandler

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
    dinnerFeeRequestModel *feeModel = (dinnerFeeRequestModel*)model;
    if (feeModel.dinnerFee > 500 && feeModel.dinnerFee < 1000) {
        NSLog(@"部门经理同意了费用申请");
    }else{
        if (self.successor)
            NSLog(@"部门经理没有权限批准，转到部门经理处理");
        [self.successor handleRequest:model];
    }
}


-(void)handleTravelFeeRequest:(requestModel *)model{
    travelFeeRequestModel *travleModel = (travelFeeRequestModel*)model;
    if (travleModel.travelFee > 800 && travleModel.travelFee < 2000) {
        NSLog(@"部门经理同意了费用申请");
    }else{
        if (self.successor)
            NSLog(@"部门经理没有权限批准，转到部门经理处理");
        [self.successor handleRequest:model];
    }
}


@end
