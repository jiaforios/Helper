//
//  ViewController.m
//  享元模式-百花池
//
//  Created by Mia on 16/11/14.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "ViewController.h"
#import "FlowerFactory.h"
#import "FlyweightView.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
 //使用享元模式
    FlowerFactory *factory = [[FlowerFactory alloc] init];
    NSMutableArray *flowerList = [[NSMutableArray alloc]
                                   initWithCapacity:500];
    for (int i = 0; i < 100000; ++i)
    {
        @autoreleasepool {
            FlowerType flowerType = arc4random() % kTotalNumberOfFlowerTypes;
            //重复利用对象
            UIImageView *flowerView = [factory flowerViewWithType:flowerType];

            CGRect screenBounds = [[UIScreen mainScreen] bounds];
            CGFloat x = (arc4random() % (NSInteger)screenBounds.size.width);
            CGFloat y = (arc4random() % (NSInteger)screenBounds.size.height);
            NSInteger minSize = 10;
            NSInteger maxSize = 50;
            CGFloat size = (arc4random() % (maxSize - minSize + 1)) + minSize;
            CGRect area = CGRectMake(x, y, size, size);
            //新建对象
            NSValue *key = [NSValue valueWithCGRect:area];
            //新建对象
            NSDictionary *dic =   [NSDictionary dictionaryWithObject:flowerView forKey:key];
            [flowerList addObject:dic];
            
        }
        
    }
    
    FlyweightView *view = [[FlyweightView alloc]initWithFrame:self.view.bounds];
    view.flowerList = flowerList;
    self.view = view;


//使用普通模式
//    for (int i = 0; i < 100000; i++) {
//        @autoreleasepool {
//            CGRect screenBounds = [[UIScreen mainScreen] bounds];
//            CGFloat x = (arc4random() % (NSInteger)screenBounds.size.width);
//            CGFloat y = (arc4random() % (NSInteger)screenBounds.size.height);
//            NSInteger minSize = 10;
//            NSInteger maxSize = 50;
//            CGFloat size = (arc4random() % (maxSize - minSize + 1)) + minSize;
//            CGRect area = CGRectMake(x, y, size, size);
//            
//            FlowerType flowerType = arc4random() % kTotalNumberOfFlowerTypes;
//            //新建对象
//            UIImageView *imageview = [self flowerViewWithType:flowerType];
//            imageview.frame = area;
//            [self.view addSubview:imageview];
//        }
//    }
}

- (UIImageView *)flowerViewWithType:(FlowerType)type
{
    UIImageView *flowerView = nil;
    UIImage *flowerImage;
    
    switch (type)
    {
        case kAnemone:
            flowerImage = [UIImage imageNamed:@"anemone.png"];
            break;
        case kCosmos:
            flowerImage = [UIImage imageNamed:@"cosmos.png"];
            break;
        case kGerberas:
            flowerImage = [UIImage imageNamed:@"gerberas.png"];
            break;
        case kHollyhock:
            flowerImage = [UIImage imageNamed:@"hollyhock.png"];
            break;
        case kJasmine:
            flowerImage = [UIImage imageNamed:@"jasmine.png"];
            break;
        case kZinnia:
            flowerImage = [UIImage imageNamed:@"zinnia.png"];
            break;
        default:
            break;
    }
        
    flowerView = [[UIImageView alloc]initWithImage:flowerImage];
    
    return flowerView;
}







@end
