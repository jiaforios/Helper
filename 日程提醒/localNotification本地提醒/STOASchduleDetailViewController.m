//
//  STOASchduleDetailViewController.m
//  localNotification本地提醒
//
//  Created by TigerNong on 17/2/23.
//  Copyright © 2017年 TigerNong. All rights reserved.
//

#import "STOASchduleDetailViewController.h"
#import "STSetNotiViewController.h"

@interface STOASchduleDetailViewController ()

@end

@implementation STOASchduleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"内容详情";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置提醒" style:0 target:self action:@selector(setNoti)];
    
}

- (void)setNoti{

    STSetNotiViewController *vc = [[STSetNotiViewController alloc] init];
    vc.time = self.time;
    vc.ID = self.ID;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
