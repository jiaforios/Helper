//
//  ViewController.m
//  NetWorkHelper
//
//  Created by foscam on 17/2/7.
//  Copyright © 2017年 foscam. All rights reserved.
//

#import "ViewController.h"
#import "NetworkTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    for (int i = 0; i<200; i++) {
        [NetworkTool getWithUrlString:@"http://www.qinto.com/wap/index.php?ctl=article_cate&act=api_app_getarticle_cate&num=1&p=1" andParams:nil success:^(id data) {
            NSLog(@"DATA = %@",data);
            
        } fail:^(NSError *error) {
            
            
            
        }];

    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{

        [NetworkTool cancelAllRequest];
        
    });


    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
