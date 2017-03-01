//
//  STLocalNotiModel.h
//  VisitorMain
//
//  Created by TigerNong on 17/2/19.
//  Copyright © 2017年 Saftop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STLocalNotiModel : NSObject
//时间
@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) NSString *body;
//通知标示
@property (nonatomic, copy) NSString *ID;

@end
