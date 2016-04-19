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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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

@end
