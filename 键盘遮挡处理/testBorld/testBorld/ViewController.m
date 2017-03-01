//
//  ViewController.m
//  testBorld
//
//  Created by qlh on 17/2/16.
//  Copyright © 2017年 Qlh. All rights reserved.
//

#import "ViewController.h"
#import "ZYKeyboardUtil.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *inside;
@property (strong, nonatomic) IBOutlet UITextField *text1;

@property (strong, nonatomic) IBOutlet UITextField *text2;
@property (strong, nonatomic) IBOutlet UITextField *text3;

@property (strong, nonatomic) IBOutlet UIView *inside0;
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;
@end





@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.s
    
//    self.keyboardUtil = [[ZYKeyboardUtil alloc] initWithKeyboardTopMargin:10];// 10:输入框与键盘下面的距离
//    __weak ViewController *weakSelf = self;
//
//
//    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
//        
//        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.text1,  weakSelf.text2,weakSelf.text3,nil];
//    }];
//
    
    KeyboardUtilHelper(_keyboardUtil,10,weakSelf.text1,  weakSelf.text2,weakSelf.text3,nil);
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
