//
//  GroupTabView.m
//  GuPiaoTabView
//
//  Created by qlh on 17/2/15.
//  Copyright © 2017年 qlh. All rights reserved.
//

#import "GroupTabView.h"
#import "GroupTableViewCell.h"
#import "GroupLabel.h"

#define LEFTTABVIEW_TAG        1<<2
#define RIGHTTABVIEW_TAG       1<<3
#define DOWNSCROLLVIEW_TAG     1<<4


@interface GroupTabView ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong)UITableView *rightTab;
@property (nonatomic, strong)UITableView *leftTab;
@property (nonatomic, strong)UIScrollView *downSCView;



@end

@implementation GroupTabView


+ (instancetype)groupFrame:(CGRect)frame configGroupView:(void (^)(GroupTabView *gt))configBlock
{
    
    GroupTabView *tabv = [[GroupTabView alloc] initWithFrame:frame];
    
    configBlock?configBlock(tabv):nil;
    
    [tabv addSubview:tabv.downSCView];
    
    [tabv.downSCView addSubview:tabv.rightTab];
    
    tabv.rightTab.frame = CGRectMake(0, 0, tabv.typeWidth * tabv.column, SCRREN_HEIGHT);
    tabv.leftTab.frame  = CGRectMake(0, 0, tabv.typeWidth, SCRREN_HEIGHT);
    
    [tabv addSubview:tabv.leftTab];
    
    return tabv;
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 0) {
        
        if (scrollView.tag == RIGHTTABVIEW_TAG) {
            [self.leftTab setContentOffset:scrollView.contentOffset];
        }else
        {
            [self.rightTab setContentOffset:scrollView.contentOffset];
        }
    }
    
}


#pragma  mark tabview delegate + datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 50.;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    [tableView deselectRowAtIndexPath:indexPath animated:NO]; // 自动清除选中0
    
    if (tableView.tag == RIGHTTABVIEW_TAG) {
        [self.leftTab selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//        [self.leftTab deselectRowAtIndexPath:indexPath animated:NO];    // 自动清除选中1

    }else
    {
        [self.rightTab selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//        [self.rightTab deselectRowAtIndexPath:indexPath animated:NO]; // 自动清除选中2


    }

    
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"asdad");
    return YES;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView.tag == RIGHTTABVIEW_TAG) {
        
        static NSString *headerId = @"headerId";
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
        if (!headerView) {
            headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerId];
            headerView.backgroundView = [[UIView alloc]init];
            headerView.backgroundView.backgroundColor =
            headerView.contentView.backgroundColor    = [UIColor grayColor];
        }
        
        for (int i = 0; i<self.column; i++) {
            GroupLabel *gl = [[GroupLabel alloc] initWithFrame:CGRectMake(i*self.typeWidth, 0, self.typeWidth, 50.)];
            gl.backgroundColor = [UIColor colorWithRed:arc4random()%256/255. green:arc4random()%256/255. blue:arc4random()%256/255. alpha:0.1];
            gl.columntype = NAME_TYPY + i;
            gl.text = @(i).stringValue;
            [headerView.contentView addSubview:gl];
            
        }
        
        return headerView;
    }else
    {
        
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _typeWidth, 50.)];
        label.text = @"标题";
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        return label;
        
    }
    

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == RIGHTTABVIEW_TAG) {
        
        static NSString *cellIndentifier = @"cell";
        
        GroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[GroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            [cell configViewWithWidth:self.typeWidth
                        andRowHeight:self.rowHeight
                           andColumn:self.column];
            
        }
        
        cell.indexPath = indexPath;
        
        return cell;
    }else
    {
        static NSString *cellIndentifier2 = @"cell2";
        
        GroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier2];
        if (cell == nil) {
            cell = [[GroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier2];
            [cell configLeftWithWidth:self.typeWidth andRowHeight:self.rowHeight];
        }
        cell.indexPath = indexPath;

        return cell;
    }
    
    
}


#pragma mark LazyLoad


- (UITableView *)rightTab
{
    if (_rightTab == nil) {
        _rightTab = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTab.delegate = self;
        _rightTab.dataSource = self;
        _rightTab.tag = RIGHTTABVIEW_TAG;
        _rightTab.showsVerticalScrollIndicator = NO;
        _rightTab.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    
    return _rightTab;
}
- (UITableView *)leftTab
{
    if (_leftTab == nil) {
        _leftTab = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTab.delegate = self;
        _leftTab.dataSource = self;
        _leftTab.tag = LEFTTABVIEW_TAG;
        _leftTab.showsVerticalScrollIndicator = NO;
        _leftTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return _leftTab;
}


- (UIScrollView *)downSCView
{
    if (_downSCView == nil) {
        _downSCView = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 0, SCRREN_WIDTH-100, SCRREN_HEIGHT)];
        _downSCView.contentSize = CGSizeMake(self.typeWidth*self.column, SCRREN_HEIGHT);
        _downSCView.delegate = self;
        _downSCView.tag = DOWNSCROLLVIEW_TAG;
        _downSCView.bounces = NO;
        _downSCView.showsHorizontalScrollIndicator = NO;
    }
    
    return _downSCView;
}

@end








