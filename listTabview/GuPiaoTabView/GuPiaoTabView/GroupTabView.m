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
@interface GroupTabView ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)UITableView *leftTab;
@property(nonatomic,strong)UITableView *rightTab;
@property(nonatomic,strong)UIScrollView *downSCView;

@end


@implementation GroupTabView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.downSCView];
        
        self.rightTab.frame = CGRectMake(0, 0, TYPEWIDTH*COLUMN, SCRREN_HEIGHT);
        [self.downSCView addSubview:self.rightTab];
        
    }
    
    return self;
}

#pragma  mark tabview delegate + datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    static NSString *headerId = @"headerId";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerId];
        headerView.backgroundView = [[UIView alloc]init];
        headerView.backgroundView.backgroundColor =
        headerView.contentView.backgroundColor    = [UIColor grayColor];
    }
    
    for (int i = 0; i<COLUMN; i++) {
        GroupLabel *gl = [[GroupLabel alloc] initWithFrame:CGRectMake(i*TYPEWIDTH, 0, TYPEWIDTH, 50.)];
        gl.backgroundColor = [UIColor colorWithRed:arc4random()%256/255. green:arc4random()%256/255. blue:arc4random()%256/255. alpha:0.1];
        gl.columntype = NAME_TYPY + i;
        gl.text = @(i).stringValue;
        [headerView.contentView addSubview:gl];

        
    }
    
    return headerView;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    
    GroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[GroupTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
    
    }
    cell.indexPath = indexPath;

    return cell;
    
}


#pragma mark scrollview


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    if (scrollView.tag == 1000) {
        
        NSArray *cellArr = [self.rightTab visibleCells];
        NSMutableSet *sectionSet = [[NSMutableSet alloc]init];

        [cellArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            GroupTableViewCell *cell = (GroupTableViewCell *)obj;
            [sectionSet addObject:@(cell.indexPath.section)];

            UIView *view = [cell viewWithTag:200];
            
            NSArray *arr = [view subviews];
            [arr enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
                GroupLabel *lbel = (GroupLabel *)obj;
                
                if (lbel.columntype == NAME_TYPY) {

                    lbel.frame =  CGRectMake(offset.x, lbel.frame.origin.y, lbel.frame.size.width, lbel.frame.size.height);
                    [view bringSubviewToFront:lbel];
                }
                
            }];
            
        }];
        
        for (NSNumber *section in sectionSet) {
            UITableViewHeaderFooterView *headerView = [self.rightTab headerViewForSection:[section integerValue]];
            
            [[headerView.contentView subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                GroupLabel *label = (GroupLabel *)obj;
                if (label.columntype == NAME_TYPY) {
                    
                    label.frame =  CGRectMake(offset.x, label.frame.origin.y, label.frame.size.width, label.frame.size.height);
                    [headerView.contentView bringSubviewToFront:label];
                }
                
                
            }];
            
        }
    
        
        
    }
}


#pragma mark LazyLoad

- (UITableView *)leftTab
{
    if (_leftTab == nil) {
        _leftTab = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTab.delegate = self;
        _leftTab.dataSource = self;
    }
    
    return _leftTab;
}

- (UITableView *)rightTab
{
    if (_rightTab == nil) {
        _rightTab = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTab.delegate = self;
        _rightTab.dataSource = self;
        _rightTab.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    
    return _rightTab;
}


- (UIScrollView *)downSCView
{
    if (_downSCView == nil) {
        _downSCView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCRREN_WIDTH, SCRREN_HEIGHT)];
        _downSCView.contentSize = CGSizeMake(TYPEWIDTH*COLUMN, SCRREN_HEIGHT);
        _downSCView.delegate = self;
        _downSCView.tag = 1000;
        _downSCView.bounces = NO;
    }
    
    return _downSCView;
}

@end








