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



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TYPEWIDTH*COLUMN, TYPEHEIGHT)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.tag = 200;
        [self addSubview:backgroundView];
        for (int i = 0; i<COLUMN; i++) {
            GroupLabel *gl = [[GroupLabel alloc] initWithFrame:CGRectMake(i*TYPEWIDTH, 0, TYPEWIDTH, TYPEHEIGHT)];
            gl.backgroundColor = [UIColor colorWithRed:arc4random()%256/255. green:arc4random()%256/255. blue:arc4random()%256/255. alpha:1];
            gl.columntype = NAME_TYPY + i;
            gl.text  = @(i).stringValue;
            [backgroundView addSubview:gl];
     
            
        }
    }
    
    
    return self;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end











