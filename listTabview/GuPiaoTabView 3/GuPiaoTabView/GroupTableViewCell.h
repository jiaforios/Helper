//
//  GroupTableViewCell.h
//  GuPiaoTabView
//
//  Created by qlh on 17/2/15.
//  Copyright © 2017年 qlh. All rights reserved.
//

#import <UIKit/UIKit.h>


#define SCRREN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCRREN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface GroupTableViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath   *indexPath;

- (void)configViewWithWidth:(CGFloat)typeWidth
              andRowHeight:(CGFloat)rowHeight
                 andColumn:(NSInteger)column;

- (void)configLeftWithWidth:(CGFloat)typeWidth
               andRowHeight:(CGFloat)rowHeight;


@end
