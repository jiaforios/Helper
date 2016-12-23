//
//  ViewController.m
//  blockChain
//
//  Created by foscom on 16/7/27.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)NSString *names;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.study().run();
//    
//    self.play(@"name",@"xiaoming");
    // 局部变量
    int i = 0;
    void(^testblock)(NSString *name) = ^(NSString *name){
//        static int c= 0; // 静态变量
        NSLog(@"i = %d",i);
//        self.names = name;
//        a=3;
//        int aa = 0;
        
    };
    
    // 用到了局部变量或者属性而且没有强指针指向都是栈block
    
    // 没强指针指向，也没用外界变量都是全局block
    
//    testblock(@"xiaohua");
    NSLog(@"%@",^(NSString *name){
        NSLog(@"%@",self.names);
        a=3;
    });
    
    
    // 有强指针 而且没使用全局变量,用到局部变量或者属性 就是堆block
    
    // 用到了全局变量 或者静态变量 或者没用外界变量  就是全局block
    NSLog(@"%@",testblock);
    
    NSLog(@"%@",self.names);
}

// 全局变量
int a= 0;


- (ViewController* (^)())study
{
    return ^(){
        NSLog(@"study---");
        return self;
    };
    
}
- (ViewController* (^)())run
{
    return ^{
        NSLog(@"run----");
        return self;
    };
    
}

- (ViewController *(^)(NSString*,NSString*))play
{
    return ^(NSString *str,NSString *str2){
    
        NSLog(@"str = %@ name = %@",str,str2);
        return self;
    };
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
