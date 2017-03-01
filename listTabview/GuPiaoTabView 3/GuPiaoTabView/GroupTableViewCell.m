//
//  GroupTableViewCell.m
//  GuPiaoTabView
//
//  Created by qlh on 17/2/15.
//  Copyright © 2017年 qlh. All rights reserved.
//

#import "GroupTableViewCell.h"
#import "GroupLabel.h"


@implementation GroupTableViewCell


- (void)configViewWithWidth:(CGFloat)typeWidth
              andRowHeight:(CGFloat)rowHeight
                 andColumn:(NSInteger)column
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, typeWidth*column, rowHeight)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundView];
    for (int i = 0; i<column; i++) {
        GroupLabel *gl = [[GroupLabel alloc] initWithFrame:CGRectMake(i*typeWidth, 0, typeWidth, rowHeight)];
        gl.backgroundColor = [UIColor colorWithRed:arc4random()%256/255. green:arc4random()%256/255. blue:arc4random()%256/255. alpha:1];
        gl.columntype = NAME_TYPY + i;
        gl.text  = @(i).stringValue;
        [backgroundView addSubview:gl];
    }
}


- (void)configLeftWithWidth:(CGFloat)typeWidth
               andRowHeight:(CGFloat)rowHeight
{
    GroupLabel *label  = [[GroupLabel alloc] initWithFrame:CGRectMake(0, 0, typeWidth, rowHeight)];
    label.text = @"标题";
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end











