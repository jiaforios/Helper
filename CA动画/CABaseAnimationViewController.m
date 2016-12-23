//
//  CABaseAnimationViewController.m
//  Function Model
//
//  Created by foscom on 16/5/16.
//  Copyright © 2016年 foscam. All rights reserved.
//

#import "CABaseAnimationViewController.h"

#define viewPlaceRect(a) CGRectMake(60, a, 50, 50)
@interface CABaseAnimationViewController ()

@end

@implementation CABaseAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
   
    // 原位缩放动画
    [self initscaleAnimation];
    // 位置移动动画
    [self initMoveAnimation];
    // 原位翻转动画
    [self initRotationAnimation];
    // 动画组
    [self initGroupAnimation];
    
    
    
}


- (void)initscaleAnimation
{
    
    CALayer *scaleLayer = [CALayer layer];
    scaleLayer.frame = viewPlaceRect(100);
    scaleLayer.backgroundColor = [UIColor redColor].CGColor;
    
    [self.view.layer addSublayer:scaleLayer];
    
    CABasicAnimation*scalAnition = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scalAnition.fromValue = [NSNumber numberWithFloat:1.0];
    scalAnition.toValue = [NSNumber numberWithFloat:2.0];
    scalAnition.autoreverses = YES;
    //决定当前对象在非活跃时间段的行为.比如动画开始之前,动画结束之后
    scalAnition.fillMode = kCAFillModeRemoved;
    scalAnition.repeatCount = MAXFLOAT;
    scalAnition.duration = 1;
    [scaleLayer addAnimation:scalAnition forKey:@"scaleAnimation"];
    
    
    
}


- (void)initMoveAnimation
{
    
    CALayer *moveLayer = [CALayer layer];
    moveLayer.frame = viewPlaceRect(150);
    
    moveLayer.backgroundColor = [UIColor redColor].CGColor;
    
    [self.view.layer addSublayer:moveLayer];
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    moveAnimation.fromValue = [NSValue valueWithCGPoint:moveLayer.position];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, moveLayer.position.y + 100)];
    moveAnimation.autoreverses = YES;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.duration = 1;
    [moveLayer addAnimation:moveAnimation forKey:@"moveAnimation"];
    
    
}


- (void)initRotationAnimation
{
    
    CALayer *rotationLayer = [CALayer layer];
    rotationLayer.frame = viewPlaceRect(200);
    rotationLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:rotationLayer];
    
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0.f];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2*M_PI];
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.autoreverses = YES;
    rotationAnimation.duration = 1;
    
    
    [rotationLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    
}



- (void)initGroupAnimation
{
   CALayer * groupLayer = [[CALayer alloc] init];
    groupLayer.frame = CGRectMake(60, 340+100, 50, 50);
    groupLayer.cornerRadius = 10;
    groupLayer.backgroundColor = [[UIColor purpleColor] CGColor];
    [self.view.layer addSublayer:groupLayer];
    
    //设定剧本
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.8;
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:groupLayer.position];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(320 - 80,
                                                                  groupLayer.position.y)];
    moveAnimation.autoreverses = YES;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.duration = 2;
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"]; // 以y轴为中心旋转
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    rotateAnimation.autoreverses = YES;
    rotateAnimation.repeatCount = MAXFLOAT;
    rotateAnimation.duration = 5;
    
    CAAnimationGroup *gropAnimation = [CAAnimationGroup animation];
    gropAnimation.duration = 2;
    gropAnimation.autoreverses = YES;
    gropAnimation.repeatCount = MAXFLOAT;
    gropAnimation.animations = @[moveAnimation, scaleAnimation, rotateAnimation];
    
    [groupLayer addAnimation:gropAnimation forKey:@"gropAnimation"];
    

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
