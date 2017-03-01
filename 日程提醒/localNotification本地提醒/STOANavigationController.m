//
//  STOANavigationController.m
//  Saftop_moblieOA
//
//  Created by AG_TigerNong on 16/11/18.
//  Copyright © 2016年 Saftop. All rights reserved.
//

#import "STOANavigationController.h"
#define naviBarColor [UIColor colorWithRed:12 / 255.0 green:23 / 255.0 blue:41 / 255.0 alpha:1.0]

@interface STOANavigationController ()

@end

@implementation STOANavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

}

+ (void)initialize{
    UINavigationBar *appearance = [UINavigationBar appearance];
    appearance.barTintColor = naviBarColor;
    appearance.barStyle = UIBarStyleBlack;
    
    //设置两边文字的颜色
    [appearance setTintColor:[UIColor whiteColor]];
}



@end
