//
//  ChargeStandardMainView.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/13.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "ChargeStandardMainView.h"

@interface ChargeStandardMainView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ChargeStandardMainView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if(self=[super initWithFrame:frame style:style]){
        self.dataSource=self;
        self.delegate=self;
    }
    return self;
}

#pragma mark - tableView协议代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier=@"TableViewCell";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
        cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    }
    cell.textLabel.textColor=[UIColor colorWithRed:0.223 green:0.410 blue:1.000 alpha:1.000];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    ParkingChargeStandard * pcs = self.dataArray[indexPath.row];
    cell.textLabel.text=pcs.parkingName;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
    addLabel.text = @"新增收费标准";
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.mainViewDelegate itemSelectedWithMainView:self andIndexPath:indexPath];
}

- (void)setDataArray:(NSMutableArray *)dataArray{
    if(dataArray){
        _dataArray=dataArray;
        [self reloadData];
    }
}

- (void)pushVC{
    [self.mainViewDelegate pushNextVC];
}

@end
