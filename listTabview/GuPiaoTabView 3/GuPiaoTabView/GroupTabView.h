//
//  GroupTabView.h
//  GuPiaoTabView
//
//  Created by qlh on 17/2/15.
//  Copyright © 2017年 qlh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupTabView : UIView<UIAppearance>


@property (nonatomic, assign) NSInteger  column;   // 列数
@property (nonatomic, assign) CGFloat    typeWidth; // 块的宽度
@property (nonatomic, assign) CGFloat    rowHeight; // 行高


+ (instancetype)groupFrame:(CGRect)frame
           configGroupView:(void (^)(GroupTabView *gt))configBlock;


@end
