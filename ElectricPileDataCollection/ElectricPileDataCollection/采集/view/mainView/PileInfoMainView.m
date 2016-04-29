//
//  PileInfoMainView.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/19.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "PileInfoMainView.h"
#import "CustomCellOne.h"

@implementation PileInfoMainView

- (void)awakeFromNib
{
    self.dataSource = self;
    self.delegate = self;
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCellOne * cell = [CustomCellOne customCellWithTableView:tableView];
    cell.categoryLabel.text=[NSString stringWithFormat:@"电桩信息-%ld", indexPath.row + 1];
    cell.contentLabel.text=@"点击编辑";
    cell.contentLabel.textAlignment = NSTextAlignmentRight;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deselectRowAtIndexPath:indexPath animated:YES];
    [self.mainViewDelegate itemSelectedWithMainView:self andIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    /**
     *  表尾视图
     */
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    _footerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *addImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 20, 20)];
    addImageView.image = [UIImage imageNamed:@"add"];
    
    UILabel *addLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 120, 30)];
    addLabel.text = @"新增电桩信息";
    addLabel.textAlignment = NSTextAlignmentLeft;
    addLabel.font = [UIFont systemFontOfSize:14];
    
    UIImageView *pushImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH - 40, 15, 20, 20)];
    pushImageView.image = [UIImage imageNamed:@"push"];
    
    [_footerView addSubview:addImageView];
    [_footerView addSubview:addLabel];
    [_footerView addSubview:pushImageView];

    /**
     *  手势
     */
    UITapGestureRecognizer *footerViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushVC)];
    _footerView.userInteractionEnabled = YES;
    [_footerView addGestureRecognizer:footerViewTap];
    
    return _footerView;
}

- (void)pushVC
{
    [self.mainViewDelegate pushNextVC];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    if(dataArray){
        _dataArray = dataArray;
        [self reloadData];
    }
}

@end
