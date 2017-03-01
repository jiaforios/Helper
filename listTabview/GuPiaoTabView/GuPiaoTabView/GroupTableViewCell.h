//
//  GroupTableViewCell.h
//  GuPiaoTabView
//
//  Created by qlh on 17/2/15.
//  Copyright © 2017年 qlh. All rights reserved.
//

#import <UIKit/UIKit.h>
#define COLUMN 11
#define TYPEWIDTH 100
#define TYPEHEIGHT 44

#define SCRREN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCRREN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface GroupTableViewCell : UITableViewCell
@property(nonatomic, strong)NSIndexPath *indexPath;

@end
