//
//  FunctionTableViewController.m
//  Function Model
//
//  Created by foscom on 16/5/16.
//  Copyright © 2016年 foscam. All rights reserved.
//

#import "FunctionTableViewController.h"
#import "CABaseAnimationViewController.h"
#import "CAKeyFrameAnimationVC.h"

#import "testModel.h"
//#import "NSObject+modelConvertDic.h"

@interface FunctionTableViewController ()

@property(nonatomic,strong)NSMutableArray*dataSource;

@end

@implementation FunctionTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    

    
    testModel *mod = [[testModel alloc] init];
    
    mod.name = @"笑话";
    mod.age = 10;
    mod.score = 98;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mod];
//
    testModel *mod1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSLog(@"model.name = %@",mod1.name);

    _dataSource = [[NSMutableArray alloc] init];
    
    [_dataSource addObject:@"CABaseAnimations"];
    [_dataSource addObject:@"CAKeyFrameAnimations"]; // 关键帧动画
    

    

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    cell.textLabel.text = _dataSource[indexPath.row];
    

    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            CABaseAnimationViewController *vc = [[CABaseAnimationViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
        
            
        }
            break;
       case 1:
        {
            
            CAKeyFrameAnimationVC *keyVC= [[CAKeyFrameAnimationVC alloc] init];
            [self.navigationController pushViewController:keyVC animated:YES];
            
        }
            break;
            
        default:
            break;
    }
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
