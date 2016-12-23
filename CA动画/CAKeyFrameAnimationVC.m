//
//  CAKeyFrameAnimationVC.m
//  Function Model
//
//  Created by foscom on 16/5/16.
//  Copyright © 2016年 foscam. All rights reserved.
//

#import "CAKeyFrameAnimationVC.h"
#define viewPlaceRect(a) CGRectMake(60, a, 50, 50)

@interface CAKeyFrameAnimationVC ()

@end

@implementation CAKeyFrameAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self keyAnimation];
    
}


- (void)keyAnimation
{
    
    
    CALayer *rotationLayer = [CALayer layer];
    rotationLayer.frame = viewPlaceRect(200);
    rotationLayer.backgroundColor = [UIColor redColor].CGColor;
    
    rotationLayer.cornerRadius = 15;
    
    
    [self.view.layer addSublayer:rotationLayer];
    

    CGPoint fromPoint = CGPointZero;
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(360, 360);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(100,100)];

    
    //关键帧
//    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
//

    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = YES;
    moveAnim.duration = 5;
    moveAnim.repeatCount = MAXFLOAT;
//    moveAnim.delegate = self;
    moveAnim.autoreverses = YES;
    
    [rotationLayer addAnimation:moveAnim forKey:@"keyMoveAnimation"];
    
    
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
