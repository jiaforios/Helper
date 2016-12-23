//
//  FrameAnd3dViewController.m
//  Function Model
//
//  Created by foscom on 16/7/20.
//  Copyright © 2016年 foscam. All rights reserved.
//

#import "FrameAnd3dViewController.h"
#define frame CGRectMake(20, 20, 300, 300)
@interface FrameAnd3dViewController ()

@end

@implementation FrameAnd3dViewController

- (void)viewDidLoad {
    self.view.backgroundColor =[UIColor whiteColor];
    
    [super viewDidLoad];

    [self makeRotation];
    
}


// CATransform3DMakeRotation 旋转 m34 的透视效果
- (void)makeRotation
{
    
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    iv.image = image;
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 300, 300)];
    view1.backgroundColor = [UIColor redColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"124";
    [view1 addSubview:iv];
    [view1 addSubview:label];
    [self.view addSubview:view1];
    
    // 设置 anchorPoint 和 position 的值 可以改变透视方式
    view1.layer.anchorPoint=CGPointMake(0, 0);
    view1.layer.position = CGPointMake(20, 20);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        /**
         *   CATransform3DMakeRotation (CGFloat angle, CGFloat x,
         CGFloat y, CGFloat z)
         *  angle  旋转角度 x 以x轴为轴旋转 y 以y轴为轴旋转 z 以z轴为轴 旋转
         */
        [UIView animateWithDuration:2 animations:^{
            CATransform3D  sublayer =  CATransform3DMakeRotation(M_PI/3, 1, 0, 0);
            sublayer.m34 = 0.005;
            [view1.layer setTransform:sublayer];
        }];
    });
}



//CATransform3DMakeScale 缩放
-( void)makeScale
{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 300, 300)];
    
    view1.backgroundColor = [UIColor redColor];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        view1.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0);
        
    });
    [self.view addSubview:view1];
}
// 研究CATransform3DMakeTranslation 参数关系
- (void)MakeTranslation
{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 300, 300)];
    
    view1.backgroundColor = [UIColor redColor];
    
    UIView *view2 =[[UIView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    view2.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    
    // 由于图层的先后添加 现在显示是 红在下 绿在上
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 设置了translation 的 tz=1 之后图层向外移动置于红色的上面
        /**
         *
         *
         *  @param tx#> <#tx#>  右 为正 description#>
         *  @param ty#> <#ty#>  下 为正 description#>
         *  @param tz#> <#tz#>  外 为正 description#>
         *
         *  @return
         */
        // CATransform3DMakeTranslation(<#CGFloat tx#>, <#CGFloat ty#>, <#CGFloat tz#>)
        
        
            view1.layer.transform = CATransform3DMakeTranslation(0, 0, 1);

        
    });

    
}

// 研究anchorPoint 特性
- (void)anchorPointView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 300, 300)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    // anchorPoint 是 bounds 相对position 的位置 默认是0.5
    // (0,0)时视图相对(0.5,0.5)右下移
    // (1,1)时视图相对(0.5,0.5)左上移
    
    view.layer.anchorPoint = CGPointMake(0, 0);
    view.layer.position = CGPointMake(10, 20);
    // 视图的左上角作为相对点
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 实现效果是
        
        [UIView animateWithDuration:1 animations:^{
            
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
            
        }];
        
        
    });

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
