//
//  ViewController.m
//  GuPiaoTabView
//
//  Created by qlh on 17/2/15.
//  Copyright © 2017年 qlh. All rights reserved.
//

#import "ViewController.h"
#import "GroupTabView.h"
@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   GroupTabView *group = [GroupTabView groupFrame:CGRectMake(0, 0, 375, 667) configGroupView:^(GroupTabView *gt) {
       
       gt.typeWidth = 100.f;
    
       gt.column = 10;
       gt.rowHeight = 44.f;
       
   }];
    
    [self.view addSubview:group];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    

}


@end
