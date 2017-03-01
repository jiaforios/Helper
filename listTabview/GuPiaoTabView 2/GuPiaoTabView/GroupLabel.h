//
//  GroupLabel.h
//  GuPiaoTabView
//
//  Created by qlh on 17/2/15.
//  Copyright © 2017年 qlh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LabelType) {
    NAME_TYPY,   // 名称
    
    LATEST_TYPE,  //
    BUY_TYPY,
    SELL_TYPE,
    UPDOWN_TYPE,
    OPEN_TYPY,
    GET_TYPE,
    HIGH_TYPY,
    LOW_TYPE,
    INCREASE_TYPY,
    CODE_TYPE,
};

@interface GroupLabel : UILabel

@property(nonatomic,assign)LabelType columntype;


@end
